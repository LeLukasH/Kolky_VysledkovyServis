import 'package:flutter/material.dart';
import '../all_assets.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 3),
          )
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({super.key, required this.icon, required this.name});

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              child: Icon(
                icon,
                color: secondaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
