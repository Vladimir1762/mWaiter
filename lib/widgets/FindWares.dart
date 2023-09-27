import 'package:flutter/material.dart';
import 'package:restismob/widgets/MenuListRegular.dart';

import '../models/Line.dart';

class FindWares extends StatefulWidget {
  final int guestNumber;
  final List<Line> listToFind;
  final bool canSelect;

  const FindWares({
    super.key,
    required this.guestNumber,
    required this.listToFind,
    required this.canSelect,
  });

  @override
  State<FindWares> createState() => FindWareState();
}

class FindWareState extends State<FindWares> {
  late TextEditingController _controller;
  String fText = '';
  List<Line> listToShow = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (String value) {
                    fText = value;
                    listToShow.clear();
                    for (var element in widget.listToFind) {
                      if (element.dispname != null) {
                        if (element.dispname!.toLowerCase().contains(fText.trim().toLowerCase())) {
                          listToShow.add(element);
                        }
                      }
                    }
                    setState(() {

                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    listToShow.clear();
                    for (var element in widget.listToFind) {
                      if (element.dispname != null) {
                        if (element.dispname!.toLowerCase().contains(fText.trim().toLowerCase())) {
                          listToShow.add(element);
                        }
                      }
                    }
                    setState(() {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    });
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          Flexible(
              child: MenuListRegular(
            guestNumber: widget.guestNumber,
            listOfLines: listToShow,
            canSelect: widget.canSelect,
          ))
        ],
      ),
    );
  }
}
