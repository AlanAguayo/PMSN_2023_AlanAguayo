import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  final spaceHorizontal = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Background.jpg"),
                fit: BoxFit.cover,
                opacity: 0.5)),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/Logo.png',
                height: 250,
              ),
              spaceHorizontal,
              const Text(
                "Bienvenido",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spaceHorizontal,
              const Text(
                "Esta aplicacion es la que haremos durante el transcurso del semestre. Es una red social de peliculas creo jajaja",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              spaceHorizontal,
              MaterialButton(
                elevation: 0,
                height: 50,
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                color: const Color.fromARGB(255, 59, 160, 255),
                textColor: Colors.black,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Iniciar Sesion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              spaceHorizontal,
              MaterialButton(
                elevation: 0,
                height: 50,
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
                textColor: Colors.black,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Registrarse",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
