import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/extensions/spacing_extension.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/features/auth/presentation/sign_up_page.dart';
import 'package:myapp/features/auth/presentation/widgets/auth_button.dart';
import 'package:myapp/features/auth/presentation/widgets/auth_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              24.verticalSpace,
              AuthField(
                controller: _emailController,
                hintText: 'Email',
              ),
              16.verticalSpace,
              AuthField(
                obscureText: true,
                controller: _passwordController,
                hintText: 'Password',
              ),
              24.verticalSpace,
              AuthButton(
                buttonText: 'Sign In',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                  }
                },
              ),
              24.verticalSpace,
              RichText(
                  text: TextSpan(
                text: 'Already have an account?  ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
