import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:restismob/global.dart' as global;
import 'package:restismob/models/Featured/Item.dart';
import '../models/Featured/Fea.dart';
import '../models/Line.dart';
import '../models/localTypes/qo_alert.dart';

class MenuListRegular extends StatefulWidget {
  final int guestNumber;
  final List<Line> listOfLines;
  final bool canSelect;

  const MenuListRegular(
      {super.key, required this.guestNumber, required this.listOfLines, required this.canSelect});

  @override
  State<MenuListRegular> createState() => MenuListRegularState();
}

class MenuListRegularState extends State<MenuListRegular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Flexible(
          child: Scrollbar(
            thumbVisibility: false,
            thickness: 5,
            child: ListView.builder(
              itemCount: widget.listOfLines.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) => Card(
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  leading: isLineInFea(widget.listOfLines[index].idware!)
                      ? IconButton(
                          onPressed: () {
                            delWare(widget.listOfLines[index]);
                            global.fea.featuredRoot!.featuredItems!.item!
                                .removeWhere((element) => element.idware == widget.listOfLines[index].idware);
                            setState(() {});
                          },
                          icon: SvgPicture.asset('assets/images/greenstar.svg', semanticsLabel: 'vector'))
                      : IconButton(
                          onPressed: () {
                            global.fea.featuredRoot!.featuredItems!.item!.add(Item(
                                idware: widget.listOfLines[index].idware,
                                dispname: widget.listOfLines[index].dispname,
                                idmenu: widget.listOfLines[index].idmenu,
                                idcash: 0,
                                idshop: widget.listOfLines[index].idshop,
                                marking: widget.listOfLines[index].marking,
                                price: widget.listOfLines[index].price,
                                packing: widget.listOfLines[index].packing,
                                nodiscount: widget.listOfLines[index].nodiscount));
                            putWare(widget.listOfLines[index]);
                            setState(() {});
                          },
                          icon: SvgPicture.asset('assets/images/star.svg', semanticsLabel: 'vector')),
                  title: Text(widget.listOfLines[index].dispname!,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w800,
                      )),
                  //  subtitle: Text(_items[index]['subtitle']),
                  trailing: widget.canSelect
                      ? IconButton(
                          icon: global.ifLineInLines(widget.listOfLines[index].idware!, widget.guestNumber)
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xff1CE192),
                                )
                              : (widget.listOfLines[index].quantity! < 0
                                  ? const Icon(Icons.block, color: Colors.red)
                                  : const Icon(Icons.add_circle_outline)),
                          onPressed: () {
                            if (widget.listOfLines[index].quantity! < 0) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                    'Бдюдо в стоп листе',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  )));
                            } else {
                              showDialog(
                                      builder: (_) => QoAlert(
                                            ware: widget.listOfLines[index].dispname!,
                                            guest: widget.guestNumber,
                                          ),
                                      context: context)
                                  .then((value) {
                                if (value != null) {
                                  global.addNewLine(
                                      widget.listOfLines[index], value[2], value[0], value[1], context);
                                  if (value[2] > global.currentBill.root!.billHead!.head!.guestscount) {
                                    global.currentBill.root!.billHead!.head!.guestscount = value[2];
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.black54,
                                      content: Text(
                                        'Добавлено блюдо \n${widget.listOfLines[index].dispname!} \n порций ${value[0]} курс ${value[1]}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      )));
                                  setState(() {});
                                }
                              });
                            }
                          },
                        )
                      : const SizedBox(width: 16, height: 16,),
                ),
              ),
            ),
          ),
          //ListForSelectWares(
          // listOfLines: listOfLines, gnumber: gnumber,)
        ),
      ],
    ));
  }

  bool isLineInFea(int idware) {
    bool result = false;
    result =
        global.fea.featuredRoot!.featuredItems!.item!.where((element) => element.idware == idware).isNotEmpty;
    return result;
  }

  Future<void> putWare(Line line) async {
    Fea? getBill;
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request =
        'http://${global.uri}/apim/FeaturedItems?Id_Waiter=${global.waiter.user!.idcode!}&Id_Ware=${line.idware}&Id_Menu=${line.idmenu}';
    final response = await dio.post(
      request,
    );
    debugPrint(response.data!.toString());
    if (response.statusCode == 200) {
      global.fea.featuredRoot!.featuredItems!.item!.removeWhere((element) => element.idware == line.idware);
      getBill = Fea.fromJson(response.data);
      if (getBill.featuredRoot!.msgStatus!.msg!.idStatus == 0) {
        global.fea.featuredRoot!.featuredItems!.item!.removeWhere((element) => element.idware == line.idware);
        global.fea.featuredRoot!.featuredItems!.item!.addAll(getBill.featuredRoot!.featuredItems!.item!);
      } else {
        goMsg(getBill.featuredRoot!.msgStatus!.msg!.msgError!);
      }
    } else {
      goMsg('Ошибка подключения');
    }
  }

  Future<void> delWare(Line line) async {
    Fea? getBill;
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request =
        'http://${global.uri}/apim/FeaturedDelItem?Id_Waiter=${global.waiter.user!.idcode!}&Id_Ware=${line.idware}';
    final response = await dio.post(
      request,
    );
    debugPrint(response.data!.toString());
    if (response.statusCode == 200) {
      getBill = Fea.fromJson(response.data);
      if (getBill.featuredRoot!.msgStatus!.msg!.idStatus == 0) {
      } else {
        goMsg(getBill.featuredRoot!.msgStatus!.msg!.msgError!);
      }
    } else {
      goMsg('Ошибка подключения');
    }
  }

  void goMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.redAccent,
    ));
  }
}
