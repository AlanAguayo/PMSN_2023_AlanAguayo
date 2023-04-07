import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practicauno/provider/flags_provider.dart';
import 'package:practicauno/provider/theme_provider.dart';
import 'package:practicauno/routes.dart';
import 'package:practicauno/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final theme = sharedPreferences.getString('theme') ?? 'light';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(theme)),
        ChangeNotifierProvider<FlagsProvider>(
            create: (context) => FlagsProvider()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(theme),
        builder: (context, snapshot) {
          return const PMSNApp();
        },
      ),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settings.currentTheme,
      routes: getApplicationRoutes(),
      home: WelcomeScreen(),
    );
  }
}
