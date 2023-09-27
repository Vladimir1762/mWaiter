import 'package:flutter/material.dart';
import 'package:list_ext/list_ext.dart';

import 'package:restismob/global.dart' as global;
import 'package:restismob/models/menu/MWorkTime.dart';
import 'package:restismob/screens/ComplexList.dart';
import 'package:restismob/widgets/FindWares.dart';
import '../models/Line.dart';
import '../models/menu/Cash.dart';
import '../models/menu/MenuHead.dart';
import '../models/menu/MenuLine.dart';
import '../widgets/MenuListRegular.dart';
import 'BillImageText.dart';

class MenuWithTab extends StatefulWidget {
  final int guestNum;
  final bool canSelect;

  const MenuWithTab({super.key, required this.guestNum, required this.canSelect});

  @override
  State<MenuWithTab> createState() => MenuWithTabHome();
}

class MenuWithTabHome extends State<MenuWithTab> with TickerProviderStateMixin, WidgetsBindingObserver {
  String title = 'Меню';
  List<MenuHead> listMenuHead = [];
  List<MenuHead> listComplexHead = [];
  List<MenuLine> listOfMenuLines = [];
  List<MenuLine> listOfMenuLinesPop = [];
  List<Cash> cashGroups = [];
  List<Line> poplistOfLines = [];
  List<Line> poplistOfLinesAll = [];
  List<Line> listOfLines = [];
  List<Line> listOfLinesAll = [];
  int menuId = 0;
  String menuTitle = '';
  int groupId = 0;
  String groupTitle = '';

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  bool menuInTime(int menuId) {
    bool result = false;
    MWorkTime? mWorkTime = global.menuStructure.menus!.menuWorkTime!.mWorkTime!
        .firstWhereOrNull((element) => element.idmenu == menuId);
    if (mWorkTime != null) {
      double tdNow = toDouble(TimeOfDay.now());
      double beginTD = toDouble(TimeOfDay(
          hour: int.parse(mWorkTime.hourbeg!.split(':')[0]),
          minute: int.parse(mWorkTime.hourbeg!.split(':')[1])));
      double endTD = toDouble(TimeOfDay(
          hour: int.parse(mWorkTime.hourend!.split(':')[0]),
          minute: int.parse(mWorkTime.hourend!.split(':')[1])));
      result = (tdNow >= beginTD) && (tdNow <= endTD) && ((mWorkTime.weekdays! & dayTo()) == dayTo());
    } else {
      result = true;
    }
    return result;
  }

  int dayTo() {
    int i = DateTime.now().weekday;
    switch (i) {
      case 1:
        {
          i = 1;
        }
        break;
      case 2:
        {
          i = 2;
        }
        break;
      case 3:
        {
          i = 4;
        }
        break;
      case 4:
        {
          i = 8;
        }
        break;
      case 5:
        {
          i = 16;
        }
        break;
      case 6:
        {
          i = 32;
        }
        break;
      case 7:
        {
          i = 64;
        }
        break;
    }
    return i;
  }

