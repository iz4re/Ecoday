import 'package:flutter/material.dart';

class EcoInputField extends StatefulWidget {
  const EcoInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.controller,
    this.validator,
  });

  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<EcoInputField> createState() => _EcoInputFieldState();
}

class _EcoInputFieldState extends State<EcoInputField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2E2B),
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _obscureText,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: const Color(0xFF7B8B8C)),
            suffixIcon: widget.obscure
                ? IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                  )
                : null,
            hintText: widget.hint,
            errorMaxLines: 2,
            errorStyle: const TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }
}
