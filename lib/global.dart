import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:list_ext/list_ext.dart';
import 'package:restismob/models/menu/Condiment.dart';
import 'package:restismob/models/menu/MenuLine.dart';

import 'models/BillCondiment.dart';
import 'models/Line.dart';
import 'models/Waiter.dart';
import 'models/GetBill.dart';
import 'models/localTypes/condimAlert.dart';
import 'models/menu/MenuHead.dart';
import 'models/menu/MenuStructure.dart';
import 'models/menu/Ware.dart';
import 'models/Featured/Fea.dart';
import 'models/Featured/Item.dart';

MenuStructure menuStructure = MenuStructure();
Waiter waiter = Waiter();
GetBill currentBill = GetBill();
String uri = ''; //81.23.108.42:53537
String? telNum;
BuildContext? context1;
WidgetRef? ref1;
bool isLoading = false;
bool itemSelected = false;
int srvIdLine = 0;
Fea fea = Fea();
bool isSnackbarActive = false;
int lastSelectedGroup = -1;
bool savingBill = false;
bool markSending = false;

final controllerProvider = StateProvider<String>((ref) {
  return "";
});
final loadProvider = StateProvider<bool>((ref) {
  return false;
});
final percentProvider = StateProvider<int>((ref) {
  return 0;
});

String getTimeFromDateAndTime(String date) {
  DateTime dateTime;
  try {
    dateTime = DateTime.parse(date).toLocal();
    //   return DateFormat.jm().format(dateTime).toString(); //5:08 PM
// String formattedTime = DateFormat.Hms().format(dateTime);
    return DateFormat.Hm().format(dateTime); // //17:08  force 24 hour time
  } catch (e) {
    return date;
  }
}

Line billLineFromFeaLine(Item menuLine) {
  Line newLine = Line();
  Ware ware = Ware();
  try {
    ware = menuStructure.menus!.wares!.ware!.firstWhere((element) => element.idcode == menuLine.idware);
    newLine.idbill = currentBill.root!.billHead!.head!.idcode; //json['ID_BILL'];
    newLine.idware = menuLine.idware; //json['ID_WARE'];
    newLine.price = menuLine.price; //json['PRICE'];
    if (ware.inStopList == 1) {
      newLine.quantity = -1;
    } else {
      newLine.quantity = 0;
    } //json['QUANTITY'];
    newLine.taxraterow = 0; //json['TAX_RATE_ROW'];
    newLine.sumraterow = 0; //json['SUM_RATE_ROW'];
    newLine.taxrate = 0; //json['TAX_RATE'];
    newLine.sumrate = 0; //json['SUM_RATE'];
    newLine.markquantity = 0; //json['MARK_QUANTITY'];
    newLine.norder = 1; //json['N_ORDER'];
    newLine.idline = 0; //srvIdLine--; //json['ID_LINE'];
    newLine.dispname = menuLine.dispname; //json['DISP_NAME'];
    newLine.idfline = 0; //json['ID_FLINE'];
    newLine.iscomplex = 0; //json['IS_COMPLEX'];
    newLine.complexquantity = 1; // menuLine.quantity; //json['COMPLEX_QUANTITY'];
    newLine.nodiscount = menuLine.nodiscount; //json['NO_DISCOUNT'];
    newLine.originalid = 0; //json['ORIGINAL_ID'];
    newLine.idmenu = menuLine.idmenu; //json['ID_MENU'];
    newLine.isServed = 0; //json['IsServed'];
    newLine.gnumber = 1; //json['G_NUMBER'];
    newLine.packing = menuLine.packing; //json['PACKING'];
    newLine.unitname = menuLine.unitname; //json['UNIT_NAME'];
    newLine.idshop = menuLine.idshop; //json['ID_SHOP'];
    newLine.marking = menuLine.marking; //json['MARKING'];
    newLine.group = menuLine.idcash;
    newLine.idchoice = 0; //menuLine.idchoice;
    newLine.idcomplexline = 0; //menuLine.idline;
  } catch (e) {
    debugPrint('$e');
  }
  return newLine;
}

Line billLineFromMenuLine(MenuLine menuLine) {
  Line newLine = Line();
  Ware ware = Ware();
  try {
    ware = menuStructure.menus!.wares!.ware!.firstWhere((element) => element.idcode == menuLine.idware);
    if (currentBill.root == null ||
        currentBill.root!.billHead!.head == null ||
        currentBill.root!.msgStatus!.msg!.idStatus == -1) {
      newLine.idbill = -100;
    } else {
      newLine.idbill = currentBill.root!.billHead!.head!.idcode;
    } //json['ID_BILL'];
    newLine.idware = menuLine.idware; //json['ID_WARE'];
    newLine.price = menuLine.price; //json['PRICE'];
    if (ware.inStopList == 1) {
      newLine.quantity = -1;
    } else {
      newLine.quantity = 0;
    } //json['QUANTITY'];
    newLine.taxraterow = 0; //json['TAX_RATE_ROW'];
    newLine.sumraterow = 0; //json['SUM_RATE_ROW'];
    newLine.taxrate = 0; //json['TAX_RATE'];
    newLine.sumrate = 0; //json['SUM_RATE'];
    newLine.markquantity = 0; //json['MARK_QUANTITY'];
    newLine.norder = 1; //json['N_ORDER'];
    newLine.idline = 0; //srvIdLine--; //json['ID_LINE'];
    newLine.dispname = ware.dispname; //json['DISP_NAME'];
    newLine.idfline = 0; //json['ID_FLINE'];
    newLine.iscomplex = 0; //json['IS_COMPLEX'];
    newLine.complexquantity = menuLine.quantity; //json['COMPLEX_QUANTITY'];
    newLine.nodiscount = menuLine.nodiscount; //json['NO_DISCOUNT'];
    newLine.originalid = 0; //json['ORIGINAL_ID'];
    newLine.idmenu = menuLine.idmenu; //json['ID_MENU'];
    newLine.isServed = 0; //json['IsServed'];
    newLine.gnumber = 1; //json['G_NUMBER'];
    newLine.packing = ware.packing; //json['PACKING'];
    newLine.unitname = ware.unitname; //json['UNIT_NAME'];
    newLine.idshop = ware.idshop; //json['ID_SHOP'];
    newLine.marking = ware.marking; //json['MARKING'];
    newLine.group = ware.idcash;
    newLine.idchoice = menuLine.idchoice;
    newLine.idcomplexline = menuLine.idline;
  } catch (e) {
    debugPrint('$e');
  }
  return newLine;
}