  void allDataRefresh(int menuID, int groupID) {
    listOfMenuLines.clear();
    listOfLines.clear();
    if (menuId > 0) {
      for (var element in listMenuHead) {
        if (element.idcode == menuID) {
          listOfMenuLines.addAll(element.menuLine!.where((element1) => element1.idmenu == menuID));
          if (groupID > 0) {
            listOfLines.addAll(
                listOfLinesAll.where((element) => (element.idmenu == menuID) && (element.group == groupID)));
          } else {
            listOfLines.addAll(listOfLinesAll.where((element) => (element.idmenu == menuID)));
          }
        }
      }
    } else {
      for (var element in listMenuHead) {
        listOfMenuLines.addAll(element.menuLine!);
      }
      if (groupID > 0) {
        listOfLines.addAll(listOfLinesAll.where((element) => (element.group == groupID)));
      } else {
        listOfLines.addAll(listOfLinesAll);
      }
    }
    listOfLines.sort((a, b) => a.dispname != null
        ? b.dispname != null
            ? a.dispname!.toLowerCase().compareTo(b.dispname!.toLowerCase())
            : 1
        : 0);
    listOfMenuLinesPop.clear();
    listOfMenuLinesPop.addAll(listOfMenuLines);
    listOfMenuLinesPop.sort((a, b) => b.weight!.compareTo(a.weight!));
    poplistOfLinesAll.clear();
    for (var element in listOfMenuLinesPop) {
      if (element.idware != null) {
        poplistOfLinesAll.add(global.billLineFromMenuLine(element));
      }
    }
    poplistOfLines.clear();
    if (groupID > 0) {
      poplistOfLines.addAll(poplistOfLinesAll.where((element) => element.group == groupID));
    } else {
      poplistOfLines.addAll(poplistOfLinesAll);
    }

    if (groupID == 0) {
      List<int> idGroupList = [];
      for (var element in listOfLines) {
        if (element.group != null) {
          if (!idGroupList.contains(element.group)) {
            idGroupList.add(element.group!);
          }
        }
      }

      cashGroups.clear();
      for (var element in idGroupList) {
        cashGroups.addAll(
            global.menuStructure.menus!.cashGroup!.cash!.where((element1) => element1.idcode == element));
      }
      cashGroups.sort((a, b) => a.dispname != null
          ? b.dispname != null
          ? a.dispname!.toLowerCase().compareTo(b.dispname!.toLowerCase())
          : 1
          : 0);
      for (var element in cashGroups) {
        element.backcolor = 0xffffffff;
      }
    }
  }

  late TabController _controller;

