import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:practicauno/card_welcome.dart';
import '../responsive.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final data = [
    CardWelcomeData(
      title: 'TecNM Celaya',
      subtitle:
          'Una institución de educación superior localizado en la ciudad de Celaya, Gto.',
      image: const AssetImage('assets/TecNM.png'),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      background: const LottieImage('assets/background1.json'),
      child: Container(),
    ),
    CardWelcomeData(
      title: 'Sistemas computacionales',
      subtitle:
          'Se ocupa del desarrollo, operación y mantenimiento de productos de software asegurando su calidad.',
      image: const AssetImage('assets/IngSisComp.png'),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: const LottieImage('assets/background2.json'),
      child: Container(),
    ),
    const CardWelcomeData(
      title: 'Instalaciones',
      subtitle:
          'Estrena los nuevos edificios de Ciencias Económico Administrativas e Idiomas y la Plaza del Estudiante. \n Construye la Unidad de Investigación y Desarrollo Tecnológico.',
      image: AssetImage('assets/InstalacionesTec.jpg'),
      backgroundColor: Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieImage('assets/background3.json'),
      child: BottomButtons(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          verticalPosition: 0.73,
          itemCount: data.length,
          itemBuilder: (int index) {
            return CardWelcome(data: data[index]);
          },
        ),
        desktop: ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          verticalPosition: 0.9,
          radius: 800,
          itemCount: data.length,
          itemBuilder: (int index) {
            return CardWelcome(data: data[index]);
          },
        ),
      ),
    );
  }
}

class LottieImage extends StatelessWidget {
  const LottieImage(this.background, {super.key});

  final String background;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Padding(
        padding: const EdgeInsets.only(top: 350),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: LottieBuilder.asset(
            background,
            fit: BoxFit.cover,
          ),
        ),
      ),
      desktop: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          alignment: Alignment.bottomLeft,
          child: LottieBuilder.asset(
            background,
          ),
        ),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Responsive(
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
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
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
