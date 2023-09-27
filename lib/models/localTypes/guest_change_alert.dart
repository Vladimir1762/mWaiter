import 'package:flutter/material.dart';
import 'package:restismob/global.dart' as global;

class GuestAlert extends StatefulWidget {
  final int guest;

  const GuestAlert({super.key, required this.guest});

  @override
  State<GuestAlert> createState() => GuestAlertState();
}

class GuestAlertState extends State<GuestAlert> {
  int cGuest = 0;

  @override
  void initState() {
    cGuest = widget.guest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: SizedBox(
            height: 150,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const Text('Гость',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w800,
                  )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          cGuest = cGuest - 1;
                          if (cGuest <= 0) {
                            cGuest = 0;
                          }
                          setState(() {});
                        },
                        icon: const Icon(Icons.remove_circle_outline_rounded)),
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text(cGuest == 0 ? 'Общий' : '$cGuest',
                          style: cGuest == 0
                              ? const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w800,
                                )
                              : const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w800,
                                )),
                    ),
                    IconButton(
                        onPressed: () {
                          cGuest = cGuest + 1;
                          if (cGuest > global.currentBill.root!.billHead!.head!.guestscount! + 1) {
                            cGuest = global.currentBill.root!.billHead!.head!.guestscount! + 1;
                          }
                          setState(() {});
                        },
                        icon: const Icon(Icons.add_circle_outline_rounded)),
                  ],
                ),
              ),
            ])),
    actionsAlignment: MainAxisAlignment.spaceBetween,
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Отмена",
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
      TextButton(
          onPressed: () {
            Navigator.pop(context, cGuest);
          },
          child: const Text(
            "Сохранить",
            style: TextStyle(color: Colors.green),
          )),
    ],);
  }
}
