import 'package:behtarino/Bindings/ContactsBinding.dart';
import 'package:behtarino/Bindings/SignUpBinding.dart';
import 'package:behtarino/Bindings/VerifySmsBinding.dart';
import 'package:behtarino/View/Pages/ContactsPage.dart';
import 'package:behtarino/View/Pages/VerifySmsPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/Pages/SignUpPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.black,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"),
      ],
      locale: Locale("fa", "IR"),
      theme: ThemeData(
        fontFamily: "IRANSans",
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SignUpPage(), binding: SignUpBinding()),
        GetPage(
            name: "/VerifySms",
            page: () => VerifySmsPage(),
            binding: VerifySmsBinding()),
        GetPage(
            name: "/Contacts",
            page: () => ContactsPage(),
            binding: ContactsBinding()),
      ],
      // home: SignUpPage(),
    );
  }
}
