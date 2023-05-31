import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/email_auth.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  EmailAuth emailAuth = EmailAuth();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    print('fotolink: ${user.photoURL}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(color: Color.fromARGB(255, 94, 94, 94)),
            ),
            onPressed: () async {
              await emailAuth.signOut(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Perfil',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 32,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Nombre: ${user.displayName}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Correo: ${user.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
