import 'package:crud/src/ui/ui.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlurredBackground(
          color: AppColors.primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.accentColor,
                ),
                if (message?.isNotEmpty == true) ...[
                  const SizedBox(height: Spacing.xlarge),
                  Text(message!),
                ],
              ],
            ),
          ),
        ),
      );
}
