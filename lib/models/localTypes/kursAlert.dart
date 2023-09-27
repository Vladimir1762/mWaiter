import 'package:flutter/material.dart';

class KursAlert extends StatefulWidget {
  final List<int> kurss;

  const KursAlert({super.key, required this.kurss});

  @override
  State<KursAlert> createState() => KursAlertState();
}

class KursAlertState extends State<KursAlert> {
  Color color2 = Colors.black45;
  Color color3 = Colors.black45;
  int kurs = 0;

  @override
  Widget build(BuildContext context) {
    if (kurs == 0) {
      kurs = widget.kurss[0];
    }
    switch (kurs) {
      case 2:
        {
          color2 = Colors.blueAccent;
          color3 = Colors.black45;
        }
        break;
      case 3:
        {
          color2 = Colors.black45;
          color3 = Colors.blueAccent;
        }
        break;
    }
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Выберите курс',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w800,
                )),
            const Divider(
              thickness: 3,
              color: Colors.black54,
            ),
            const Row(
              children: [
                Text(
                  ' ',
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Курс',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: widget.kurss.contains(2)
                      ? ClipOval(
                          child: Material(
                            color: color2,
                            child: InkWell(
                              onTap: () {
                                if (widget.kurss.contains(2)) {
                                  setState(() {
                                    kurs = 2;
                                  });
                                } else {
                                  null;
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text('2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w800,
                                    )),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: widget.kurss.contains(3)
                      ? ClipOval(
                          child: Material(
                            color: color3,
                            child: InkWell(
                              onTap: () {
                                if (widget.kurss.contains(3)) {
                                  setState(() {
                                    kurs = 3;
                                  });
                                } else {
                                  null;
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text('3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w800,
                                    )),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  ' ',
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                      Navigator.pop(context, kurs);
                    },
                    child: const Text(
                      "Сохранить",
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            )
          ],
        ));
  }
}
