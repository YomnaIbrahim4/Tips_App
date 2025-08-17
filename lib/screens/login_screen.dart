import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up/utils/app_strings.dart';
import '../login_bloc/login_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';
import 'sign_up_screen.dart';

class LoginScreenWithBloc extends StatefulWidget {
  static String routeName = "login";
  const LoginScreenWithBloc({super.key});

  @override
  State<LoginScreenWithBloc> createState() => _LoginScreenWithBlocState();
}

class _LoginScreenWithBlocState extends State<LoginScreenWithBloc> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text(
          AppStrings.loginTitle,
      )),
        backgroundColor: Colors.amber,),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen(email: state.email)),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: emailController,
                    labelText: "Email",
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    controller: passwordController,
                    labelText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    text: "Log In",
                    onPressed: () {
                      context.read<LoginBloc>().add(
                        LoginSubmittedEvent(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreenWithBloc()),
                      );
                    },
                    child: const Text("Create an account",
                      style: TextStyle(
                          color: Colors.black,
                        fontSize: 15
                      ),),
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