  //int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      });
    });
    listMenuHead.clear();
    listMenuHead.add(MenuHead(idcode: 0, dispname: 'ВСЕ', menudate: '', menuLine: [], color: 0xffffff00));
    for (var element in global.menuStructure.menus!.menu!.menuHead!) {
      if ((element.idtype!.contains('ALACARD')) && (menuInTime(element.idcode!))) {
        element.color = 0xffffffff;
        listMenuHead.add(element);
      }
    }

    listComplexHead.clear();
    for (var element in global.menuStructure.menus!.menu!.menuHead!) {
      if ((element.idtype!.contains('COMPLEX')) && (menuInTime(element.idcode!))) {
        element.color = 0xffffffff;
        listComplexHead.add(element);
      }
    }
    if (listComplexHead.isNotEmpty) {
      listMenuHead.add(MenuHead(idcode: -100, dispname: 'КОМП ЛЕКСЫ', menudate: '', menuLine: []));
    }

    listOfLinesAll.clear();
    for (var element in listMenuHead) {
      for (var element1 in element.menuLine!) {
        if (element1.idware != null) {
          listOfLinesAll.add(global.billLineFromMenuLine(element1));
        }
      }
    }

    allDataRefresh(0, 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        var result = global.saveCurrentBill();
        result.then((value) => {
          Navigator.popUntil(context, (route) => route.settings.name == "/prebills")
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
        break;
    }
  }

  void goMsg(int index) {
    late String msg;
    ScaffoldMessenger.of(context).clearSnackBars();
    switch (index) {
      case 0:
        {
          msg = 'Меню';
          break;
        }
      case 1:
        {
          msg = 'Группы';
          break;
        }
      case 2:
        {
          msg = 'Блюда';
          break;
        }
      case 3:
        {
          msg = 'Популярные';
          break;
        }
      case 4:
        {
          msg = 'Поиск';
          break;
        }
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
          child: Text(
            msg,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )),
      backgroundColor: const Color(0xff1A69A3),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: const Color(0xff1A69A3),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).clearSnackBars();
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
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 22,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottom:
          TabBar(indicatorWeight: 6.0, indicatorColor: Colors.white, controller: _controller,
        //      onTap: (index) => goMsg(index),
              tabs: const [
        Tab(
          child: //Text('Меню',textAlign: TextAlign.center,),
          ImageIcon(AssetImage('assets/icons/menu.png'),size: 40, )
        ),
        Tab(
          child: //Text('Группы', textAlign: TextAlign.center,),
          ImageIcon(AssetImage('assets/icons/grouped-list.png'),size: 40, )
        ),
        Tab(
          child: //Text('Блюда', textAlign: TextAlign.center,),
          ImageIcon(AssetImage('assets/icons/dish.png'),size: 40, )
        ),
        Tab(
          child: //Text('Популярные', textAlign: TextAlign.center,),
          ImageIcon(AssetImage('assets/icons/like.png'),size: 40, )
        ),
        Tab(child:
        //Icon(Icons.find_in_page_outlined, size: 40,) //Text('Поиск', textAlign: TextAlign.center,),
        ImageIcon(AssetImage('assets/icons/search.png'),size: 40, )
            )
      ]),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.checklist_rtl_sharp),
          onPressed: () {
            if (global.currentBill.root != null && global.currentBill.root!.billHead!.head != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BillImageText()));
            }
          },
        ),
      ],
    );

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: appBar,
        body: TabBarView(
          controller: _controller,
          children: [
            Scaffold(
              backgroundColor: const Color(0xffEDF0F1),
              body: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: <Widget>[...listMenu(context, listMenuHead)],
              ),
            ),
            Scaffold(
              backgroundColor: const Color(0xffEDF0F1),
              body: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: <Widget>[...listGroup(context, cashGroups)],
              ),
            ),
            MenuListRegular(
              listOfLines: listOfLines,
              guestNumber: widget.guestNum,
              canSelect: widget.canSelect,
            ),
            MenuListRegular(
              listOfLines: poplistOfLines,
              guestNumber: widget.guestNum,
              canSelect: widget.canSelect,
            ),
            Scaffold(
              body: Column(
                children: [
                  Flexible(
                      child: TextButton(
                          onPressed: () {
                            if (global.lastSelectedGroup > 0) {
                              title = cashGroups
                                  .firstWhere((element) => element.idcode == global.lastSelectedGroup)
                                  .dispname!;
                              for (var element in cashGroups) {element.backcolor = 0xffffffff;}
                              cashGroups
                                  .firstWhere((element) => element.idcode == global.lastSelectedGroup).backcolor = 0xff76ff03;
                              allDataRefresh(menuId, global.lastSelectedGroup);
                              global.lastSelectedGroup = -1;
                              _controller.animateTo(2);
                            }
                          },
                          child: const Text('В группу последнего выбранного'))),
                  Flexible(
                    flex: 9,
                    child: FindWares(
                      guestNumber: widget.guestNum,
                      listToFind: listOfLinesAll,
                      canSelect: widget.canSelect,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> listMenu(BuildContext context, List<MenuHead> listOf) {
    List<Widget> listOfWidget = [];
    for (var element in listOf) {
      listOfWidget.add(TextButton(
        onPressed: () {
          for (var element1 in listOf) {
            element1.color = 0xffffffff;
          }
          element.color = 0xffffff00;
          if (element.idcode! == -100) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ComplexList(
                          listComplexHead: listComplexHead,
                          guestNum: widget.guestNum,
                          canSelect: widget.canSelect,
                        )));
          } else {
            setState(() {
              menuId = element.idcode!;
              menuTitle = element.dispname!;
              groupId = 0;
              groupTitle = '';

              allDataRefresh(menuId, groupId);
              title = menuTitle;
              if (cashGroups.isEmpty) {
                _controller.animateTo(2);
              } else {
                _controller.animateTo(1);
              }
            });
          }
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff8d96b6),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Color(element.color!), // Colors.white,
              ),
              child: Center(
                child: Text(
                  element.dispname!,
                  softWrap: true,
                  maxLines: 6,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return listOfWidget;
  }

  List<Widget> listGroup(BuildContext context, List<Cash> listOf) {
    List<Widget> listOfWidget = [];
    for (var element in listOf) {
      listOfWidget.add(TextButton(
        onPressed: () {
          for (var element1 in listOf) {
            element1.backcolor = 0xffffffff;
          }
          setState(() {
            element.backcolor = 0xff76ff03;
            groupId = element.idcode!;
            groupTitle = element.dispname!;
            title = '$menuTitle $groupTitle';
            allDataRefresh(menuId, groupId);
            _controller.animateTo(2);
          });
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff8d96b6),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Color(element.backcolor!), //Colors.white,
              ),
              child: Center(
                child: Text(
                  element.dispname!,
                  softWrap: true,
                  maxLines: 6,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return listOfWidget;
  }
}
