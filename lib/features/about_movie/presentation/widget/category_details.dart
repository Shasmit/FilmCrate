import 'package:flutter/material.dart';

class CategoryDetials extends StatelessWidget {
  final String? title;
  final String? value;
  const CategoryDetials({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
            fontFamily: 'Dongle',
            fontSize: isTablet ? 35 : 25,
            color: Colors.black87,
          ),
        ),
        Text(
          value!,
          style: TextStyle(
            fontFamily: 'Dongle',
            fontSize: isTablet ? 35 : 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
