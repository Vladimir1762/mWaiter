import 'package:flutter/material.dart';

class TextInputAlert extends StatefulWidget {
  final String title;
  final TextInputType textInputType;

  const TextInputAlert({super.key, required this.title, this.textInputType = TextInputType.text});

  @override
  State<TextInputAlert> createState() => TextInputAlertState();
}

class TextInputAlertState extends State<TextInputAlert> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 22,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: widget.textInputType,
            controller: controller,
            autofocus: true,
            style: const TextStyle(
              fontSize: 22,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Отмена",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (controller.text.isEmpty) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.pop(context, controller.text);
                    }
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(color: Colors.green),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
