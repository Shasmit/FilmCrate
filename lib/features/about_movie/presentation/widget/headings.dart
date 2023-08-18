import 'package:flutter/material.dart';

class Headings extends StatelessWidget {
  final String? title;
  final double? width;
  const Headings({super.key, this.title, this.width});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return SizedBox(
      width: width!,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Text(
          title!,
          style: TextStyle(
            fontFamily: 'Dongle',
            fontSize: isTablet ? 60 : 40,
            // fontWeight: FontWeight.bold,
            letterSpacing: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
