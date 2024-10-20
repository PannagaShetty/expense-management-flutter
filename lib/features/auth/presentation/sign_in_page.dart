import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/extensions/spacing_extension.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/utils/show_snackbar.dart';
import 'package:myapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myapp/features/auth/presentation/sign_up_page.dart';
import 'package:myapp/features/auth/presentation/widgets/auth_button.dart';
import 'package:myapp/features/auth/presentation/widgets/auth_field.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = 'signIn';
  static const String routePath = '/signIn';

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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSankBar(context, state.message);
            }
          },
          builder: (context, state) {
            return Form(
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
                    isLoading: state is AuthLoading,
                    buttonText: 'Sign In',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
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
                        recognizer: TapGestureRecognizer()..onTap = () => context.go(SignUpPage.routePath),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
