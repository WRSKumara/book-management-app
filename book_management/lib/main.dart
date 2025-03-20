import 'package:flutter/material.dart';

void main() {
  runApp(BookManagementApp());
}

class BookManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  // List to store books in memory
  final List<Book> _books = [];

  // Controllers for text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  // Method to add a new book
  void _addBook() {
    final String title = _titleController.text.trim();
    final String author = _authorController.text.trim();

    if (title.isNotEmpty && author.isNotEmpty) {
      setState(() {
        _books.add(Book(title: title, author: author));
        _titleController.clear();
        _authorController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both title and author')),
      );
    }
  }

  Color _buttonColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Management',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form to add a new book
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Book Title',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.book, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'Author',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 10),
            MouseRegion(
              onEnter: (_) => setState(() => _buttonColor = Colors.red),
              onExit: (_) => setState(() => _buttonColor = Colors.blueAccent),
              child: ElevatedButton(
                onPressed: _addBook,
                child: Text('Add Book'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Display list of books
            Expanded(
              child:
                  _books.isEmpty
                      ? Center(child: Text('No books added yet'))
                      : ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];
                          return ListTile(
                            title: Text(book.title),
                            subtitle: Text('by ${book.author}'),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
