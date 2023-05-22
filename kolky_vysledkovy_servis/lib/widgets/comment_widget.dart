import 'package:flutter/material.dart';

import '../assets/colors.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, required this.text});

  final String text;

  @override
  State createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    const limit = 170;
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
    if (widget.text.isEmpty) return Container();
    return secondHalf.isEmpty
        ? Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        : TextButton(
            onPressed: () {
              setState(() {
                flag = !flag;
              });
            },
            child: Column(
              children: [
                Text(
                  flag ? "         $firstHalf..." : "         ${widget.text}",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      flag ? "Viac" : "Menej",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: primaryColor)
                          .apply(decoration: TextDecoration.underline),
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
          );
  }
}
