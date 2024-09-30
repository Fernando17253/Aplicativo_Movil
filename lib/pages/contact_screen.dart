import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo movil 9B',
      home: Project1View(),
    );
  }
}

class Project1View extends StatefulWidget {
  @override
  _Project1ViewState createState() => _Project1ViewState();
}

class _Project1ViewState extends State<Project1View> {
  final TextEditingController _controller = TextEditingController();
  String _message = ""; // Variable para almacenar el mensaje introducido

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proyecto 1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Introduce algo aquí',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _message = _controller.text; // Actualiza el mensaje con el texto del TextField
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
              ),
              child: Text('Enviar'),
            ),
            SizedBox(height: 20),
            Text(_message, // Muestra el mensaje aquí
                 style: TextStyle(fontSize: 16, color: Colors.black))
          ],
        ),
      ),
    );
  }
}
