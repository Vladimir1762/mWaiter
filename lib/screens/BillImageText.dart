import 'package:flutter/material.dart';
import 'package:restismob/global.dart' as global;

import '../models/BillCondiment.dart';
import '../models/Line.dart';

class BillImageText extends StatelessWidget {
  const BillImageText({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.grey,
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
      title: Text(
        "Cтол № ${global.currentBill.root!.billHead!.head!.tablenumber} Гостей ${global.currentBill.root!.billHead!.head!.guestscount}",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[...listOfStrings(context)],
      ),
    );
  }

  List<Widget> listOfStrings(BuildContext context) {
    List<Widget> listsOfWidgets = [];
    int commonG = 1;
    int currentCurs = 0;
    int index = 0;
    int currentGuest = -1;
    if (guestHaveLine(0)) {
      commonG = 0;
    }
    for (int i = commonG; i <= global.currentBill.root!.billHead!.head!.guestscount!; i++) {
      if (i > commonG) {
        listsOfWidgets.add(const Text('  '));
      }
      listsOfWidgets.add(
        Text(
          i == 0 ? '  Общий ' : '  Гость $i',
          style: const TextStyle(
              fontSize: 18, fontFamily: "Roboto", fontWeight: FontWeight.w800, color: Colors.blueAccent),
        ),
      );
      List<Line> listOfLine = global.currentBill.root!.billLines!.line!
          .where((element) => (element.gnumber == i) && (element.idfline == 0) && (element.quantity! > 0))
          .toList();
      listOfLine.sort((a, b) => a.norder!.compareTo(b.norder!));
      for (var element in listOfLine) {
        index++;
        if (element.norder != currentCurs || currentGuest != i){
          currentCurs = element.norder!;
          currentGuest = i;
          listsOfWidgets.add(
            Text('    Курс : $currentCurs',  style: const TextStyle(
                fontSize: 16, fontFamily: "Roboto", fontWeight: FontWeight.w800, color: Colors.lightBlueAccent),));
        }
        listsOfWidgets.add(
          Container(
            decoration: BoxDecoration(color: index.isOdd ? Color(0xffF5F2F1) : Color(0xffFDFBFA)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      element.dispname!,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    'пц. ${element.quantity} ',
                    style: const TextStyle(fontSize: 16, fontFamily: "Roboto", fontWeight: FontWeight.w800),
                  ),
                )
              ],
            ),
          ),
        );
        List<BillCondiment> conds = global.currentBill.root!.billCondiments!.condiment!
            .where((element1) => element1.idline == element.idline)
            .toList();
        if (conds.isNotEmpty) {
          for (var element3 in conds) {
            listsOfWidgets.add(
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.edit_note_sharp),
                  Text('${element3.dispname!}  ',
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey)),
                ],
              ),
            );
          }
        }
        if (element.iscomplex == 1) {
          List<Line> compList = global.currentBill.root!.billLines!.line!
              .where((element4) => element4.idfline == element.idline)
              .toList();
          //  compList.sort((a,b)=> a.idchoice!.compareTo(b.idchoice!));
          for (var element5 in compList) {
            listsOfWidgets.add(
              Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text('  '),
                const Icon(Icons.check_outlined),
                Text(element5.dispname!,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black45,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400)),
              ]),
            );
          }
        }
      }
    }
    return listsOfWidgets;
  }

  bool guestHaveLine(int gNumber) {
    bool result = false;
    for (var element in global.currentBill.root!.billLines!.line!) {
      if ((element.gnumber == gNumber) && (element.quantity! > 0)) {
        result = true;
      }
    }
    return result;
  }
}
