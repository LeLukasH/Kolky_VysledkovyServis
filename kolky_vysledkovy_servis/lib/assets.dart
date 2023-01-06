import 'package:flutter/material.dart';

double assetsPadding = 20.0;

MaterialColor secondaryColorSwatch = const MaterialColor(
  0xFFc12428,
  <int, Color>{
    50: Color(0xFFc12428),
    100: Color(0xFFc12428),
    200: Color(0xFFc12428),
    300: Color(0xFFc12428),
    400: Color(0xFFc12428),
    500: Color(0xFFc12428),
    600: Color(0xFFc12428),
    700: Color(0xFFc12428),
    800: Color(0xFFc12428),
    900: Color(0xFFc12428),
  },
);

MaterialColor primaryColorSwatch = const MaterialColor(
  0xFF0a7ec2,
  <int, Color>{
    50: Color(0xFF0a7ec2),
    100: Color(0xFF0a7ec2),
    200: Color(0xFF0a7ec2),
    300: Color(0xFF0a7ec2),
    400: Color(0xFF0a7ec2),
    500: Color(0xFF0a7ec2),
    600: Color(0xFF0a7ec2),
    700: Color(0xFF0a7ec2),
    800: Color(0xFF0a7ec2),
    900: Color(0xFF0a7ec2),
  },
);

const secondaryColor = Color(0xFFc12428);
const primaryColor = Color(0xFF0a7ec2);

MaterialColor whiteColorSwatch = const MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

String convertDateTime(DateTime dateTime) {
  dateTime = dateTime.add(dateTime.timeZoneOffset);
  String convertedTime =
      "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year.toString()} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  return convertedTime;
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
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
