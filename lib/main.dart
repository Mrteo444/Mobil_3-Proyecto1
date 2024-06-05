import 'package:flutter/material.dart';
import 'package:movis_plus/pages/peli.dart';
import 'package:movis_plus/pages/serie.dart';

void main() {
  runApp(const MoviPlus());
}

class MoviPlus extends StatelessWidget {
  const MoviPlus({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indice=0; 
  @override
  Widget build(BuildContext context) {
     List<Widget> screens=[Cuerpo(context),Peli(),Serie()];
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Movis plus'),
      ),
      body: screens[indice],
      bottomNavigationBar:BottomNavigationBar(
        currentIndex : indice,
        onTap: (valor){
          setState(() {
            indice=valor;
          });
        },
       
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.movie),label: "peliculas"),
          BottomNavigationBarItem(icon: Icon(Icons.folder),label: "Series"),
          //BottomNavigationBarItem(icon: Icon(Icons.add_link),label: "Config"),
          
        ],) 



    );
  }
}

Widget Cuerpo(context){
  return(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("bievenido"),
        
      ],
    )
  );
}


