import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({this.text = 'Подключаюсь ...', super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          const SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                color: Color(0xff8d96b6),
                strokeWidth: 10,
              )),
          Text(
            text,
            textAlign: TextAlign.left,
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
    );
  }
}
