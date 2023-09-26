import 'package:flutter/material.dart';

class qoAlert extends StatefulWidget {
  final String ware;

  const qoAlert({super.key, required this.ware});
  @override
  State<qoAlert> createState() => qoAlertState();
}

class qoAlertState extends State<qoAlert> {
  final TextEditingController _controller = TextEditingController();
  Color color1 = Colors.black45;
  Color color2 = Colors.black45;
  Color color3 = Colors.black45;
  int kurs = 1;
  double qnty = 1;

  @override
  Widget build(BuildContext context) {

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

    _controller.text = qnty.toString();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content:
         SizedBox(
           height: 250,
           child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Text(widget.ware,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w800,
                  )),
              const Divider(
                thickness: 3,
                color: Colors.black54,
              ),
              Text('Выберите кол-во порций и курс',
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
                    const Text('Порции ',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w800,
                        )),
                    IconButton(
                        onPressed: () {
                          qnty = qnty > 0.5 ? qnty - 1 : qnty;
                          _controller.text = qnty.toString();
                        },
                        icon: const Icon(Icons.remove_circle_outline_rounded)),
                    Container(
                      alignment: Alignment.center,
                      width: 30,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          qnty = qnty + 1;
                          _controller.text = qnty.toString();
                        },
                        icon: const Icon(Icons.add_circle_outline_rounded)),
                  ],
                ),
              ),
             
              Expanded(
                child: Row(
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
              ),
              Expanded(
                child: Row(
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
                          _controller.text.replaceAll(',', '.');
                          qnty = double.tryParse(_controller.text) ?? -1;
                          if (qnty < 0) {
                            _controller.text = '';
                          } else {
                            Navigator.pop(context, [qnty, kurs]);
                          }
                        },
                        child: const Text(
                          "Сохранить",
                          style: TextStyle(color: Colors.green),
                        )),
                  ],
                ),
              )
            ],
        ),
         ),

    );
  }
}
