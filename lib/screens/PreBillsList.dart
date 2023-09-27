import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:restismob/screens/BillListPage.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:restismob/screens/tablesList.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';
import '../models/Featured/Fea.dart';
import '../models/Featured/FeaturedRoot.dart';
import '../models/PreBills.dart';
import '../models/Bill.dart';
import '../global.dart' as global;
import '../models/menu/MenuStructure.dart';
import 'MenuWithTab.dart';
import 'SettingsR.dart';
import 'emptyBillList.dart';
import 'package:restismob/widgets/myProgressIndicator.dart';

class PreBillList extends ConsumerStatefulWidget {
  final num waiterId;

  const PreBillList(this.waiterId, {super.key});

  @override
  ConsumerState<PreBillList> createState() => PreBillListHome();
}

class PreBillListHome extends ConsumerState<PreBillList> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
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
      case AppLifecycleState.resumed:
        setState(() {
          ref.invalidate(listProvider);
        });
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        {
          final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
          prefs.then((SharedPreferences prefss) {
            prefss.setInt('lastDay', DateTime.now().millisecondsSinceEpoch);
          });
        }
        break;
    }
  }

  void callBack() {
    ref.invalidate(listProvider);
  }

  @override
  Widget build(BuildContext context) {
    int percent = ref.watch(global.percentProvider);
    var menuStructure = ref.watch(menuProvider);
    ref.watch(feaProvider);
    // global.srvIdLine = 0;
    var appBar = AppBar(
      backgroundColor: const Color(0xff68a3ab),
      toolbarHeight: 96,
      //centerTitle: true,
      leading: PopupMenuButton(
          icon: const Icon(Icons.menu_sharp),
          onSelected: (String item) {
            if (item.contains('/manr')) {
              Navigator.of(context).maybePop();
            }
            if (item.contains('/menur')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MenuWithTab(
                          guestNum: 1,
                          canSelect: false,
                        )),
              );
            }
            if (item.contains('/tabler')) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TablesList()));
            }
            if (item.contains('/settr')) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsR(
                            canEdit: false,
                          )));
            }
          },
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                  value: '/manr',
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 17.81,
                            height: 19.35,
                            child: SvgPicture.asset(
                              'assets/images/door.svg',
                              semanticsLabel: 'vector',
                            ),
                          ),
                        ],
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(
                            'assets/images/man.svg',
                            semanticsLabel: 'vector',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Text(
                            global.waiter.user!.username!,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ]),
                    ],
                  )),
              PopupMenuItem(
                  value: '/menur',
                  child: Row(children: <Widget>[
                    const Text(
                      'Меню',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        //height: 12 / 10,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        'assets/images/openbook.svg',
                        semanticsLabel: 'vector',
                      ),
                    ),
                  ])),
              PopupMenuItem(
                  value: '/tabler',
                  child: Row(children: <Widget>[
                    const Text(
                      'Столы',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        //height: 12 / 10,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        'assets/images/tables.svg',
                        semanticsLabel: 'vector',
                      ),
                    ),
                  ])),
              PopupMenuItem(
                  value: '/settr',
                  child: Row(children: <Widget>[
                    const Text(
                      'Настройки',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        // height: 12 / 10,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        'assets/images/setting.svg',
                        semanticsLabel: 'vector',
                      ),
                    ),
                  ])),
            ];
          }),
      title: const Padding(
        padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
        child: Text(
          "Заказы",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 22,
            height: 27 / 22,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                ref.invalidate(listProvider);
              });
            },
            icon: const Icon(Icons.refresh))
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: const TabBar(
                indicatorWeight: 6.0,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                ),
                tabs: [
                  Tab(
                    text: 'ВСЕ',
                  ),
                  Tab(
                    text: 'МОИ',
                  )
                ]),
          ),
        ),
      ),
    );
    return FocusDetector(
      onVisibilityGained: () {
        ref.invalidate(listProvider);
        ref.invalidate(feaProvider);
      },
      onVisibilityLost: () {
        ref.invalidate(listProvider);
        ref.invalidate(feaProvider);
      },
      child: WillPopScope(
        onWillPop: () async {
          final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Вы хотите завершить?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      prefs.then((SharedPreferences prefss) {
                        prefss.setInt('lastDay', DateTime.now().millisecondsSinceEpoch);
                      });
                      Navigator.pop(context, true);
                    },
                    child: const Text('Да'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('Нет'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: Scaffold(
            body: menuStructure.when(
          data: (menuStructure) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(80),
                  child: appBar,
                ),
                body: TabBarView(
                  children: [
                    PreBillListList(widget.waiterId, callBack),
                    PreBillListListMy(widget.waiterId, callBack),
                  ],
                ),
              ),
            );
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xffedf0f1),
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const MyProgressIndicator(
                      text: 'Загружаю МЕНЮ',
                    ),
                    Text(
                      '$percent %',
                      style: const TextStyle(
                          color: Color(0xff8d96b6),
                          fontFamily: 'Montserrat',
                          fontSize: 23.804527282714844,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w800,
                          height: 1.5 /*PERCENT not supported*/
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  ConsumerState<PreBillList> createState() => PreBillListHome();
}

class PreBillListList extends ConsumerWidget {
  const PreBillListList(this.waiterId, this.voidCallback, {super.key});

  final VoidCallback voidCallback;
  final num waiterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    global.ref1 = ref;
    global.context1 = context;
    List<Bill?> billList = [];
    global.isLoading = ref.watch(loadProvider);
    var preBillList = ref.watch(listProvider);

    return Scaffold(
      body: Container(
        child: preBillList.when(
          data: (preBillList) {
            if (preBillList.preBills != null) {
              if (preBillList.preBills!.bill != null) {
                for (var element in preBillList.preBills!.bill!) {
                  if (element != null) {
                    billList.add(element);
                  }
                }
                if (billList.isEmpty) {
                  return const EmptyBillList();
                } else {
                  return BillListPage(billList, voidCallback);
                }
              } else {
                return const EmptyBillList();
              }
            } else {
              return const EmptyBillList();
            }
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => const MyProgressIndicator(),
        ),
      ),
    );
  }
}

class PreBillListListMy extends ConsumerWidget {
  const PreBillListListMy(this.waiterId, this.voidCallback, {super.key});

  final VoidCallback voidCallback;
  final num waiterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    global.ref1 = ref;
    global.context1 = context;
    List<Bill?> billList = [];
    global.isLoading = ref.watch(loadProvider);
    var preBillList = ref.watch(listProvider);
    return Scaffold(
      body: Container(
        child: preBillList.when(
          data: (preBillList) {
            if (preBillList.preBills != null) {
              if (preBillList.preBills!.bill != null) {
                for (var element in preBillList.preBills!.bill!) {
                  if (element != null) {
                    if (element.idwaiter == waiterId) {
                      billList.add(element);
                    }
                  }
                }
                if (billList.isEmpty) {
                  return const EmptyBillList();
                } else {
                  return BillListPage(billList, voidCallback);
                }
              } else {
                return const EmptyBillList();
              }
            } else {
              return const EmptyBillList();
            }
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => const MyProgressIndicator(),
        ),
      ),
    );
  }
}

Future<preBillList> loadPreBillList(num waiterId) async {
  preBillList? pBillList;
  var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
  String request = 'http://${global.uri}/apim/GetPreBills?Id_Waiter=${waiterId.toString()}';
  final response = await dio.get(request);
  debugPrint(response.data!.toString());
  if (response.statusCode == 200) {
    pBillList = preBillList.fromJson(response.data);
    if (pBillList.preBills != null) {
      pBillList.preBills!.bill!.removeWhere((element) => element != null ? element.tablenumber! == 0 : true);
      for (var element in pBillList.preBills!.bill!) {
        if (element!.line!.length > 3) {
          element.line!.length = 4;
          element.line![3].quantity = '0';
          element.line![3].dispname = ' ... ';
        }
      }
    }
  } else {
    pBillList = null;
  }

  return pBillList!;
}

AutoDisposeFutureProvider<preBillList> listProvider = FutureProvider.autoDispose<preBillList>((ref) async {
  return await loadPreBillList(global.waiter.user!.idcode!);
});

AutoDisposeFutureProvider<MenuStructure> menuProvider =
    FutureProvider.autoDispose<MenuStructure>((ref) async {
  return await loadMenu();
});

Future<MenuStructure> loadMenu() async {
  var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
  String request = 'http://${global.uri}/apim/GetMenus';
  final response = await dio.get(request, onReceiveProgress: (count, total) {
    debugPrint('count $count total $total percent ${count / total * 100}');
    ref1!.read(global.percentProvider.notifier).state = (count / total * 100).round();
  });
  if (response.statusCode == 200) {
    global.menuStructure = MenuStructure.fromJson(response.data);
    return global.menuStructure;
  } else {
    return MenuStructure();
  }
}

Future<Fea> loadFeature() async {
  var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
  String request = 'http://${global.uri}/apim/FeaturedItems?Id_Waiter=${global.waiter.user!.idcode}';
  final response = await dio.get(request, onReceiveProgress: (count, total) {
    debugPrint('count $count total $total percent ${count / total * 100}');
    ref1!.read(global.percentProvider.notifier).state = (count / total * 100).round();
  });
  if (response.statusCode == 200) {
    global.fea = Fea.fromJson(response.data);
    global.fea.featuredRoot ??= FeaturedRoot();
    global.fea.featuredRoot!.featuredItems!.item ??= [];
    return global.fea;
  } else {
    return Fea();
  }
}

AutoDisposeFutureProvider<Fea> feaProvider = FutureProvider.autoDispose<Fea>((ref) async {
  return await loadFeature();
});
