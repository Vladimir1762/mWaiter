import 'package:flutter/material.dart';
import 'package:restismob/models/menu/MenuHead.dart';

import '../models/Line.dart';
import 'package:restismob/global.dart' as global;

class ComplexToSelect extends StatefulWidget {
  final MenuHead menuHead;
  final int guestNum;

  const ComplexToSelect({super.key, required this.menuHead, required this.guestNum});

  @override
  State<ComplexToSelect> createState() => ComplexToSelectState();
}

class ComplexToSelectState extends State<ComplexToSelect> {
  List<Line> listOfLines = [];
  List<Line> selectedLines = [];
  int choices = 0;

  @override
  void initState() {
    super.initState();
    global.srvIdLine--;
    for (var element in widget.menuHead.menuLine!) {
      if (element.idware != null) {
        if (choices < element.idline!) {
          choices = element.idline!;
        }
        Line sl = global.billLineFromMenuLine(element);
        sl.idfline = global.srvIdLine;
        sl.quantity = 1;
        listOfLines.add(sl);
      }
    }
    selectedLines.add(Line(
      idline: global.srvIdLine,
      idmenu: widget.menuHead.idcode,
      idware: widget.menuHead.idcode,
      dispname: widget.menuHead.dispname,
      idfline: 0,
      idbill: global.currentBill.root!.billHead!.head!.idcode!,
      idchoice: 0,
      idshop: 0,
      price: widget.menuHead.summamenu,
      quantity: 1,
      group: 0,
      norder: 1,
      iscomplex: 1,
      gnumber: widget.guestNum,
      markquantity: 0,
    ));
    for (int i = 1; i <= choices; i++) {
      Line ls = listOfLines.firstWhere((element) => element.idcomplexline == i);
      global.srvIdLine--;
      ls.idline = global.srvIdLine;
      selectedLines.add(ls);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.lightGreen,
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).maybePop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white60,
        ),
      ),
      title: SizedBox(
        height: 48,
        child: Text(
          widget.menuHead.dispname!,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 22,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - appBar.preferredSize.height,
          child: Column(
            children: [
              Flexible(
                flex: 9,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: choices,
                  itemBuilder: (BuildContext context, int index) {
                    List<Line> itemLines =
                        listOfLines.where((element) => element.idcomplexline == index + 1).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Позиция : ${index + 1} ",
                            style: const TextStyle(
                              color: Colors.lightGreen,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w800,
                            )),
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          //   physics: const NeverScrollableScrollPhysics(),
                          physics: const ScrollPhysics(),
                          itemCount: itemLines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              trailing: IconButton(
                                icon: haveLine(itemLines[index].idware!)
                                    ? const Icon(
                                        Icons.check_box_outlined,
                                        color: Color(0xff1A69A3),
                                      )
                                    : const Icon(Icons.check_box_outline_blank_rounded),
                                onPressed: () {
                                  Line ls = itemLines[index];
                                  global.srvIdLine--;
                                  ls.idline = global.srvIdLine;
                                  selectedLines[itemLines[index].idcomplexline!] = ls;
                                  setState(() {});
                                },
                              ),
                              title: Text(
                                itemLines[index].dispname!,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Отмена',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        global.currentBill.root!.billLines!.line!.addAll(selectedLines);
                        global.currentBill.root!.billHead!.head!.amount = global.currentBill.billSumm();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black54,
                            content: Text(
                              'Добавлено блюдо \n${selectedLines[0].dispname!} ',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            )));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Добавить',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool haveLine(int idware) {
    bool result = false;
    for (var element in selectedLines) {
      if (element.idware == idware) {
        result = true;
      }
    }
    return result;
  }
}
