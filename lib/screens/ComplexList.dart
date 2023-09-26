import 'package:flutter/material.dart';
import 'package:restismob/screens/ComplexToSelect.dart';

import '../models/menu/MenuHead.dart';
import 'package:restismob/global.dart' as global;

import 'BillImageText.dart';

class ComplexList extends StatefulWidget {
  final List<MenuHead> listComplexHead;
  final int guestNum;
  final bool canSelect;

  const ComplexList({super.key, required this.listComplexHead, required this.guestNum, required this.canSelect});

  @override
  State<ComplexList> createState() => ComplexListState();
}

class ComplexListState extends State<ComplexList> with WidgetsBindingObserver{
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

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.lightGreen,
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          //global.navKey.currentState!.pop();
          Navigator.of(context).maybePop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white60,
        ),
      ),
      title: const SizedBox(
        height: 48,
        child: Text(
          'КОМПЛЕКСЫ',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.checklist_rtl_sharp),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BillImageText()));
          },
        ),
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: const Color(0xffEDF0F1),
        body: ListView.builder(
          itemCount: widget.listComplexHead.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) => Card(
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text(widget.listComplexHead[index].dispname!,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w800,
                  )),
              //  subtitle: Text(_items[index]['subtitle']),
              trailing: widget.canSelect
              ?IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplexToSelect(
                        menuHead: widget.listComplexHead[index],
                        guestNum: widget.guestNum,
                      ),
                    ),
                  ).then((value){ setState(() { });});
                },
                icon: global.ifLineInLines(widget.listComplexHead[index].idcode!, widget.guestNum)
                    ? const Icon(Icons.check_circle, color: Color(0xff1CE192))
                    : const Icon(Icons.add_circle_outline),
              )
              :const Text(' '),
            ),
          ),
        ),
      ),
    );
  }
}
