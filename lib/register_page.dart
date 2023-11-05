import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

import 'home_page.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _registerWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await userCredential.user?.updateDisplayName(_nameController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Contraseña débil'),
            content:
                const Text('La contraseña debe tener al menos 6 caracteres.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Correo electrónico en uso'),
            content: const Text(
                'Este correo electrónico ya está registrado. Por favor, inicie sesión o utilice un correo electrónico diferente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/logo_principal.png"), // ruta de la imagen de background
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(child: Container()),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 118, 44, 215),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            'Crear Cuenta Nueva',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            style: const TextStyle(
                              color: Colors
                                  .white, // Color del texto ingresado por el usuario
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Nombre completo',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20, // Tamaño de la etiqueta
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Color de la línea cuando enfocado
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Color de la línea cuando no está enfocado
                                ),
                              ),
                            ),
                            cursorColor: Colors.white, // Color del cursor
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese su nombre completo';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors
                                  .white, // Color del texto ingresado por el usuario
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20, // Tamaño de la etiqueta
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Color de la línea cuando enfocado
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Color de la línea cuando no está enfocado
                                ),
                              ),
                            ),
                            cursorColor: Colors.white, // Color del cursor
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese su correo electrónico';
                              }
                              final bool isValid =
                                  EmailValidator.validate(value);
                              if (!isValid) {
                                return 'Ingrese un correo electrónico válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors
                                  .white, // Color del texto ingresado por el usuario
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20, // Tamaño de la etiqueta
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Color de la línea cuando enfocado
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Color de la línea cuando no está enfocado
                                ),
                              ),
                            ),
                            cursorColor: Colors.white, // Color del cursor
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese una contraseña';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _registerWithEmailAndPassword();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white, // Fondo blanco del botón
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    'Registrarse',
                                    style: TextStyle(
                                      color: Color(
                                          0xFF7534DF), // Color de letra morado
                                      fontSize: 20,
                                      fontWeight:
                                          FontWeight.bold, // Texto en negrita
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'Ya tengo cuenta aún? ',
                                style: TextStyle(
                                  color: Colors.white, // Color de letra morado
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal, // Texto normal
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Iniciar sesión',
                                    style: TextStyle(
                                      color:
                                          Colors.white, // Color de letra morado
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold, // Texto en negrita
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
