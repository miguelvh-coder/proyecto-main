import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../controller/authentication_controller.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: 'a@a.com');
  final controllerPassword = TextEditingController(text: '123456');
  AuthenticationController authenticationController = Get.find();

  _login(theEmail, thePassword) async {
    logInfo('_login $theEmail $thePassword');
    try {
      await authenticationController.login(theEmail, thePassword);
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Iniciar sesión",
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      cursorColor: Colors.green,
                      keyboardType: TextInputType.emailAddress,
                      controller: controllerEmail,
                      decoration:
                          const InputDecoration(labelText: "Email address"),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Ingrese su email";
                        } else if (!value.contains('@')) {
                          return "Ingrese una dirección de email válido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    TextFormField(
                      cursorColor: Colors.green,
                      controller: controllerPassword,
                      decoration: const InputDecoration(labelText: "Contraseña"),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Ingrese la contraseña";
                        } else if (value.length < 6) {
                          return "La contraseña debe tener al menos 6 dígitos";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 70,
                    ),


                    //toneladas de código para adornar un botón
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 11, 232, 187),
                                    Color.fromARGB(255, 48, 144, 241),
                                    Color(0xFF42A5F5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                              FocusScope.of(context).requestFocus(FocusNode());
                              final form = _formKey.currentState;
                              form!.save();
                              if (_formKey.currentState!.validate()) {
                                await _login(controllerEmail.text, controllerPassword.text);
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(14.0),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          child: const Text("Ingresar")),
                        ],
                      ),
                    ),

                  ]),
            ),


            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text("Crear cuenta"))
          ],
        ),
      ),
    );
  }
}