List<MenuLine> complexMenuFromMenuLine(MenuHead menuHead) {
  List<MenuLine> comlexMenuLines = [];
  comlexMenuLines.add(MenuLine(
    idmenu: menuHead.idcode,
    quantity: 1,
  ));

  return comlexMenuLines;
}

void addNewLine(Line selectedLine, int gnumber, double quantity, int norder, BuildContext context) {
  BillCondiment bc;
  Condiment sc;
  Line newLine = Line(
    idbill: selectedLine.idbill,
    idware: selectedLine.idware,
    price: selectedLine.price,
    quantity: quantity,
    group: selectedLine.group,
    taxraterow: selectedLine.taxraterow,
    sumraterow: selectedLine.sumraterow,
    taxrate: selectedLine.taxrate,
    sumrate: selectedLine.sumrate,
    markquantity: selectedLine.markquantity,
    norder: norder,
    idline: selectedLine.idline,
    dispname: selectedLine.dispname,
    idfline: selectedLine.idfline,
    iscomplex: selectedLine.iscomplex,
    complexquantity: selectedLine.complexquantity,
    nodiscount: selectedLine.nodiscount,
    originalid: selectedLine.originalid,
    idmenu: selectedLine.idmenu,
    isServed: selectedLine.isServed,
    gnumber: gnumber,
    packing: selectedLine.packing,
    unitname: selectedLine.unitname,
    idshop: selectedLine.idshop,
    marking: selectedLine.marking,
    idchoice: selectedLine.idchoice,
    idcomplexline: selectedLine.idcomplexline,
    iscomplited: selectedLine.iscomplited,
  ); //selectedLine;
  srvIdLine--;
  newLine.idline = srvIdLine;
  newLine.norder = norder;
  newLine.quantity = quantity;
  newLine.markquantity = 0;
  newLine.gnumber = gnumber;

  if (menuStructure.menus!.condiments!.condiment!
          .firstWhereOrNull((element) => element.idfware! == newLine.idware!) !=
      null) {
    List<Condiment> lc = [];
    showDialog(
            builder: (_) => CondAlert(
                  condiments: menuStructure.menus!.condiments!.condiment!,
                  group: newLine.group,
                  idWare: newLine.idware!,
                ),
            context: context)
        .then((value) => {
              if (value != null)
                {
                  lc = value,
                  for(var element in lc) {
                    bc = BillCondiment(),
                    sc = element,
                    srvIdLine--,
                    bc.pkid = srvIdLine,
                    bc.idline = newLine.idline,
                    bc.idware = newLine.idware,
                    bc.idfware = sc.idfware,
                    bc.idcode = sc.idcode,
                    bc.idfgroup = sc.idfgroup,
                    bc.dispname = sc.dispname,
                    bc.idbill = newLine.idbill,
                    bc.idcondiment = sc.idcode,
                    currentBill.root!.billCondiments!.condiment!.add(bc),
                  }
                }
            });
  }
  currentBill.root!.billLines!.line!.add(newLine);
  currentBill.root!.billHead!.head!.amount = currentBill.billSumm();
  lastSelectedGroup = newLine.group!;
}

bool ifLineInLines(int idWare, int guestNumber) {
  return currentBill.root!.billLines!.line!
      .where((element) => (element.idware == idWare) && (element.gnumber == guestNumber))
      .isNotEmpty;
}

Future<bool> saveCurrentBill() async {
  if (!savingBill && currentBill.root!.billHead != null) {
    savingBill = true;
    GetBill? getBill;
    bool result = false;
    try {
      var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
      String request = 'http://$uri/apim/Bill';
      final response = await dio.post(request, data: currentBill.toJson());
      debugPrint(response.data!.toString());
      if (response.statusCode == 200) {
        getBill = GetBill.fromJson(response.data);
        if (getBill.root!.msgStatus != null) {
          if (getBill.root!.msgStatus!.msg!.idStatus == 0) {
            currentBill = getBill;
            if (currentBill.root!.billCondiments!.condiment == null) {
              currentBill.root!.billCondiments!.condiment = [];
            }
            result = true;
          } else {
            result = false;
          }
        } else {
          result = false;
        }
      } else {
        result = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      savingBill = false;
      return false;
    }
    savingBill = false;
    return result;
  } else {
    return true;
  }
}
