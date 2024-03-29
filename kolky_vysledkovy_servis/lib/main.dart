import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'assets/colors.dart';
import 'route.dart';
import 'screens/homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Výsledkový servis',
      theme: ThemeData(
        primarySwatch: primaryColorSwatch,
        scaffoldBackgroundColor: scaffoldBackgroudColor,
        fontFamily: 'Exo',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('sk'),
        Locale('en'),
      ],
      home: const HomePage(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
