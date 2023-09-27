import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:restismob/global.dart' as global;
import 'package:restismob/models/Bill.dart';
import 'package:restismob/models/localTypes/kurs_alert.dart';
import 'package:restismob/models/localTypes/text_input_alert.dart';
import 'package:restismob/models/menu/CheckinResult.dart';

import '../models/BonusClubNote.dart';
import '../models/GetBill.dart';
import '../models/localTypes/loading_indicator_dialog.dart';
import '../screens/CurrentBill.dart';

class TableItem extends StatefulWidget {
  final Bill bill;
  final int hColor;
  final List<int> kurss;
  final String statusB;
  final VoidCallback voidCallback;

  const TableItem({
    super.key,
    required this.bill,
    this.hColor = 0xffFFB5A5,
    required this.kurss,
    required this.statusB, required this.voidCallback,
  });

  @override
  State<TableItem> createState() => _PopupMenuItemState();
}

class _PopupMenuItemState extends State<TableItem> {
  String? selectedMenu;
  final numberFormat = NumberFormat("##,##0.00");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: SizedBox(
          width: 162,
          height: 184,
          child: PopupMenuButton(
            child: Column(
              children: [
                Flexible(
                  flex: 42,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(widget.hColor),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 6, 2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Стол ${widget.bill.tablenumber}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.statusB,
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 10,
                                  height: 12 / 10,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              // const Spacer(),
                              Text(
                                global.getTimeFromDateAndTime(widget.bill.billdate!),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Color(0xb2000000),
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  height: 14 / 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 132,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.bill.line!.length,
                            itemBuilder: (_, index) => LineImg(
                                  line: widget.bill.line![index],
                                ))),
                  ),
                ),
                const Divider(),
                Flexible(
                  flex: 24,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 11.51,
                          height: 14.39,
                          child: SvgPicture.asset('assets/images/guest.svg', semanticsLabel: 'vector'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.bill.guestscount}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          NumberFormat.simpleCurrency(locale: 'ru-RU', decimalDigits: 2)
                              .format(widget.bill.amount),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        // const Text('₽'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            onSelected: (String item) {
              selectedMenu = item;
              if (selectedMenu!.contains('add')) {
                // _toBill(widget.bill.idcode!);
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrentBill(widget.bill.idcode!),
                            settings: const RouteSettings(name: "/currentbill")))
                    .then((value) {
                  if (global.currentBill.root!.billHead!.head != null &&
                      global.currentBill.root!.msgStatus!.msg!.idStatus != -1) {
                    widget.bill.guestscount = global.currentBill.root!.billHead!.head!.guestscount!;
                    widget.bill.amount = global.currentBill.root!.billHead!.head!.amount!;
                  }
                  setState(() {});
                });
              }
              if (selectedMenu!.contains('pickup')) {
                Future<bool> resu;
                if (widget.kurss.contains(2) || widget.kurss.contains(3)) {
                  showDialog(context: context, builder: (_) => KursAlert(kurss: widget.kurss))
                      .then((value) => {
                            if ((value != null) && (value != 1))
                              {
                                LoadingIndicatorDialog().show(context, text: 'Отправляю'),
                                resu = pickupCurrentBill(widget.bill.idcode!, value),
                                resu.then((value1) => {
                                      LoadingIndicatorDialog().dismiss(),
                                      if (!value1)
                                        {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text(
                                              'Ошибка передачи марок',
                                            ),
                                            backgroundColor: Color(0xffFF6392),
                                          ))
                                        }
                                    }),
                              }
                          });
                }
              }
              if (selectedMenu!.contains('checkin')) {
                Future<bool> resu;
           //     if (widget.bill.idcard == 0) {
                  showDialog(context: context, builder: (_) => const TextInputAlert(title: 'Введите код'))
                      .then((value) => {
                            if (value != null)
                              {
                                LoadingIndicatorDialog().show(context, text: 'Отправляю'),
                                resu = checkinCurrentBill(widget.bill.idcode!, value),
                                resu.then((value1) => {
                                      widget.voidCallback(),
                                      LoadingIndicatorDialog().dismiss(),
                                    })
                              }
                          });
               // }
              }
              if (selectedMenu!.contains('bonuclub')) {
                Future<bool> resu;
                //     if (widget.bill.idcard == 0) {
                showDialog(context: context, builder: (_) => const TextInputAlert(title: 'Введите примечание'))
                    .then((value) => {
                  if (value != null)
                    {
                      LoadingIndicatorDialog().show(context, text: 'Отправляю'),
                      resu = bonusClubCurrentBill(widget.bill.idcode!, value),
                      resu.then((value1) => {
                        widget.voidCallback(),
                        LoadingIndicatorDialog().dismiss(),
                      })
                    }
                });
                // }
              }
            },
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  value: '/add',
                  child: Row(
                    children: <Widget>[
                      const Text("Дополнить"),
                      const Spacer(),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset('assets/images/add.svg', semanticsLabel: 'vector'),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: '/checkin',
                  child: Row(
                    children: <Widget>[
                      const Text("Чекин"),
                      const Spacer(),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset('assets/images/checkin.svg', semanticsLabel: 'vector'),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: '/pickup',
                  child: Row(
                    children: <Widget>[
                      const Text("Пикап"),
                      const Spacer(),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset('assets/images/sale.svg', semanticsLabel: 'vector'),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: '/bonuclub',
                  child: Row(
                    children: <Widget>[
                      const Text("Примечание"),
                      const Spacer(),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset('assets/images/message.svg', semanticsLabel: 'vector'),
                      )
                    ],
                  ),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }

  void goMsg(String msg, Color clr) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: clr,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<bool> bonusClubCurrentBill(num billId, String code) async {
    BonusClubNote? bn;
    bool result = false;
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request = 'http://${global.uri}/apim/BonusClub?Note=$code&Id_Bill=$billId';
    final response = await dio.get(request);
    debugPrint(response.data!.toString());
    if (response.statusCode == 200) {
      bn = BonusClubNote.fromJson(response.data);
      if (bn.bonusClub != null) {
        if (bn.bonusClub!.msgStatus!.msg!.idStatus != 0) {
        //  goMsg(bn.bonusClub!.msgStatus!.msg!.msgError!, Colors.redAccent);
        } else {
        //  goMsg(bn.bonusClub!.msgStatus!.msg!.msgError!, Colors.greenAccent);
          result = true;
        }
      }
    }
    return result;
  }

  Future<bool> checkinCurrentBill(num billId, String code) async {
    CheckinResult? ch;
    bool result = false;
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request = 'http://${global.uri}/apim/Checkin?secretCode=$code&Id_Bill=$billId';
    final response = await dio.get(request);
    debugPrint(response.data!.toString());
    if (response.statusCode == 200) {
      ch = CheckinResult.fromJson(response.data);
      if (ch.checkIn != null) {
        if (ch.checkIn!.msgStatus!.msg!.idStatus != 0) {
          goMsg(ch.checkIn!.msgStatus!.msg!.msgError!, Colors.redAccent);
        } else {
          goMsg(ch.checkIn!.msgStatus!.msg!.msgError!, Colors.greenAccent);
          result = true;
        }
      }
    }
    return result;
  }

  Future<bool> pickupCurrentBill(num billId, int kurs) async {
    GetBill? getBill;
    bool result = false;
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request = 'http://${global.uri}/apim/PickUp?Id_Bill=$billId&iCurs=$kurs';
    final response = await dio.get(request);
    debugPrint(response.data!.toString());
    if (response.statusCode == 200) {
      getBill = GetBill.fromJson(response.data);
      if (getBill.root!.msgStatus != null) {
        if (getBill.root!.msgStatus!.msg!.idStatus == 0) {
          result = true;
        } else {
          result = false;
        }
      } else {
        result = false;
      }
    } else {
      result = false;
    }
    return result;
  }
}

class LineImg extends StatelessWidget {
  final PreBillLine line;

  const LineImg({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26.89,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 5,
          ),
          Text(
            line.quantity == '0' ? ' ' : '${double.parse(line.quantity!).toStringAsFixed(0)}\n',
            style: const TextStyle(
                color: Color(0xb2000000),
                fontSize: 12,
                height: 15 / 12,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 120,
            height: 26.89,
            child: Text(
              line.dispname!,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: const TextStyle(
                  color: Color(0xb2000000),
                  fontSize: 12,
                  height: 14 / 12,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
