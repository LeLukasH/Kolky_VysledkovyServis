import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/colors.dart';

class Zapasy extends StatelessWidget {
  const Zapasy({super.key, required this.zapasy});

  final List<Zapas> zapasy;

  @override
  Widget build(BuildContext context) {
    List<Widget> zapasyWidget = [];
    for (int i = 0; i < zapasy.length; i++) {
      if (i != 0) {
        zapasyWidget.add(const Divider(
          height: 15,
        ));
      }
      zapasyWidget.add(zapasy[i]);
    }
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: const [
                Icon(
                  Icons.sports_outlined,
                  color: secondaryColor,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Zápasy',
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
              height: 10,
            ),
            Column(
              children: zapasyWidget,
            )
          ]),
        ));
  }
}

class Zapas extends StatelessWidget {
  const Zapas(
      {super.key,
      required this.domaci,
      required this.hostia,
      required this.hasBeenPlayed,
      this.domaciBody,
      this.domaciSpolu,
      this.hostiaBody,
      this.hostiaSpolu,
      this.date});

  final String domaci;
  final String hostia;
  final bool hasBeenPlayed;
  final date;
  final domaciSpolu;
  final hostiaSpolu;
  final domaciBody;
  final hostiaBody;

  @override
  Widget build(BuildContext context) {
    return hasBeenPlayed
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(domaci),
                  Text(hostia),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(domaciSpolu.toString()),
                  Text(hostiaSpolu.toString()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    domaciBody.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    hostiaBody.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          )
        : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(domaci),
                Text(hostia),
              ],
            ),
            Text(date)
          ]);
  }
}
