import 'package:flutter/material.dart';
import 'package:practicauno/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtEmail = TextFormField(
      decoration: const InputDecoration(
        iconColor: Colors.white,
        hoverColor: Colors.white,
        focusColor: Colors.white,
        label: Text("Email User or Username",
            style: TextStyle(
              color: Colors.white,
            )),
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.email),
      ),
    );

    final txtPass = TextFormField(
      obscureText: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        iconColor: Colors.white,
        hoverColor: Colors.white,
        focusColor: Colors.white,
        label: Text(
          "Password",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.password),
      ),
    );

    const spaceHorizontal = SizedBox(height: 15);

    final btnLogin = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 3000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dashboard');
          });
        });

    final btnGoogle = SocialLoginButton(
        buttonType: SocialLoginButtonType.google, onPressed: () {});

    final btnFacebook = SocialLoginButton(
        buttonType: SocialLoginButtonType.facebook, onPressed: () {});

    final btnRegister = TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/register");
      },
      child: const Text("Registrarse",
          style: TextStyle(color: Color.fromARGB(255, 126, 173, 255))),
    );

    final btnForgot = TextButton(
      onPressed: () {},
      child: const Text(
        "Olvidaste la constraseña?",
        style: TextStyle(color: Color.fromARGB(255, 126, 173, 255)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Background.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: Responsive(
              mobile: MobileLoginScreen(
                  spaceHorizontal: spaceHorizontal,
                  btnRegister: btnRegister,
                  txtEmail: txtEmail,
                  txtPass: txtPass,
                  btnForgot: btnForgot,
                  btnLogin: btnLogin,
                  btnGoogle: btnGoogle,
                  btnFacebook: btnFacebook),
              desktop: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 450,
                          child: Center(child: TopLoginImage()),
                        ),
                        SizedBox(
                            child: LoginScreenTopWidget(
                                spaceHorizontal: spaceHorizontal,
                                btnRegister: btnRegister))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: LoginForm(
                              txtEmail: txtEmail,
                              spaceHorizontal: spaceHorizontal,
                              txtPass: txtPass,
                              btnForgot: btnForgot,
                              btnLogin: btnLogin,
                              btnGoogle: btnGoogle,
                              btnFacebook: btnFacebook),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
    required this.spaceHorizontal,
    required this.btnRegister,
    required this.txtEmail,
    required this.txtPass,
    required this.btnForgot,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
  });

  final SizedBox spaceHorizontal;
  final TextButton btnRegister;
  final TextFormField txtEmail;
  final TextFormField txtPass;
  final TextButton btnForgot;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 100, child: TopLoginImage()),
            LoginScreenTopWidget(
                spaceHorizontal: spaceHorizontal, btnRegister: btnRegister),
            LoginForm(
                txtEmail: txtEmail,
                spaceHorizontal: spaceHorizontal,
                txtPass: txtPass,
                btnForgot: btnForgot,
                btnLogin: btnLogin,
                btnGoogle: btnGoogle,
                btnFacebook: btnFacebook),
          ]),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnForgot,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
  });

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final TextButton btnForgot;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        txtEmail,
        spaceHorizontal,
        txtPass,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            btnForgot,
          ],
        ),
        btnLogin,
        spaceHorizontal,
        const Text(
          "or",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        spaceHorizontal,
        btnGoogle,
        spaceHorizontal,
        btnFacebook,
      ],
    );
  }
}

class LoginScreenTopWidget extends StatelessWidget {
  const LoginScreenTopWidget({
    super.key,
    required this.spaceHorizontal,
    required this.btnRegister,
  });

  final SizedBox spaceHorizontal;
  final TextButton btnRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Iniciar Sesion",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        spaceHorizontal,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No tienes una cuenta?",
                style: TextStyle(
                  color: Colors.white,
                )),
            btnRegister,
          ],
        ),
      ],
    );
  }
}

class TopLoginImage extends StatelessWidget {
  const TopLoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Logo.png',
      height: 250,
    );
  }
}
