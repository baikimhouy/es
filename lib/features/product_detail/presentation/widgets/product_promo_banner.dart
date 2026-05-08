import 'package:flutter/material.dart';

class ProductPromoBanner extends StatelessWidget {
  const ProductPromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Container(
        height: 831,
        width: 401,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 24,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            'assets/images/banner.gif',
            fit: BoxFit.cover,
            alignment: const Alignment(0, 0.22),
          ),
        ),
      ),
    );
  }
}
