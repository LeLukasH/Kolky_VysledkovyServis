import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/colors.dart';

class Komentar extends StatefulWidget {
  const Komentar({super.key, required this.text});

  final String text;

  @override
  State createState() => _KomentarState();
}

class _KomentarState extends State<Komentar> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    const limit = 200;
    super.initState();
    if (widget.text.length > limit) {
      firstHalf = widget.text.substring(0, limit);
      secondHalf = widget.text.substring(limit);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            flag = !flag;
          });
        },
        child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.insert_comment_outlined,
                        color: secondaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Komentár',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  secondHalf.isEmpty
                      ? Text(
                          widget.text,
                        )
                      : Column(
                          children: [
                            Text(flag ? "$firstHalf..." : widget.text),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  flag ? "Viac" : "Menej",
                                  style: const TextStyle(color: primaryColor),
                                ),
                                Icon(
                                    flag
                                        ? Icons.keyboard_arrow_down_outlined
                                        : Icons.keyboard_arrow_up_outlined,
                                    color: primaryColor)
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            )));
  }
}
