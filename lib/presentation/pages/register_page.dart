import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/bloc/register/register_bloc.dart';
import 'package:flutter_auth_bloc/data/models/request/register_mode.dart';
import 'package:flutter_auth_bloc/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: nameController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              controller: passwordController,
            ),
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoaded) {
                  nameController!.clear();
                  emailController!.clear();
                  passwordController!.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(
                          'Success Register with id : ${state.registerResponseModel.id}'),
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));

                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const LoginPage()));
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final requestModel = RegisterModel(
                      name: nameController!.text,
                      email: emailController!.text,
                      password: passwordController!.text,
                    );

                    context
                        .read<RegisterBloc>()
                        .add(SaveRegisterEvent(request: requestModel));
                  },
                  child: const Text('Register'),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              child: const Text(
                'Belum punya akun? Register',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
