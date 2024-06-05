import 'package:flutter/material.dart';

void main() {
  runApp(Pelis());
}

class Pelis extends StatelessWidget {
  const Pelis({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Peli(),
    );
  }
}

class Peli extends StatefulWidget {
  const Peli({Key? key});

  @override
  State<Peli> createState() => _PeliState();
}

class _PeliState extends State<Peli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {

  final List<Map<String, String>> movies = [
    {"title": "skrek", "image": "https://www.esdip.com/wp-content/uploads/2023/01/historia-de-la-animacion_la-saga-shrek.jpg"},
    {"title": "pug", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2_b6IDJ8bWBycqGKLq_psnuAjeRSpgWKCkg&s"},
    {"title": "La gritona", "image": "https://losmitosyleyendas.com/wp-content/uploads/2024/02/image-87.jpg"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: precacheImage(
                          NetworkImage(movies[index]["image"]!),
                          context,
                        ),
                        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return SizedBox(
                              width: 120,
                              height: 180,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return SizedBox(
                              width: 120,
                              height: 180,
                              child: Center(
                                child: Text(
                                  "Error de carga de imagen",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 120,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(movies[index]["image"]!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      Text(
                        movies[index]["title"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Más películas",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(movies[index]["image"]!),
                  ),
                  title: Text(movies[index]["title"]!),
                  onTap: () {
                    
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
