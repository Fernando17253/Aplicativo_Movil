import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  String? _productName;
  String? _description;
  double? _price;

  // Función para agregar un producto a la API
  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // URL de la Fake Store API para agregar productos
      final url = Uri.parse('https://fakestoreapi.com/products');

      // Datos a enviar
      final body = json.encode({
        'title': _productName,
        'price': _price.toString(), // Convertimos el precio a cadena
        'description': _description,
        'image': 'https://i.pravatar.cc', // Imagen por defecto
        'category': 'electronics', // Categoría simulada
      });

      try {
        // Enviamos la solicitud POST
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        // Verificamos la respuesta
        if (response.statusCode == 201 || response.statusCode == 200) {
          // Registro exitoso
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Producto agregado exitosamente')),
          );
        } else {
          // Fallo en el registro
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al agregar el producto')),
          );
        }
      } catch (error) {
        // Manejo de errores de conexión
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión')),
        );
      }
    } else {
      // Si la validación falla, mostramos un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rellene todos los campos correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: SingleChildScrollView( // Permite el desplazamiento si el formulario es muy largo
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre del Producto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productName = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio';
                  }
                  try {
                    double.parse(value); // Verificamos si el valor es numérico
                  } catch (e) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.tryParse(value!); // Guardamos el precio como número
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Agregar Producto'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/product_list'); // Asegúrate de que esta ruta exista
                },
                child: Text('Ver Lista de Productos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
