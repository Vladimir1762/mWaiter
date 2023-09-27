import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restismob/screens/PreBillsList.dart';
import 'package:restismob/screens/SettingsR.dart';
import 'package:restismob/widgets/myFloatingButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';
import 'models/Waiter.dart';
import 'global.dart' as global;

class Login extends ConsumerWidget {
  final String? phone;

  Login(this.phone, {super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    global.telNum = ref.watch(controllerProvider);
    global.isLoading = ref.watch(loadProvider);
    global.ref1 = ref;
    global.context1 = context;
    var appBar = AppBar(
      backgroundColor: const Color(0xff6b738e),
      centerTitle: true,
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
        "Введите код",
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 22,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const SettingsR(
                        canEdit: true,
                      )));
            },
            icon: const Icon(Icons.settings))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        alignment: Alignment.center,
        height: (MediaQuery
            .of(context)
            .size
            .height - appBar.preferredSize.height) / 2,
        child: Column(
          children: <Widget>[
            const Spacer(),
            phone == null ? _buildTextFields(ref) : _oldPhone(ref),
            const Spacer(),
            MyFloatingBunnon(
              width: 245,
              height: 48,
              fontColor: 0xFFFFFFFF,
              backColor: 0xff6b738e,
              text: "Применить",
              onPress: loadWaiter,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadWaiter() async {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final PackageInfo info = await PackageInfo.fromPlatform();
    Waiter employee;
    try {
      String version = info.version;
      global.ref1
          ?.read(loadProvider.notifier)
          .state = true;
      var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
      String request =
          'http://${global.uri}/apim/GetUser?Phone=${global.telNum!.trim()}&sVersion=$version';
      // final response = await  dio.get('http://10.0.2.2:53535/apim/GetUser?Phone=79211234567');
      final response = await dio.get(request);
      debugPrint(response.data!.toString());
      if (response.statusCode == 200) {
        employee = Waiter.fromJson(response.data);
        if (employee.user!.iderror == 0) {
          waiter = employee;
          global.ref1
              ?.read(loadProvider.notifier)
              .state = false;

          prefs.then((SharedPreferences prefss) {
            prefss.setString('phone', global.telNum!.trim());
            prefss.setInt('lastDay', DateTime
                .now()
                .millisecondsSinceEpoch);
          });
          if (waiter.user!.idcashregister == null || waiter.user!.idcashregister! <= 0) {
            ScaffoldMessenger.of(context1!).showSnackBar(const SnackBar(
              content: Center(
                child: Text(
                  'Не назначена касса',
                  style: TextStyle(color: Colors.yellowAccent),
                ),
              ),
              backgroundColor: Colors.redAccent,
            ));
          }

          Navigator.push(
              context1!,
              MaterialPageRoute(
                  builder: (context) => PreBillList(waiter.user!.idcode!),
                  settings: const RouteSettings(name: "/prebills")));
        } else {
          waiter = Waiter();
          global.ref1
              ?.read(loadProvider.notifier)
              .state = false;
          String msg = 'ОШИБКА !!!';
          if (employee.user!.msgerror != null) {
            msg = employee.user!.msgerror!;
            prefs.then((SharedPreferences prefss) {
              prefss.remove('phone');
            });
          }
          final snackBar = SnackBar(
            backgroundColor: const Color(0xffFF6392),
            content: Text(msg),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context1!).showSnackBar(snackBar);
        }
      } else {
        global.ref1
            ?.read(loadProvider.notifier)
            .state = false;
        ScaffoldMessenger.of(context1!).showSnackBar(const SnackBar(content: Text('ОЙ! Всё сломалось')));
        throw Exception("Cannot get user");
      }
      global.isLoading = false;
    } catch (e) {
      debugPrint(e.toString());
      global.ref1
          ?.read(loadProvider.notifier)
          .state = false;
      ScaffoldMessenger.of(context1!).showSnackBar(const SnackBar(
        content: Text('Нет подключения'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }


  Widget _oldPhone(WidgetRef ref) {
    global.telNum = phone ?? '';
    return const Text(
      'Пока помним номер',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        letterSpacing: 0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextFields(WidgetRef ref) {
    return Column(
      children: <Widget>[
        Container(
          width: 250,
          alignment: Alignment.center,
          child: TextField(
            controller: controller,
            autofocus: true,
            onChanged: (value) {
              ref
                  .read(controllerProvider.notifier)
                  .state = value;
            },
            style: const TextStyle(
              fontSize: 40,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
