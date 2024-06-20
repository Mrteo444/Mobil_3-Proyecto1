
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movis_plus/pages/video_playr.screem.dart';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Series());
  
}

class Series extends StatelessWidget {
  const Series({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Lista(),
    );
  }
}
//////////////////////////////////////////////////////
class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<String, dynamic>> peliculasList = [];
  int indice = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    /////////////////////////////////////////
    /// Función con el objetivo de traer los datos
    /////////////////////////////////////////
    
    final response = await http.get(Uri.parse('https://mrteo444.github.io/api_mobiles/peliculas.json'));

    if (response.statusCode == 200) {
      // Decodificar el JSON y actualizar la lista
      updateProductList(json.decode(response.body));
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void updateProductList(List<dynamic> data) {
    List<Map<String, dynamic>> tempList = [];

    data.forEach((element) {
      //////////////////////////////////////////
      /// Se asigna la clave y valor a la lista temporal
      //////////////////////////////////////////
      tempList.add({
        "titulo": element['titulo'],
        
        "url": element['url'], 
      });
    });

    setState(() {
      peliculasList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Películas'),
      ),
      body:Cuerpo(),
      
    );
  }

 Widget Cuerpo() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      childAspectRatio: 0.75,
    ),
    itemCount: peliculasList.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          // Navegar a la pantalla del reproductor de video
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(videoUrl: peliculasList[index]["url"]),
            ),
          );
        },
        child: Card(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Placeholder(), // Placeholder para la imagen
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  peliculasList[index]["titulo"] ?? '', // Verificar si el título existe
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}