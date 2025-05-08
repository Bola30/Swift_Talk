import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_talk_2/core/utils/costants.dart';
import 'package:swift_talk_2/pages/cubits/cubit/signup_cubit/signup_cubit.dart';
import 'package:swift_talk_2/widgets/textField.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../auth/auth_services.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _authService = AuthService();

  SignUpPage({super.key});

  void _handleSignUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await _authService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        phone: _phoneController.text.trim(),
      );

      Navigator.pop(context); // Close the loading dialog
      _showSuccessDialog(context);
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      _showErrorDialog(context, e.toString());
    }
  }

  void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Account Created',
      desc:
          'Your account has been created successfully! Please verify your email.',
      descTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      btnOkOnPress: () {
        Navigator.pushReplacementNamed(context, 'ChatPage');
      },
      btnOkColor: Colors.green,
    ).show();
  }

  void _showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Sign Up Error',
      descTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      desc: message,
      btnOkOnPress: () {},
      btnOkColor: Colors.red,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    String selectedCountryCode = '+20';
    List<String> countryCodes = ['+20', '+966', '+1', '+44'];
    bool obscurePassword = true;

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          CircularProgressIndicator(color: AppInfo.kPrimaryColor2);
        } else if (state is SignUpSuccess) {
          Navigator.pushNamed(context, 'ChatPage');
        } else if (state is SignUpFailure) {
          _showErrorDialog(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppInfo.kPrimaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 30),

                    Image.asset(AppInfo.kLogo, height: 200, width: 250),

                    const SizedBox(height: 20),

                    Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppInfo.kPrimaryColor2,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Phone Field
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppInfo.kPrimaryColor2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(canvasColor: Colors.white),
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return DropdownButton<String>(
                                  style: const TextStyle(
                                    fontFamily: 'PTSerif',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  value: selectedCountryCode,
                                  underline: const SizedBox(),
                                  items:
                                      countryCodes.map((code) {
                                        return DropdownMenuItem<String>(
                                          value: code,
                                          child: Text(
                                            code,
                                            style: const TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedCountryCode = value;
                                      });
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Phone Field
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Phone",
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            prefixIcon: Icons.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (value.length < 9) {
                                return 'Phone number must be at least 9 digits';
                              }
                              return null;
                            },
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

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
                    StatefulBuilder(
                      builder: (context, setState) {
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
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
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
                    BlocConsumer<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                        if (state is SignUpLoading) {
                          Navigator.pushReplacementNamed(
                            context,
                            'ChatPage',
                            arguments: _emailController.text.trim(),
                          );
                        } else if (state is SignUpFailure) {
                          _showErrorDialog(context, state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is SignUpCubit;

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
                                      final phone =
                                          _phoneController.text.trim();
                                      context.read<SignUpCubit>().signUp(
                                        email: email,
                                        password: password,
                                        phone: phone,
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
                                    color: Colors.white,
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
                          'Have an account?',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'LoginPage');
                          },
                          child: Text(
                            ' LogIn',
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
        );
      },
    );
  }
}
