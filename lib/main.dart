
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movis_plus/pages/login.dart';
import 'package:movis_plus/pages/registro.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FirebaseApp());
}

class FirebaseApp extends StatelessWidget {
  const FirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOVIS PLUS'),
      ),
      body: Body(context),
    );
  }
}

Widget Body(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Aquí agregamos la imagen
        Image.asset(
          'assets/22.png', // Ruta de la imagen
          width: 200, // Ancho de la imagen
          height: 200, // Alto de la imagen
        ),
        const SizedBox(height: 20), // Espacio entre la imagen y los botones
        const Text('WELCOME'),
        BotonLogin(context),
        BotonRegistro(context),
      ],
    ),
  );
}
Widget BotonLogin(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Loginscreen()),
      );
    },
    child: const Text('Ir a Login'),
  );
}

Widget BotonRegistro(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Registro()),
      );
    },
    child: const Text('Ir a Registro'), // Corrected text
  );
}
