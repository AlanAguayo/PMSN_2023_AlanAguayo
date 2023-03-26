import 'package:flutter/material.dart';
import 'package:practicauno/provider/flags_provider.dart';
import 'package:practicauno/screens/list_post_screen.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/future_modal.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _toggleTheme(theme) {
    final settings = Provider.of<ThemeProvider>(context, listen: false);
    settings.toggleTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

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
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/event');
            },
            horizontalTitleGap: 0.0,
            leading: const Icon(Icons.calendar_month),
            title: const Text(
              'Eventos',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/popular');
            },
            horizontalTitleGap: 0.0,
            leading: const Icon(Icons.movie),
            title: const Text(
              'API Movies',
              style: TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
          DropdownButtonFormField<String>(
              isExpanded: true,
              value: theme.getTheme(),
              decoration: const InputDecoration(
                labelText: 'Tema',
                prefixIcon: Icon(Icons.color_lens),
              ),
              items: <String>['light', 'dark', 'obscure'].map((i) {
                return DropdownMenuItem(
                    value: i,
                    child: Text(
                      i,
                    ));
              }).toList(),
              hint: const Text('Tema'),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              onChanged: (value) {
                if (value == 'light') {
                  _toggleTheme('light');
                }
                if (value == 'dark') {
                  _toggleTheme('dark');
                }
                if (value == 'obscure') {
                  _toggleTheme('obscure');
                }
              }),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          openCustomDialog(context, null, null, 'Post');
        },
        label: const Text('Post it!'),
        icon: const Icon(Icons.add_comment),
      ),
      body: flags.getUpdate() == true
          ? const ListPostScreen()
          : const ListPostScreen(),
    );
  }
}
