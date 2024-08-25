import 'package:flutter/material.dart';
import 'package:todo3/auth/register.dart';
import 'package:todo3/widgets/custom_elevated_bottom.dart';
import 'package:todo3/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return 'Email can not be less than 8 characters';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                  isPassword: true,
                  controller: passwordController,
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Password can not be less than 8 characters';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 32,
              ),
              CustomElevatedBottom(label: 'Login', onPressed: login),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(RegisterScreen.routeName),
                child: const Text("Don't have an account ?"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formState.currentState!.validate()) {}
  }
}
