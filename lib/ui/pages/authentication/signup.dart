import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../controller/authentication_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _FirebaseSignUpState();
}

class _FirebaseSignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: 'a@a.com');
  final controllerPassword = TextEditingController(text: '123456');
  AuthenticationController authenticationController = Get.find();

  _signup(theEmail, thePassword) async {
    try {
      await authenticationController.signUp(theEmail, thePassword);

      Get.snackbar(
        "Sign Up",
        'OK',
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      logError('SignUp error $err');
      Get.snackbar(
        "Sign Up",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(60),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Crear cuenta",
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
                              const InputDecoration(labelText: "Dirección de email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              logError('SignUp validation empty email');
                              return "Ingrese una dirección de email";
                            } else if (!value.contains('@')) {
                              logError('SignUp validation invalid email');
                              return "Dirección de email inválida";
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
                          decoration:
                              const InputDecoration(labelText: "Password"),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese la contraseña";
                            } else if (value.length < 6) {
                              return "La contraseña debe tener al menos 6 dígitos";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 80,
                        ),

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
                                  final form = _formKey.currentState;
                                  form!.save();
                                  // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if (_formKey.currentState!.validate()) {
                                    logInfo('SignUp validation form ok');
                                  await _signup(controllerEmail.text,
                                    controllerPassword.text);
                                } else {
                                  logError('SignUp validation form nok');
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Text("Crear")),
                            ],
                          ),
                        ),
                      ]),
                ))));
  }
}
