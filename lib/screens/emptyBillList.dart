import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restismob/screens/tablesList.dart';
import 'package:restismob/widgets/myFloatingButton.dart';

import '../global.dart' as global;

class EmptyBillList extends HookWidget {
  const EmptyBillList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF0F1),
      body: Column(
        children: <Widget>[
          const Spacer(
            flex: 2,
          ),
          Container(
              width: 245,
              alignment: Alignment.centerRight,
              child: SvgPicture.asset('assets/images/splash.svg',
                  semanticsLabel: 'vector')),
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 8),
            child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Гоу воркинг',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xff8d96b6),
                      fontFamily: 'Montserrat',
                      fontSize: 23.804527282714844,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w800,
                      height: 1.5 /*PERCENT not supported*/
                      ),
                )),
          ),
          const Spacer(
            flex: 4,
          ),
          MyFloatingBunnon(
            width: 245,
            height: 48,
            borderColor: 0xff6b738e,
            fontColor: 0xff6b738e,
            backColor: 0xffEDF0F1,
            text: "Выбрать стол",
            onPress: () async {
              //await _toTableList();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TablesList()));
            },
          ),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
