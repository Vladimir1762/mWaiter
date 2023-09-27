import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:restismob/global.dart' as global;
import 'package:restismob/models/HallTable.dart';
import 'package:restismob/models/Tables.dart';
import 'package:restismob/widgets/myProgressIndicator.dart';

import '../widgets/tablesGrid.dart';

class TablesList extends HookWidget {
  const TablesList({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: const Color(0xff6C0A39),
      toolbarHeight: 96,
      // centerTitle: true,
      leading: InkWell(
        onTap: () {
          //global.navKey.currentState!.pop();
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white60,
        ),
      ),
      title: const Text(
        "Столы",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          height: 27/22,
          color: Colors.white,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 3 + 30,
            child: const TabBar(
                indicatorWeight: 6.0,
                indicatorColor: Color(0xffFF1D89),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  height: 16/14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                tabs: [
                  Tab(
                    text: 'ВСЕ',
                  ),
                  Tab(
                    text: 'СВОБОДНЫЕ',
                  )
                ]),
          ),
        ),
      ),
    );
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: const Color(0xffEDF0F1),
              appBar: appBar,
              body: TabBarView(
                children: [
                  AllTablesList(global.waiter.user!.idcode!),
                  FreeTablesList(global.waiter.user!.idcode!),
                ],
              ),
            )));
  }
}

class AllTablesList extends ConsumerWidget {
  final num waiterId;

  const AllTablesList(this.waiterId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    global.isLoading = ref.watch(global.loadProvider);
    var hallTable = ref.watch(hallProvider);
    List<Tables> tables = [];
    return Scaffold(
      backgroundColor: const Color(0xffEDF0F1),
      body: SizedBox(
        height: double.infinity,
        child: hallTable.when(
          data: (hallTable) {
            if (hallTable.hall != null) {
              for (var element in hallTable.hall!.tables) {
                if (!(tables.any((item) => item.tablenumber == element.tablenumber))) {
                  tables.add(element);
                }
              }
            }
            return TablesGrid(tables: tables);
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => const MyProgressIndicator(),
        ),
      ),
    );
  }
}

class FreeTablesList extends ConsumerWidget {
  final num waiterId;

  const FreeTablesList(this.waiterId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    global.isLoading = ref.watch(global.loadProvider);
    var hallTable = ref.watch(hallProvider);
    List<Tables> tables = [];
    return Scaffold(
      backgroundColor: const Color(0xffEDF0F1),
      body: SizedBox(
        height: double.infinity,
        child: hallTable.when(
          data: (hallTable) {
            if (hallTable.hall != null) {
              for (var element in hallTable.hall!.tables) {
                if (!(tables.any((item) => item.tablenumber == element.tablenumber)) && element.isused == 0) {
                  tables.add(element);
                }
              }
            }
            return TablesGrid(tables: tables);
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => const MyProgressIndicator(),
        ),
      ),
    );
  }
}

Future<HallTable> loadHallTables(num waiterId) async {
  HallTable? hallTable;
  var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
  String request = 'http://${global.uri}/apim/GetTables?Id_Waiter=${waiterId.toString()}';
  final response = await dio.get(request);
  debugPrint(response.data!.toString());
  if (response.statusCode == 200) {
    hallTable = HallTable.fromJson(response.data);
  } else {
    hallTable = null;
  }
  return hallTable!;
}

AutoDisposeFutureProvider<HallTable> hallProvider = FutureProvider.autoDispose<HallTable>((ref) async {
  return await loadHallTables(global.waiter.user!.idcode!);
});
