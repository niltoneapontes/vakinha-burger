import 'package:flutter/material.dart';

class VakinhaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double? width;
  final double? height;
  final Colors? color;

  const VakinhaButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
    this.height = 47,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}
