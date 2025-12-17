import 'package:flutter/material.dart';

class CategoryCart extends StatelessWidget {
  final IconData icon;
  final String label;
  final double amount;
  
  const CategoryCart({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 32),
        SizedBox(height: 8),
        Text("${amount.toStringAsFixed(2)}\$", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}