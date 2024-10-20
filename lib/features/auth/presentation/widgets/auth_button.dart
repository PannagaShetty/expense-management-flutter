import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/common/widgets/tapable.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.onTap, required this.buttonText, this.isLoading = false});
  final Function()? onTap;
  final String buttonText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Tapable(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: isLoading ? 65 : double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isLoading ? 65 : 8),
          gradient: const LinearGradient(
            colors: [
              AppColors.gradient1,
              AppColors.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  buttonText,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
        ),
      ),
    );
  }
}
