import 'package:crud/src/ui/ui.dart';
import 'package:flutter/material.dart';

class MinimalElevatedButton extends StatelessWidget {
  const MinimalElevatedButton({
    this.height,
    super.key,
    required this.label,
    this.onPressed,
    this.width,
  });

  final double? height;
  final String label;
  final VoidCallback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            width ?? double.infinity,
            height ?? Spacing.large * 2,
          ),
          padding: EdgeInsets.zero,
          primary: AppColors.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34.0),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label),
      );
}
