import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? uid;
  String? email;
  String? displayName;
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid');
      email = prefs.getString('email');
      displayName = prefs.getString('displayName');
      photoUrl = prefs.getString('photoUrl');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor:
            Color.fromARGB(255, 129, 5, 201), // Color de la barra de navegación
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white, // Color de fondo del avatar
              radius: 80, // Tamaño del avatar
              child: ClipOval(
                child: SizedBox(
                  width: 160, // Tamaño de la imagen
                  height: 160, // Tamaño de la imagen
                  child: photoUrl != null
                      ? Image.network(photoUrl!)
                      : Image.asset('assets/perfil_logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              displayName ?? '',
              style: TextStyle(
                color: Color.fromARGB(255, 129, 5, 201), // Color del nombre
                fontSize: 24, // Tamaño del nombre
                fontWeight: FontWeight.bold, // Texto en negrita
              ),
            ),
            Text(
              email ?? '',
              style: TextStyle(
                color: Colors.black, // Color del correo electrónico
                fontSize: 18, // Tamaño del correo electrónico
              ),
            ),
            Text(
              uid ?? '',
              style: TextStyle(
                color: Colors.black, // Color del ID de usuario
                fontSize: 18, // Tamaño del ID de usuario
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 129, 5, 201), // Fondo del botón
              ),
              child: const Text(
                'Editar perfil',
                style: TextStyle(
                  color: Colors.white, // Color del texto del botón
                  fontSize: 18, // Tamaño del texto del botón
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 129, 5, 201), // Color del icono
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 129, 5, 201), // Color del icono
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Color de fondo de la pantalla
    );
  }
}
