import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up/utils/app_strings.dart';
import '../signup_bloc/signup_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignUpScreenWithBloc extends StatefulWidget {
  static String routeName = "signup";
  const SignUpScreenWithBloc({super.key});

  @override
  State<SignUpScreenWithBloc> createState() => _SignUpScreenWithBlocState();
}

class _SignUpScreenWithBlocState extends State<SignUpScreenWithBloc> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();


  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text("Sign Up")),backgroundColor: Colors.amber,),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(
                  email: emailController.text.trim(),
                ),
              ),
            );
          }
          else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: nameController,
                    labelText: "Name",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    labelText: AppStrings.emailLabel,
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    controller: passwordController,
                    labelText: AppStrings.passwordLabel,
                    obscureText: true,
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    text: AppStrings.signUpTitle,
                    onPressed: () {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter your name")),
                        );
                        return;
                      }

                      if (!isValidEmail(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter a valid email")),
                        );
                        return;
                      }

                      if (password.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password must be at least 6 characters")),
                        );
                        return;
                      }

                      BlocProvider.of<SignUpBloc>(context).add(
                        SignUpSubmittedEvent(
                          name: name,
                          email: email,
                          password: password,
                        ),
                      );

                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
