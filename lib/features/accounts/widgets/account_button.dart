import 'package:flutter/material.dart';

class AccountButtton extends StatelessWidget {
  const AccountButtton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 0.0,
            ),
            borderRadius: BorderRadius.circular(100),
            color: Colors.white),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
