import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practicauno/firebase/email_auth.dart';
import 'package:practicauno/widgets/loading_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../responsive.dart';

EmailAuth emailAuth = EmailAuth();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  late StreamSubscription _subs;
  bool loader = false;

  @override
  void initState() {
    loader = false;
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((link) {
      _checkDeepLink(link!);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      emailAuth.signInWithGithub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: ${firebaseUser.displayName}");
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
    }
  }

  void onClickGitHubLoginButton() async {
    const String url =
        "https://github.com/login/oauth/authorize?client_id=15b6215cdb2ddf501d02&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      setState(() {
        loader = true;
      });
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      setState(() {
        loader = false;
      });
      print("CANNOT LAUNCH THIS URL!");
    }
  }

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
        buttonType: SocialLoginButtonType.google,
        onPressed: () {
          emailAuth.signInWithGoogle(context);
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 3000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dashboard');
          });
        });

    final btnGithub = SocialLoginButton(
        buttonType: SocialLoginButtonType.github,
        onPressed: () {
          onClickGitHubLoginButton();
        });

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
                  btnGithub: btnGithub),
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
                              btnGithub: btnGithub),
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
    required this.btnGithub,
  });

  final SizedBox spaceHorizontal;
  final TextButton btnRegister;
  final TextFormField txtEmail;
  final TextFormField txtPass;
  final TextButton btnForgot;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnGithub;

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
                btnGithub: btnGithub),
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
    required this.btnGithub,
  });

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final TextButton btnForgot;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnGithub;

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
        btnGithub,
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
