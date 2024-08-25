import 'package:flutter/material.dart';
import 'package:todo3/auth/login.dart';
import 'package:todo3/widgets/custom_elevated_bottom.dart';
import 'package:todo3/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Name can not be less than 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
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
              CustomElevatedBottom(
                  label: 'Create Account', onPressed: register),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName),
                child: const Text('Already have an account ?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formState.currentState!.validate()) {}
  }
}
