import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.black,
      splashColor: Colors.redAccent,
      onPressed: onPressed,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
