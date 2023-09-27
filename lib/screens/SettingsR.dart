import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restismob/models/localTypes/text_input_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:restismob/global.dart' as global;

class SettingsR extends StatefulWidget {
  final bool canEdit;
  final TextStyle titleStyle = const TextStyle(
    fontSize: 18,
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
  );

  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 14,
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
  );

  const SettingsR({super.key, required this.canEdit});

  @override
  State<SettingsR> createState() => SettingsRState();
}

class SettingsRState extends State<SettingsR> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _prefs.then((SharedPreferences prefs) {
      global.telNum = prefs.getString('phone') ?? '';
      return prefs.getString('ipadress') ?? ' Не задан';
    }).then((value) {
      value.isNotEmpty ? global.uri = value : global.uri = ' Не задан';
      //     if (kReleaseMode) {
      if (global.uri.contains('Не задан') || global.uri.isEmpty) {
        global.uri = '81.23.108.42:53537';
//        }
      }

      //    if (kDebugMode) {
      //     if (global.uri.contains('Не задан') ||
      //         global.uri.contains('81.23.108') ||
      //         global.uri.trim().isEmpty) {
      //       global.uri = '192.168.1.33:90';
      //    }
      //  }
    });
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: widget.titleStyle,
      ),
      subtitle: Text(
        subtitle.isNotEmpty ? subtitle : 'Не установлено',
        style: widget.subtitleStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: const Color(0xffC9CFDB),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          //global.navKey.currentState!.pop;
          Navigator.of(context).maybePop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white60,
        ),
      ),
      title: const Text(
        "Настройки",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Card(
              margin: const EdgeInsets.all(5),
              child: _infoTile('Версия приложения :', '${_packageInfo.version}+${_packageInfo.buildNumber}')),
          Card(
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                'IP адрес',
                style: widget.titleStyle,
              ),
              subtitle: Text(
                (global.uri.contains('Не задан') ||
                        global.uri.contains('81.23.108') ||
                        global.uri.trim().isEmpty)
                    ? 'Не задан'
                    : global.uri,
                style: widget.subtitleStyle,
              ),
              trailing: widget.canEdit
                  ? IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        showDialog(
                                context: context,
                                builder: (_) => const TextInputAlert(title: 'Введите адрес и порт'))
                            .then((value) => {
                                  if (value != null)
                                    {
                                      _prefs.then((SharedPreferences prefs) {
                                        prefs.setString('ipadress', value).then(
                                              (bool success) => {
                                                global.uri = value,
                                                setState(() {}),
                                              },
                                            );
                                      }),
                                    },
                                });
                      })
                  : const Text(''),
            ),
          ),
          global.telNum!.isNotEmpty
              ? OutlinedButton(
                  onPressed: () {
                    _prefs.then((SharedPreferences prefss) {
                      prefss.remove('phone');
                    });
                    delWaiter();
                  },
                  child: const Text('Удалить профиль',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      )))
              : Container(),
          const Spacer(
            flex: 2,
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8),
              child: Container(
                  width: 245,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/evras.svg',
                    semanticsLabel: 'vector',
                  )),
            ),
          ),
          const Text(
            '2023',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffC7C8D3),
                fontFamily: 'Montserrat',
                fontSize: 23.804527282714844,
                letterSpacing: 0,
                fontWeight: FontWeight.w400,
                height: 1.5 /*PERCENT not supported*/
                ),
          )
        ],
      ),
    );
  }

  Future<void> delWaiter() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    String version = info.version;
    var dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));
    String request = 'http://${global.uri}/apim/DelUser?Phone=${global.telNum!.trim()}&sVersion=$version';
    // final response = await  dio.get('http://10.0.2.2:53535/apim/GetUser?Phone=79211234567');
    final response = await dio.get(request);
    debugPrint(response.data!.toString());
    if (response.statusCode == 200) {
      goOut();
    }
  }

  void goOut() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
        child: Text(
          'Профиль удалён',
          style: TextStyle(color: Colors.yellowAccent),
        ),
      ),
      backgroundColor: Colors.redAccent,
    ));
    Navigator.popUntil(context, (route) => route.settings.name == "/");
  }
}
