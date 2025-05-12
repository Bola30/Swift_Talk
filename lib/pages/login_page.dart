import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_talk_2/core/utils/costants.dart';
import 'package:swift_talk_2/pages/cubits/cubit/login_cubit.dart';
import 'package:swift_talk_2/widgets/textField.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});

  void _showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Login Error',
      desc: message,
      btnOkOnPress: () {},
      btnOkColor: Colors.red,
      descTextStyle: const TextStyle(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          CircularProgressIndicator(color: AppInfo.kPrimaryColor2);
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, 'ChatPage');
        } else if (state is LoginFailure) {
          _showErrorDialog(context, state.errorMessage);
        }
      },
      builder:
          (context, state) => Scaffold(
            backgroundColor: AppInfo.kPrimaryColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 70),

                      Image.asset(AppInfo.kLogo, height: 200, width: 250),

                      const SizedBox(height: 30),

                      Text(
                        "LogIn",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppInfo.kPrimaryColor2,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Email Field
                      CustomTextFormField(
                        labelText: "Email",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        obscureText: false,
                      ),

                      const SizedBox(height: 15),

                      // Password Field
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          bool obscurePassword = true;
                          if (state is LoginObscurePasswordToggled) {
                            obscurePassword = state.obscurePassword;
                          }

                          return CustomTextFormField(
                            labelText: "Password",
                            controller: _passwordController,
                            prefixIcon: Icons.lock,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppInfo.kPrimaryColor2,
                              ),
                              onPressed: () {
                                context
                                    .read<LoginCubit>()
                                    .toggleObscurePassword();
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'Password must contain at least one uppercase letter';
                              }
                              if (!value.contains(RegExp(r'[0-9]'))) {
                                return 'Password must contain at least one number';
                              }
                              return null;
                            },
                            obscureText: obscurePassword,
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            Navigator.pushReplacementNamed(
                              context,
                              'ChatPage',
                              arguments: _emailController.text.trim(),
                            );
                          } else if (state is LoginFailure) {
                            _showErrorDialog(context, state.errorMessage);
                          }
                        },
                        builder: (context, state) {
                          final isLoading = state is LoginLoading;

                          return ElevatedButton(
                            onPressed:
                                isLoading
                                    ? null
                                    : () {
                                      if (_formKey.currentState!.validate()) {
                                        final email =
                                            _emailController.text.trim();
                                        final password =
                                            _passwordController.text.trim();
                                        context.read<LoginCubit>().login(
                                          email,
                                          password,
                                        );
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppInfo.kPrimaryColor2,
                              maximumSize: const Size(100, 63),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child:
                                isLoading
                                    ? const CircularProgressIndicator(
                                      color: AppInfo.kPrimaryColor2,
                                    )
                                    : const Text(
                                      'LogIn',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'PTSerif',
                                      ),
                                    ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'SignupPage');
                            },
                            child: Text(
                              ' Sign Up',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppInfo.kPrimaryColor2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}