import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:restismob/global.dart' as global;
import 'package:restismob/models/GetBill.dart';
import 'package:restismob/models/localTypes/loading_indicator_dialog.dart';
import 'package:restismob/screens/guestScreen.dart';

import '../models/Line.dart';
import '../widgets/myProgressIndicator.dart';
import 'BillImageText.dart';

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

final commonGuestsProvider = StateProvider<int>((ref) {
  return 1;
});

class CurrentBill extends ConsumerStatefulWidget {
  const CurrentBill(
    this.billNum, {
    Key? key,
  }) : super(key: key);

  final num billNum;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CurrentBillState();
}

class _CurrentBillState extends ConsumerState<CurrentBill> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    global.currentBill.root = null;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        global.currentBill.root!.msgStatus!.msg!.idStatus = 0;
        delEmpty();
        var result = global.saveCurrentBill();
        result.then((value) => {
              if (mounted) {Navigator.popUntil(context, (route) => route.settings.name == "/prebills")}
            });
        break;
      case AppLifecycleState.resumed:
        Navigator.popUntil(context, (route) => route.settings.name == "/prebills");
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  void delEmpty() {
    List<Line> ll = [];
    if (global.currentBill.root!.billLines!.line != null) {
      ll.addAll(global.currentBill.root!.billLines!.line!.where((element) => element.quantity == 0));
      if (global.currentBill.root!.billCondiments!.condiment != null) {
        for (var element1 in ll) {
          global.currentBill.root!.billCondiments!.condiment!
              .removeWhere((element2) => element2.idline == element1.idline);
        }
      }
      global.currentBill.root!.billLines!.line!.removeWhere((element) => element.quantity == 0);
    }
  }

  void saveBill() {
    delEmpty();
    global.currentBill.root!.billHead!.head!.amount = global.currentBill.billSumm();
    global.currentBill.root!.msgStatus!.msg!.idStatus = 1;
    LoadingIndicatorDialog().show(context, text: 'Отправляю и обновляю');
    var result = global.saveCurrentBill();
    result.then((value) => {
          if (!value)
            {
              LoadingIndicatorDialog().dismiss(),
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  'Счет не сохранился !!!',
                ),
                backgroundColor: Color(0xffFF6392),
              )),
            }
          else
            {
              //  ref.invalidate(billProvider),
              LoadingIndicatorDialog().dismiss(),
            },
          global.markSending = false,
        });
  }

  @override
  Widget build(BuildContext context) {
    numnumbill = widget.billNum;
    global.ref1 = ref;
    global.context1 = context;
    var tn = ref.watch(numTableProvider);
    var gNs = ref.watch(numGuestsProvider);
    var currentBill = ref.watch(billProvider);
    var amount = ref.watch(amountProvider);
    List<Map<String, dynamic>> items = [];
    int commonGuest = ref.watch(commonGuestsProvider);

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

    ScrollController scrollController = ScrollController();

    return WillPopScope(
      onWillPop: () async {
        delEmpty();
        global.currentBill.root!.billHead!.head!.amount = global.currentBill.billSumm();
        global.currentBill.root!.msgStatus!.msg!.idStatus = 0;
        LoadingIndicatorDialog().show(context);
        var result = global.saveCurrentBill();
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
              data: (currentBillData) {
                if (currentBillData.root != null) {
                  if (global.currentBill.root == null ||
                      global.currentBill.root!.billHead!.head == null ||
                      billNeedUpdate(currentBillData.root!.billHead!.head!.idcode!)) {
                    global.currentBill = currentBillData;
                  }
                  if (currentBillData.root!.billLines!.line == null) {
                    global.currentBill.root!.billLines!.line = [];
                  }
                  if (currentBillData.root!.billCondiments!.condiment == null) {
                    global.currentBill.root!.billCondiments!.condiment = [];
                  }
                  if (guestHaveLine(0)) {
                    commonGuest = 0;
                    items.add({'i': 0, 'gN': 'Общий'});
                  } else {
                    commonGuest = 1;
                  }
                  for (int i = 1;
                      i <= gNs; //currentBill.root!.billHead!.head!.guestscount!;
                      i++) {
                    items.add({'i': i, 'gN': 'Гость $i'});
                  }
                  return Column(
                    children: [
                      Flexible(
                        flex: 4,
                        child: ListTileTheme(
                          contentPadding: const EdgeInsets.all(5),
                          iconColor: Colors.black54,
                          textColor: Colors.black,
                          tileColor: const Color(0xffEDF0F1),
                          style: ListTileStyle.list,
                          dense: true,
                          child: Scrollbar(
                            thumbVisibility: false,
                            thickness: 10,
                            controller: scrollController,
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: items.length,
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
                                        !guestHaveLine(index + commonGuest) && ((index + commonGuest) > 1)
                                            ? IconButton(
                                                onPressed: () {
                                                  for (var element
                                                      in global.currentBill.root!.billLines!.line!) {
                                                    if (element.gnumber! > index) {
                                                      element.gnumber = element.gnumber! - 1;
                                                    }
                                                  }
                                                  gNs--;
                                                  currentBillData.root!.billHead!.head!.guestscount = gNs;
                                                  global.ref1!.read(numGuestsProvider.notifier).state =
                                                      global.currentBill.root!.billHead!.head!.guestscount!;
                                                },
                                                icon: const Icon(Icons.delete_forever_outlined))
                                            : const Text(' '),
                                        IconButton(
                                          icon: const Icon(Icons.arrow_forward_ios),
                                          onPressed: () {
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GuestScreen(gN: index + commonGuest),
                                                        settings: const RouteSettings(name: "/guestscreen")))
                                                .then((value) => {
                                                      if (global.currentBill.root!.billHead != null)
                                                        {
                                                          if (global.currentBill.root!.billHead!.head != null)
                                                            {
                                                              if (guestHaveLine(0) && commonGuest == 1)
                                                                {
                                                                  ref
                                                                      .read(commonGuestsProvider.notifier)
                                                                      .state = 0,
                                                                  //commonGuest = 0,
                                                                  items.add({'i': 0, 'gN': 'Общий'}),
                                                                }
                                                              else
                                                                {
                                                                  if (!guestHaveLine(0) && commonGuest == 0)
                                                                    {
                                                                      ref
                                                                          .read(commonGuestsProvider.notifier)
                                                                          .state = 1,
                                                                      //commonGuest = 1,
                                                                      items.removeWhere((element) =>
                                                                          element == {'i': 0, 'gN': 'Общий'}),
                                                                    }
                                                                },
                                                              ref.read(amountProvider.notifier).state =
                                                                  global.currentBill.billSumm(),
                                                              ref.read(numGuestsProvider.notifier).state =
                                                                  global.currentBill.root!.billHead!.head!
                                                                      .guestscount!,
                                                            }
                                                        }
                                                    });
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            gNs++;
                            currentBillData.root!.billHead!.head!.guestscount = gNs;
                            ref.read(numGuestsProvider.notifier).state =
                                currentBillData.root!.billHead!.head!.guestscount!;
                            if (scrollController.hasClients) {
                              final position = scrollController.position.maxScrollExtent;
                              if (gNs > 3) {
                                scrollController.jumpTo(position + 65);
                              }
                            }
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
                                  const Text('  Отправить марки',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              onPressed: () {
                                if (!global.markSending) {
                                  global.markSending = true;
                                  saveBill();
                                }
                              }),
                        ),
                      ),
                      const Text(
                        '',
                        style: TextStyle(fontSize: 24),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: 338,
                          height: 160,
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                      '  Итого  ${NumberFormat.simpleCurrency(locale: 'ru-RU', decimalDigits: 2).format(amount)} ',
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: const Column(
                                        children: [
                                          Text(
                                            '  Без учета скидок',
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 12,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.black26,
                                            child: IconButton(
                                              color: Colors.white,
                                              icon: const Icon(Icons.checklist_rtl_sharp),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => const BillImageText()));
                                              },
                                            ),
                                          ),
                                          const Text(
                                            'Просмотр счета',
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 12,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  bool billNeedUpdate(int billID) {
    bool result = false;
    if (global.currentBill.root!.billHead!.head!.idcode != billID) {
      result = true;
    } else {
      for (var element in global.currentBill.root!.billLines!.line!) {
        if ((element.idline! < 0) || (element.quantity! > element.markquantity!)) {
          result = true;
          break;
        }
      }
    }
    return result;
  }

  bool guestHaveLine(int gNumber) {
    bool result = false;
    for (var element in global.currentBill.root!.billLines!.line!) {
      if ((element.gnumber == gNumber) && (element.quantity! > 0) && !result) {
        result = true;
      }
    }
    return result;
  }
}

Future<GetBill> loadCurrentBill(num billId) async {
  GetBill? getBill;
  if (billId == -1) {
    getBill = global.currentBill;
  } else {
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request =
        'http://${global.uri}/apim/Bill?Id_Bill=${billId.toString()}&Id_Waiter=${global.waiter.user!.idcode}';
    final response = await dio.get(request);
    debugPrint(response.data!.toString());
    if (response.statusCode == 200) {
      getBill = GetBill.fromJson(response.data);
      if (getBill.root!.msgStatus!.msg!.idStatus != 0) {
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
  }
  return getBill!;
}

num numnumbill = 0;

AutoDisposeFutureProvider<GetBill> billProvider = FutureProvider.autoDispose<GetBill>((ref) async {
  GetBill getBill = await loadCurrentBill(numnumbill);
  if (getBill.root != null) {
    if (getBill.root!.billHead!.head != null) {
      global.ref1!.read(numGuestsProvider.notifier).state = getBill.root!.billHead!.head!.guestscount!;
      global.ref1!.read(numTableProvider.notifier).state = getBill.root!.billHead!.head!.tablenumber!;
      global.ref1!.read(amountProvider.notifier).state = getBill.root!.billHead!.head!.amount!;
    }
  }
  return getBill;
});
