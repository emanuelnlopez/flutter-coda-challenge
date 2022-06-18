import 'package:crud/src/ui/ui.dart';
import 'package:flutter/material.dart';

class MinimalTextFormField extends StatefulWidget {
  const MinimalTextFormField({
    required this.controller,
    super.key,
    required this.label,
    this.obscureText = false,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final FormFieldValidator<String> validator;

  @override
  State<MinimalTextFormField> createState() => _MinimalTextFormFieldState();
}

class _MinimalTextFormFieldState extends State<MinimalTextFormField> {
  bool _showContent = true;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(
            Spacing.xsmall,
          ),
          labelText: widget.label,
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: () => setState(
                    () => _showContent = !_showContent,
                  ),
                  child: Icon(
                    !_showContent ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                )
              : null,
        ),
        obscureText: widget.obscureText ? _showContent : !_showContent,
        validator: widget.validator,
      );
}
