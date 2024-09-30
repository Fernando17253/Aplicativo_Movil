import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // Función para obtener la lista de productos desde la API
  Future<void> _fetchProducts() async {
    final url = Uri.parse('https://fakestoreapi.com/products');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          setState(() {
            products = data.map((product) {
              return {
                'title': product['title'] ?? 'Producto no disponible',
                'price': product['price'].toString(),
                'description': product['description'] ?? 'Descripción no disponible',
                'image': product['image'] ?? '',
              };
            }).toList();
          });
        } else {
          setState(() {
            errorMessage = 'No hay productos disponibles.';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error al obtener la lista de productos.';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error de conexión.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : products.isEmpty
          ? Center(child: Text('Lista vacía, no hay productos'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              products[index]['image'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(products[index]['title']),
            subtitle: Text('Precio: \$${products[index]['price']}'),
            onTap: () {
              _showProductDetails(products[index]);
            },
          );
        },
      ),
    );
  }

  // Mostrar detalles del producto en un dialogo
  void _showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product['title']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(product['image'], width: 100, height: 100),
              SizedBox(height: 10),
              Text('Precio: \$${product['price']}'),
              SizedBox(height: 10),
              Text('Descripción:'),
              Text(product['description']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
