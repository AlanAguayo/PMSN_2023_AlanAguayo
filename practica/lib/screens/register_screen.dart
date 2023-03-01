import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../responsive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporaly = File(image.path);
      setState(() {
        this.image = imageTemporaly;
      });
    } on PlatformException catch (e) {
      print('Error pickImage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtUsername = TextFormField(
      decoration: const InputDecoration(
        iconColor: Colors.white,
        label: Text("User Name",
            style: TextStyle(
              color: Colors.white,
            )),
        filled: true,
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Ingresa un nombre';
        } else {
          return null;
        }
      },
    );

    final txtEmail = TextFormField(
        decoration: const InputDecoration(
          iconColor: Colors.white,
          label: Text("Email User",
              style: TextStyle(
                color: Colors.white,
              )),
          filled: true,
          icon: Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: (value) {
          if (value != null && !EmailValidator.validate(value)) {
            return 'Ingresa un correo valido';
          } else {
            return null;
          }
        });

    final txtPass = TextFormField(
        obscureText: true,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          iconColor: Colors.white,
          label: Text(
            "Password",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          filled: true,
          icon: Icon(Icons.password),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Ingresa una contraseña';
          } else {
            return null;
          }
        });

    const spaceHorizontal = SizedBox(height: 15);

    final btnSingUp = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          if (formKey.currentState!.validate()) {}
        });

    final btnImagen = ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        textStyle: const TextStyle(fontSize: 20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 28,
          ),
          SizedBox(
            width: 16,
          ),
          Text('Galeria'),
        ],
      ),
      onPressed: () => pickImage(ImageSource.gallery),
    );

    final btnFoto = ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        textStyle: const TextStyle(fontSize: 20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_album_outlined,
            size: 28,
          ),
          SizedBox(
            width: 16,
          ),
          Text('Foto'),
        ],
      ),
      onPressed: () => pickImage(ImageSource.camera),
    );

    final btnImage = Center(
      child: Stack(
        children: <Widget>[
          image == null
              ? const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/NoImage.png"),
                )
              : ClipOval(
                  child: Image.file(
                    image!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(children: <Widget>[
                        btnFoto,
                        spaceHorizontal,
                        btnImagen,
                      ]),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.camera_alt,
                color: Color.fromARGB(255, 0, 217, 255),
                size: 28,
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Background.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.5)),
          child: Responsive(
            mobile: MobileLoginScreen(
                btnImage: btnImage,
                spaceHorizontal: spaceHorizontal,
                txtUsername: txtUsername,
                txtEmail: txtEmail,
                txtPass: txtPass,
                btnSingUp: btnSingUp),
            desktop: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      btnImage,
                      const Text(
                        "Registro",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      spaceHorizontal,
                      const Text(
                        "Crea una cuenta para comenzar conocer nuevas personas!!",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: FormRegister(
                            txtUsername: txtUsername,
                            spaceHorizontal: spaceHorizontal,
                            txtEmail: txtEmail,
                            txtPass: txtPass,
                            btnSingUp: btnSingUp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
    required this.btnImage,
    required this.spaceHorizontal,
    required this.txtUsername,
    required this.txtEmail,
    required this.txtPass,
    required this.btnSingUp,
  });

  final Center btnImage;
  final SizedBox spaceHorizontal;
  final TextFormField txtUsername;
  final TextFormField txtEmail;
  final TextFormField txtPass;
  final SocialLoginButton btnSingUp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            btnImage,
            spaceHorizontal,
            const Row(
              children: [
                Text(
                  "Registro",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            spaceHorizontal,
            const Text(
              "Crea una cuenta para comenzar conocer nuevas personas!!",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            spaceHorizontal,
            spaceHorizontal,
            FormRegister(
                txtUsername: txtUsername,
                spaceHorizontal: spaceHorizontal,
                txtEmail: txtEmail,
                txtPass: txtPass,
                btnSingUp: btnSingUp),
          ]),
        ],
      ),
    );
  }
}

class FormRegister extends StatelessWidget {
  const FormRegister({
    super.key,
    required this.txtUsername,
    required this.spaceHorizontal,
    required this.txtEmail,
    required this.txtPass,
    required this.btnSingUp,
  });

  final TextFormField txtUsername;
  final SizedBox spaceHorizontal;
  final TextFormField txtEmail;
  final TextFormField txtPass;
  final SocialLoginButton btnSingUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        txtUsername,
        spaceHorizontal,
        txtEmail,
        spaceHorizontal,
        txtPass,
        spaceHorizontal,
        spaceHorizontal,
        btnSingUp,
        spaceHorizontal,
        MaterialButton(
          elevation: 0,
          height: 50,
          onPressed: () {
            Navigator.pushNamed(context, "/login");
          },
          textColor: Colors.black,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Ya tengo una cuenta",
                style: TextStyle(
                  color: Color.fromARGB(255, 165, 198, 255),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
