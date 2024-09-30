const express = require('express');
const mysql = require('mysql2');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware para procesar JSON
app.use(express.json());

// Conexión a la base de datos MySQL
const db = mysql.createConnection({
  host: 'localhost',     // Cambia a tu host si es necesario
  user: 'root',          // Usuario de MySQL
  password: 'Pepenando1',  // Contraseña de MySQL
  database: 'my_database' // Nombre de la base de datos que creaste
});

// Conectar a la base de datos
db.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('Conectado a MySQL');
});

// Rutas de la API

// Obtener todos los productos
app.get('/api/products', (req, res) => {
  const query = 'SELECT * FROM products';
  db.query(query, (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json(results);
  });
});

// Crear un nuevo producto
app.post('/api/products', (req, res) => {
  const { name, price, description } = req.body;
  const query = 'INSERT INTO products (name, price, description) VALUES (?, ?, ?)';
  
  db.query(query, [name, price, description], (err, result) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.status(201).json({ id: result.insertId, name, price, description });
  });
});

// Obtener un producto por ID
app.get('/api/products/:id', (req, res) => {
  const query = 'SELECT * FROM products WHERE id = ?';
  db.query(query, [req.params.id], (err, result) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (result.length === 0) {
      res.status(404).json({ message: 'Producto no encontrado' });
      return;
    }
    res.json(result[0]);
  });
});

// Actualizar un producto
app.put('/api/products/:id', (req, res) => {
  const { name, price, description } = req.body;
  const query = 'UPDATE products SET name = ?, price = ?, description = ? WHERE id = ?';
  
  db.query(query, [name, price, description, req.params.id], (err, result) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json({ message: 'Producto actualizado' });
  });
});

// Eliminar un producto
app.delete('/api/products/:id', (req, res) => {
  const query = 'DELETE FROM products WHERE id = ?';
  
  db.query(query, [req.params.id], (err, result) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json({ message: 'Producto eliminado' });
  });
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
