import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Map<String, Map<String, String>> teamMembers = {
      'Miembro1': {
        'name': 'Cesar Augusto Gómez Magdaleno.',
        'phone': '9613775230',
      },
      'Miembro2': {
        'name': 'Cesar Josué Martinez Castillejos.',
        'phone': '9617733405'
      },
      'Miembro3': {
        'name': 'Mario Ernesto Viloria Bonifaz.',
        'phone': '5631772064'
      },
    };

    final List<Widget> teamMembersList = teamMembers.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0), // Espaciado entre las filas
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(
              entry.value['name'] ?? '',
              textAlign: TextAlign.center, // Centramos el nombre
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centramos los botones en la fila
              children: [

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 183, 74, 195)),
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 68, 255, 99),
                  ),
                  child: IconButton(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    icon: const Icon(Icons.phone, color: Colors.white),
                    onPressed: () => _launchURL('tel:${entry.value['phone']}'),
                  ),
                ),

                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.orange.withOpacity(0.1),
                  ),
                  child: IconButton(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    icon: const Icon(Icons.message),
                    onPressed: () async {
                      final messageNumber = Uri.parse('sms:${entry.value['phone']}');
                      if (await launchUrl(messageNumber)) {
                        await launchUrl(messageNumber);
                      } else {
                        throw 'Could not launch $messageNumber';
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();

    return Scaffold(
      
      appBar: AppBar(
        title: Text("Perfil y equipo de trabajo"),
      ),

      body: Center(
        child: SingleChildScrollView( // Scroll en caso de contenido grande
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              Image.asset('assets/images/221237foto.jpg'),
              const Text(
                'José Fernando Durán Villatoro',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                '221237',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'Contacto',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centramos los botones
            children: [


              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 183, 74, 195)),
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 68, 255, 99),
                ),
                child: IconButton(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  icon: const Icon(Icons.phone, color: Colors.white),
                  onPressed: () => _launchURL('tel:9613775230'),
                ),
              ),

              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange.withOpacity(0.1),
                ),
                child: IconButton(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  icon: const Icon(Icons.message),
                  onPressed: () async {
                    final messageNumber = Uri.parse('sms:9613775230');
                    if (await launchUrl(messageNumber)) {
                      await launchUrl(messageNumber);
                    } else {
                      throw 'Could not launch $messageNumber';
                    }
                  },
                ),
              ),

              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 195, 108, 74)),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blueAccent,
                ),
                child: IconButton(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  icon: const Icon(Icons.link, color: Colors.white),
                  onPressed: () => _launchURL('https://example.com'),
                ),
              ),

            ],
          ),

            const SizedBox(height: 30),
            
            const Text(
              'Equipo de trabajo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            ...teamMembersList, // Se mantiene la lógica de la lista

            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
