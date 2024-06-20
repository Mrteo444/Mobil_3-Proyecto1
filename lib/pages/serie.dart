import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Serie());
}

class Serie extends StatelessWidget {
  const Serie({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int indice = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [Body(), SerieContent()];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
      ),
      body: screens[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap: (valor) {
          setState(() {
            indice = valor;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.headphones), label: "Películas"),
          BottomNavigationBarItem(icon: Icon(Icons.add_link), label: "Series")
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  final List<Map<String, String>> movies = [
    {
      "title": "Shrek",
      "image": "https://www.esdip.com/wp-content/uploads/2023/01/historia-de-la-animacion_la-saga-shrek.jpg",
      "videoLink": "https://www.youtube.com/watch?v=CwXOrWvPBPk"
    },
    {
      "title": "Pug",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2_b6IDJ8bWBycqGKLq_psnuAjeRSpgWKCkg&s",
      "videoLink": "https://www.youtube.com/watch?v=tOXszq1-rxs"
    },
    {
      "title": "La Gritona",
      "image": "https://losmitosyleyendas.com/wp-content/uploads/2024/02/image-87.jpg",
      "videoLink": "https://www.youtube.com/watch?v=JoTbiH3Wppo"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Películas"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Películas populares",
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
                return GestureDetector(
                  onTap: () {
                    _launchYouTubeVideo(movies[index]["videoLink"]!);
                  },
                  child: Padding(
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
                              return const SizedBox(
                                width: 120,
                                height: 180,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const SizedBox(
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
                        const SizedBox(height: 8),
                        Text(
                          movies[index]["title"]!,
                          style: const TextStyle(
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
                    _launchYouTubeVideo(movies[index]["videoLink"]!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchYouTubeVideo(String videoLink) async {
    try {
      Uri uri = Uri.parse(videoLink);

      // Manejar diferentes estructuras de URL de YouTube
      String videoId = '';
      if (uri.host == 'www.youtube.com' && uri.path == '/watch') {
        videoId = uri.queryParameters['v'] ?? '';
      } else if (uri.host == 'youtu.be') {
        videoId = uri.pathSegments.first;
      }

      if (videoId.isNotEmpty) {
        final url = 'https://www.youtube.com/watch?v=$videoId';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'No se pudo abrir el video $url';
        }
      } else {
        throw 'Enlace de video de YouTube inválido: $videoLink';
      }
    } catch (e) {
      print('Error al abrir el video: $e');
    }
  }
}

class SerieContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Series"),
      ),
      body: Center(
        child: const Text(
          "Página de series",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
