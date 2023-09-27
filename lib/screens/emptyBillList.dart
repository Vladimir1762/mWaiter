import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restismob/screens/tablesList.dart';
import 'package:restismob/widgets/myFloatingButton.dart';


class EmptyBillList extends HookWidget {
  const EmptyBillList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xffE4E4E4),
      body: Column(
        children: <Widget>[
          const Spacer(
            flex: 2,
          ),
          Container(
            width: 245,
            alignment: Alignment.centerRight,
            child: SvgPicture.asset('assets/images/splash.svg',
              semanticsLabel: 'vector',
              colorFilter: const ColorFilter.mode(Color(0xff68A3AB), BlendMode.srcIn),),),
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
                      color: Color(0xff000000),
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
            borderColor: 0xff68A3AB,
            fontColor: 0xffFFFFFF,
            backColor: 0xff68A3AB,
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
