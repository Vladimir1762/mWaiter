import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:restismob/screens/tablesList.dart';

import 'package:restismob/models/Bill.dart';
import '../widgets/tableListItem.dart';
import 'package:restismob/widgets/myFloatingButton.dart';

class BillListPage extends HookWidget {
  final List<Bill?> bills;
  final VoidCallback voidCallback;


  const BillListPage(this.bills, this.voidCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xffEDF0F1),
      body: GridView.count(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 100),
        childAspectRatio: 162/184,
        crossAxisCount: 2,
        children: <Widget>[..._listado(context, bills)],
      ),
      floatingActionButton: MyFloatingBunnon(
        width: 245,
        height: 48,
        borderColor: 0xff68A3AB,
        fontColor: 0xffFFFFFF,
        backColor: 0xff68A3AB,
        text: "Выбрать стол",
        onPress: () async {
          //await _toTableList();
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TablesList()));
        },
      ),
    );
  }

  List<Widget> _listado(BuildContext context, List<Bill?> lista) {
    lista.sort((a,b)=> a!.tablenumber!.compareTo(b!.tablenumber!));
    List<Widget> listaWidget = [];
    for (var element in lista) {
      List<int> kurss = [];
      if (element!.iscurs2! == 1){ if (!kurss.contains(2)){kurss.add(2);}}
      if (element.iscurs3! == 1){ if (!kurss.contains(3)){kurss.add(3);}}
      String status = '';
      int lColor = 0;
      switch (element.iStatusBill) {
        case 1:
          {
            lColor = 0xffFFB5A5;
            status = element.StatusBill!;
          }
          break;
        case 2:
          {
            lColor = 0xffFDE281;
            status = element.StatusBill!;
          }
          break;
        case 3:
          {
            lColor = 0xff75F599;
            status = element.StatusBill!;
          }
          break;
        default:{
          lColor = 0xffFFB5A5;
          status = 'В работе';
        }
          break;
      }
      listaWidget.add(TableItem(
        bill: element,
        hColor: lColor,
        kurss: kurss,
        statusB: status,
        voidCallback: voidCallback,
      ));
    }
    return listaWidget;
  }
}

