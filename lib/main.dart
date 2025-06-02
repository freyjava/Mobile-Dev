import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final langCode = prefs.getString('langCode') ?? 'en';
  runApp(MyApp(isDarkMode: isDarkMode, langCode: langCode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  final String langCode;

  const MyApp({super.key, required this.isDarkMode, required this.langCode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;
  late String _langCode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _langCode = widget.langCode;
  }

  void _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = value;
    });
    prefs.setBool('isDarkMode', value);
  }

  void _changeLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _langCode = lang;
    });
    prefs.setString('langCode', lang);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LoginScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
        currentLang: _langCode,
        onLangChanged: _changeLanguage,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
