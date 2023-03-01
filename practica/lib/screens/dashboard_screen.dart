import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:practicauno/screens/list_post_screen.dart';
import 'package:practicauno/settings/styles.dart';
import 'package:practicauno/widgets/modal_add_post.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _openCustomDialog();
        },
        label: const Text('Post it!'),
        icon: const Icon(Icons.add_comment),
      ),
      //body: const ListPostScreen(),
    );
  }

  _openCustomDialog() {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: const ModalAddPost(),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
    );
  }
}
