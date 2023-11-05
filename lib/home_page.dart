import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_kids/profile_page.dart';
import 'package:student_kids/video_carousel_page.dart';

import 'main.dart';

class HomePage extends StatelessWidget {
  final List<List<String>> subjectVideos = [
    [
      // Enlaces de YouTube para videos de Español para niños de primaria
      'https://www.youtube.com/watch?v=riTxr8y-eVE',
      'https://www.youtube.com/watch?v=riTxr8y-eVE',
      'https://www.youtube.com/watch?v=riTxr8y-eVE',
    ],
    [
      // Enlaces de YouTube para videos de Matemáticas para niños de primaria
      'https://www.youtube.com/watch?v=YFtEaVw5k1A',
      'https://www.youtube.com/watch?v=YFtEaVw5k1A',
      'https://www.youtube.com/watch?v=YFtEaVw5k1A',
    ],
    [
      // Enlaces de YouTube para videos de Ciencias Naturales para niños de primaria
      'https://www.youtube.com/watch?v=wBjaQuyMr18',
      'https://www.youtube.com/watch?v=wBjaQuyMr18',
      'https://www.youtube.com/watch?v=wBjaQuyMr18',
    ],
  ];

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 129, 5, 201),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: const Text(
                    'Student Kids',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 129, 5, 201),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoCarouselPage(
                          subjectTitle: getSubjectTitle(index),
                          videoLinks: subjectVideos[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/materia_${index + 1}.png',
                          width: 64,
                          height: 64,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          getSubjectTitle(index),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 129, 5, 201),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 129, 5, 201),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.person),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getSubjectTitle(int index) {
    switch (index) {
      case 0:
        return 'Español';
      case 1:
        return 'Matemáticas';
      case 2:
        return 'Naturales';
      default:
        return 'Categoría';
    }
  }
}
