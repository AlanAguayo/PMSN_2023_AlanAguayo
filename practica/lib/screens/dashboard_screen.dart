import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:practicauno/settings/styles.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkThemeEnable = true;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    //theme.setthemeData(StylesApp.darkTheme(context));

    return Scaffold(
      appBar: AppBar(
        title: const Text("TecBook :)"),
      ),
      drawer: Drawer(
        child: ListView(children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc'),
            ),
            accountName: Text('Alan Aguayo'),
            accountEmail: Text('19030034@itcelaya.edu.mx'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled: isDarkThemeEnable,
            onStateChanged: (isDarkModeEnabled) {
              isDarkModeEnabled
                  ? theme.setthemeData(StylesApp.darkTheme(context))
                  : theme.setthemeData(StylesApp.lightTheme(context));

              isDarkThemeEnable = isDarkModeEnabled;

              setState(() {});
            },
          )
        ]),
      ),
    );
  }
}
