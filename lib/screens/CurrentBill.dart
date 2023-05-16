import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:restismob/global.dart' as global;
import 'package:restismob/models/GetBill.dart';
import 'package:restismob/models/localTypes/LoadingIndicatorDialog.dart';
import 'package:restismob/screens/guestScreen.dart';

import '../widgets/myProgressIndicator.dart';

final numTableProvider = StateProvider<num>((ref) {
  return 0;
});

final amountProvider = StateProvider<double>((ref) {
  if (global.currentBill.root != null) {
    if (global.currentBill.root!.billHead!.head!.amount != null) {
      return global.currentBill.root!.billHead!.head!.amount!;
    } else {
      return 0;
    }
  } else {
    return 0;
  }
});

final numGuestsProvider = StateProvider<int>((ref) {
  return 0;
});

class CurrentBill extends ConsumerWidget {
  const CurrentBill(this.billNum, {super.key});

  final num billNum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    numnumbill = billNum;
    global.ref1 = ref;
    global.context1 = context;
    var tn = ref.watch(numTableProvider);
    var gNs = ref.watch(numGuestsProvider);
    var currentBill = ref.watch(billProvider);
    var amount = ref.watch(amountProvider);
    List<Map<String, dynamic>> items = [];

    var appBar = AppBar(
      backgroundColor: const Color(0xff6C0A39),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          //global.navKey.currentState!.pop;
          Navigator.of(context).maybePop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white60,
        ),
      ),
      title: Text(
        "Cтол №$tn",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        if (global.currentBill.root!.billLines!.line != null) {
          global.currentBill.root!.billLines!.line!.removeWhere((element) => element.quantity == 0);
        }
        global.currentBill.root!.billHead!.head!.amount = global.currentBill.billSumm();
        LoadingIndicatorDialog().show(context);
        var result = saveCurrentBill(global.currentBill);
        result.then((value) => {
              LoadingIndicatorDialog().dismiss(),
              if (!value)
                {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Счет не сохранился !!!',
                    ),
                    backgroundColor: Color(0xffFF6392),
                  ))
                }
            });
        return result;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffEDF0F1),
        appBar: appBar,
        body: Container(
          child: currentBill.when(
              data: (currentBill) {
                if (currentBill.root != null) {
                  global.currentBill = currentBill;
                  if (currentBill.root!.billLines!.line == null) {
                    global.currentBill.root!.billLines!.line = [];
                  }
                  if (currentBill.root!.billCondiments!.condiment == null) {
                    global.currentBill.root!.billCondiments!.condiment = [];
                  }
                  for (int i = 0;
                      i < gNs; //currentBill.root!.billHead!.head!.guestscount!;
                      i++) {
                    items.add({'i': i, 'gN': 'Гость №${i + 1}'});
                  }
                  return Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: ListTileTheme(
                          contentPadding: const EdgeInsets.all(5),
                          iconColor: Colors.black54,
                          textColor: Colors.black,
                          tileColor: const Color(0xffEDF0F1),
                          style: ListTileStyle.list,
                          dense: true,
                          child: ListView.builder(
                            itemCount: gNs, //items.length,
                            itemBuilder: (_, index) => Card(
                              margin: const EdgeInsets.all(5),
                              child: ListTile(
                                  title: Text(items[index]['gN'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w800,
                                      )),
                                  //  subtitle: Text(_items[index]['subtitle']),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      !guestHaveLine(index + 1)
                                          ? IconButton(
                                              onPressed: () {
                                                for (var element
                                                    in global.currentBill.root!.billLines!.line!) {
                                                  if (element.gnumber! > index) {
                                                    element.gnumber = element.gnumber! - 1;
                                                  }
                                                }
                                                gNs--;
                                                currentBill.root!.billHead!.head!.guestscount = gNs;
                                                global.ref1!.read(numGuestsProvider.notifier).state =
                                                    global.currentBill.root!.billHead!.head!.guestscount!;
                                              },
                                              icon: const Icon(Icons.delete_forever_outlined))
                                          : const Text(' '),
                                      IconButton(
                                        icon: const Icon(Icons.arrow_forward_ios),
                                        onPressed: () {
                                          // _toGuest(index + 1);
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => GuestScreen(index + 1)))
                                              .then((value) => {
                                                    ref.read(amountProvider.notifier).state =
                                                        global.currentBill.billSumm(),
                                                  });
                                        },
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            gNs++;
                            currentBill.root!.billHead!.head!.guestscount = gNs;
                            global.ref1!.read(numGuestsProvider.notifier).state =
                                currentBill.root!.billHead!.head!.guestscount!;
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.black54,
                          ),
                          label: const Text(
                            'Гость',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Container(
                          height: 48,
                          width: 213.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xff6C0A39), width: 3),
                            color: const Color(0xff6C0A39),
                          ),
                          child: TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/kuhnya.png',
                                    color: Colors.white,
                                  ),
                                  const Text(' На кухню',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              onPressed: () async {
                                if (global.currentBill.root!.billLines!.line != null) {
                                  global.currentBill.root!.billLines!.line!
                                      .removeWhere((element) => element.quantity == 0);
                                }
                                global.currentBill.root!.billHead!.head!.amount =
                                    global.currentBill.billSumm();
                                LoadingIndicatorDialog().show(context, text: 'Отправляю и обновляю');
                                var result = saveCurrentBill(global.currentBill);
                                result.then((value) => {
                                      if (!value)
                                        {
                                          LoadingIndicatorDialog().dismiss(),
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text(
                                              'Счет не сохранился !!!',
                                            ),
                                            backgroundColor: Color(0xffFF6392),
                                          ))
                                        }
                                      else
                                        {
                                          ref.invalidate(billProvider),
                                          LoadingIndicatorDialog().dismiss(),
                                        }
                                    });
                              }),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: 338,
                          height: 160,
                          alignment: Alignment.bottomCenter,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                  width: 59,
                                  alignment: Alignment.center,
                                  child: const Divider(
                                    thickness: 3,
                                    color: Colors.black54,
                                  )),
                              Row(
                                children: [
                                  Text(
                                    'Итого  ${NumberFormat.simpleCurrency(locale: 'ru-RU', decimalDigits: 2).format(amount)} ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  //const Text('₽'),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'Без учета скидок',
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 12,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              // Container(
                              //   alignment: Alignment.bottomRight,
                              //   child: Column(
                              //     children: [
                              //       CircleAvatar(
                              //         radius: 25,
                              //         backgroundColor: Colors.black26,
                              //         child: IconButton(
                              //           color: Colors.white,
                              //           icon: const Icon(Icons.checklist),
                              //           onPressed: () {},
                              //         ),
                              //       ),
                              //       const Text(
                              //         'Пречек',
                              //         style: TextStyle(
                              //           color: Colors.black26,
                              //           fontSize: 12,
                              //           fontFamily: "Montserrat",
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Счет не найден или не доступен'),
                    backgroundColor: Colors.redAccent,
                  ));
                  return null;
                }
              },
              error: (err, stack) => Text('Error: $err'),
              loading: () => const MyProgressIndicator()),
        ),
      ),
    );
  }

  void qTOq() {
    for (var element in global.currentBill.root!.billLines!.line!) {
      element.markquantity = element.quantity!;
    }
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

Future<bool> saveCurrentBill(GetBill bill) async {
  GetBill? getBill;
  bool result = false;
  try {
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request = 'http://${global.uri}/apim/Bill';
    final response = await dio.post(request, data: bill.toJson());
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
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
  return result;
}

Future<GetBill> loadCurrentBill(num billId) async {
  GetBill? getBill;
  var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
  String request =
      'http://${global.uri}/apim/Bill?Id_Bill=${billId.toString()}&Id_Waiter=${global.waiter.user!.idcode}';
  final response = await dio.get(request);
  debugPrint(response.data!.toString());
  if (response.statusCode == 200) {
    getBill = GetBill.fromJson(response.data);
    if (getBill.root!.msgStatus!.msg!.idStatus == 0) {
      global.ref1!.read(numTableProvider.notifier).state = getBill.root!.billHead!.head!.tablenumber!;
      global.ref1!.read(amountProvider.notifier).state = getBill.root!.billHead!.head!.amount!;
    } else {
      if (getBill.root!.msgStatus!.msg!.msgError!.isNotEmpty) {
        ScaffoldMessenger.of(global.context1!).showSnackBar(
          SnackBar(
            content: Text(
              getBill.root!.msgStatus!.msg!.msgError!,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
        Navigator.of(global.context1!).pop();
      }
    }
  } else {
    getBill = null;
  }
  return getBill!;
}

num numnumbill = 0;

AutoDisposeFutureProvider<GetBill> billProvider = FutureProvider.autoDispose<GetBill>((ref) async {
  GetBill getBill = await loadCurrentBill(numnumbill);
  if (getBill.root != null) {
    if (getBill.root!.billHead!.head != null){
    global.ref1!.read(numGuestsProvider.notifier).state = getBill.root!.billHead!.head!.guestscount!;
  }}
  return getBill;
});