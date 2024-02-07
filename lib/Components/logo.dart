import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;
  const Logo({super.key, required this.imageHeight, required this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/tripista_logo.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
          height: imageHeight,
          width: imageWidth,
        ),
      ],
    );
  }
}
