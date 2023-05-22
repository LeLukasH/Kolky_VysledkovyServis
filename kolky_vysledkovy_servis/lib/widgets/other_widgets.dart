import 'package:flutter/material.dart';

import '../assets/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        child: child,
      ),
    );
  }
}

class CustomContainerWithOutPadding extends StatelessWidget {
  const CustomContainerWithOutPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
      child: child,
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
            Icon(
              icon,
              color: secondaryColor,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: primaryColor)),
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

class CustomBoxVertical extends StatelessWidget {
  const CustomBoxVertical({super.key, required this.text, required this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

class CustomBoxHorizontal extends StatelessWidget {
  const CustomBoxHorizontal(
      {super.key, required this.text, required this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;

  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.textStyle,
      required this.text,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      child: Text(
        text,
        textAlign: textAlign,
        style: textStyle.apply(decoration: TextDecoration.underline),
      ),
    );
  }
}
