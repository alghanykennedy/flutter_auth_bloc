import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:flutter_auth_bloc/bloc/profile/profile_bloc.dart';
import 'package:flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:flutter_auth_bloc/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home - Profile'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthLocalStorage().removeToken();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.profile.name ?? ''),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(state.profile.email ?? '')
                ],
              );
            }
            return const Text('No data');
          }),
          Expanded(child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
            builder: (context, state) {
              if (state is GetAllProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetAllProductLoaded) {
                return ListView.builder(itemBuilder: ((context, index) {
                  final product = state.listProduct.reversed.toList()[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${product.price}')),
                      title: Text(product.title ?? '-'),
                      subtitle: Text(product.description ?? '-'),
                    ),
                  );
                }));
              }
              return const Text('gg');
            },
          ))
        ],
      ),
    );
  }
}
