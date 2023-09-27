import 'package:flutter/material.dart';

class TextInputAlert extends StatefulWidget {
  final String title;

  const TextInputAlert({super.key, required this.title});

  @override
  State<TextInputAlert> createState() => TextInputAlertState();
}

class TextInputAlertState extends State<TextInputAlert> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            controller: controller,
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
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Отмена",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              TextButton(
                  onPressed: () {
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
