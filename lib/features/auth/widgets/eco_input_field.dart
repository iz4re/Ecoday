import 'package:flutter/material.dart';

class EcoInputField extends StatelessWidget {
  const EcoInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
  });

  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2E2B),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscure,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF7B8B8C)),
            suffixIcon: obscure
                ? IconButton(
                    splashRadius: 18,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  )
                : null,
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
