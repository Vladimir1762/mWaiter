import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


import '../global.dart' as global;

class MyFloatingBunnon extends HookWidget {
  const MyFloatingBunnon(
      {super.key,
      this.width = 245,
      this.height = 48,
      this.circular = 28,
      this.text = '',
      this.msg = '',
      this.icon = '',
      this.borderColor = 0,
      this.fontColor = 0xffffffff,
      this.backColor,
      this.onPress});

  final double height;
  final double width;
  final double circular;
  final int borderColor;
  final int fontColor;
  final int? backColor;
  final String text;
  final String msg;
  final String icon;
  final AsyncCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(circular),
              border: borderColor != null
                  ? Border.all(
                      color: Color(borderColor),
                      width: 1,
                    )
                  : null,
              color: backColor != null ? Color(backColor!) : null),
          child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: backColor != null
                  ? Color(backColor!)
                  : Theme.of(context).primaryColor,
              onPressed: onPress,
              icon: icon.isEmpty
                  ? null
                  :Image.asset(icon),
              label: global.isLoading
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white60,
                      ),
                    )
                  : Text(text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w800,
                        color: Color(fontColor),
                      ))),
        ),
      ],
    );
  }
}
