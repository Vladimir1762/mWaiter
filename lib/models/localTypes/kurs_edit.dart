import 'package:flutter/material.dart';

class KursEdit extends StatefulWidget {
  final int kurss;

  const KursEdit({super.key, required this.kurss});
  @override
  State<KursEdit> createState() => KursEditState();
}

class KursEditState extends State<KursEdit> {
  Color color1 = Colors.black45;
  Color color2 = Colors.black45;
  Color color3 = Colors.black45;
  int kurs = 0;

  @override
  Widget build(BuildContext context) {
    if (kurs == 0){kurs = widget.kurss;}
    switch (kurs) {
      case 1:
        {
          color1 = Colors.blueAccent;
          color2 = Colors.black45;
          color3 = Colors.black45;
        }
        break;
      case 2:
        {
          color1 = Colors.black45;
          color2 = Colors.blueAccent;
          color3 = Colors.black45;
        }
        break;
      case 3:
        {
          color1 = Colors.black45;
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
                  child: ClipOval(
                    child: Material(
                      color: color1,
                      child: InkWell(
                        onTap: () => setState((){
                          kurs = 1;
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text('1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w800,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipOval(
                    child: Material(
                      color: color2,
                      child: InkWell(
                        onTap: () => setState((){
                          kurs = 2;
                        }),
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
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipOval(
                    child: Material(
                      color: color3,
                      child: InkWell(
                        onTap: () => setState((){
                          kurs = 3;
                        }),
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
                  ),
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
                      Navigator.pop(context,  kurs);
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