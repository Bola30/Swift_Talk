import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/costants.dart';
import 'package:swift_talk_2/widgets/textField.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../auth/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _selectedCountryCode = '+20';
  final List<String> _countryCodes = ['+20', '+966', '+1', '+44'];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        phone: _phoneController.text.trim(),
      );

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Account Created',
      desc:
          'Your account has been created successfully! Please verify your email.',
      descTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      btnOkOnPress: () {
        Navigator.pushReplacementNamed(context, 'ChatPage');
      },
      btnOkColor: Colors.green,
    ).show();
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Sign Up Error',
      descTextStyle: TextStyle(
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
                        child: DropdownButton<String>(
                          style: const TextStyle(
                            fontFamily: 'PTSerif',
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          value: _selectedCountryCode,
                          underline: const SizedBox(),
                          items:
                              _countryCodes.map((code) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(
                                    code,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedCountryCode = value;
                              });
                            }
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
                CustomTextFormField(
                  labelText: "Password",
                  controller: _passwordController,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppInfo.kPrimaryColor2,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
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
                  obscureText: _obscurePassword,
                ),

                const SizedBox(height: 30),

                // Sign Up Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppInfo.kPrimaryColor2,
                    maximumSize: const Size(100, 63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(
                            color: AppInfo.kPrimaryColor2,
                          )
                          : const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'PTSerif',
                            ),
                          ),
                ),

                const SizedBox(height: 10),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'have an account?',
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppInfo.kPrimaryColor2,
                        ),
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
  }
}
