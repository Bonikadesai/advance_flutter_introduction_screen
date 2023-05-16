import 'package:contact_dairy_af/Provider/counter_provider.dart';
import 'package:contact_dairy_af/Provider/theme_provider.dart';
import 'package:contact_dairy_af/modals/theme_modal.dart';
import 'package:contact_dairy_af/views/screens/add_contact_page.dart';
import 'package:contact_dairy_af/views/screens/home_page.dart';
import 'package:contact_dairy_af/views/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  bool visited = pref.getBool("isIntrovisited") ?? false;
  bool isThemeDark = pref.getBool("isthemeDark") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(isDark: isThemeDark),
          ),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            brightness: Brightness.light,
            primary: Colors.redAccent,
            secondary: Colors.blueGrey,
          ),
        ),
        darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.amber,
          ),
          colorScheme: ColorScheme.dark(
            brightness: Brightness.dark,
            primary: Colors.yellow,
            secondary: Colors.green,
          ),
        ),
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: (visited) ? 'home_page' : '/',
        routes: {
          '/': (context) => IntroScreen(),
          'home_page': (context) => HomePage(),
          'add_contact_page': (context) => AddContactPage(),
        },
      ),
    ),
  );
}
