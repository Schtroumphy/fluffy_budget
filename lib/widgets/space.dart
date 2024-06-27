import 'package:flutter/material.dart';

class HSpace extends StatelessWidget {
  const HSpace(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class VSpace extends StatelessWidget {
  const VSpace(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

// Vertical spaces
const gapV4  = VSpace(4);
const gapV6  = VSpace(6);
const gapV8  = VSpace(8);
const gapV12 = VSpace(12);
const gapV16 = VSpace(16);
const gapV18 = VSpace(18);
const gapV20 = VSpace(20);
const gapV24 = VSpace(24);

// Horizontal spaces
const gapH4  = HSpace(4);
const gapH6  = HSpace(6);
const gapH8  = HSpace(8);
const gapH12 = HSpace(12);
const gapH16 = HSpace(16);
const gapH18 = HSpace(18);
const gapH20 = HSpace(20);
const gapH24 = HSpace(24);
