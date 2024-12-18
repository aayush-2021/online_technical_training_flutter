import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:session_05/core/show_snackbar.dart';
import 'package:session_05/features/products/presentation/product_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProviderLogger extends ProviderObserver {}

void main() {
  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const Session05App(),
    ),
  );
}

class Session05App extends StatelessWidget {
  const Session05App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LibraryApp(),
    );
  }
}

class LibraryApp extends StatefulWidget {
  const LibraryApp({super.key});

  @override
  State<LibraryApp> createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  Database? _database;
  List books = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'library.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create Authors table
        await db.execute('''
          CREATE TABLE authors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');

        // Create Books table
        await db.execute('''
          CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            authorId INTEGER NOT NULL,
            pages INTEGER,
            FOREIGN KEY (authorId) REFERENCES authors (id)
          )
        ''');
        print('Database and tables created!');
      },
    );
  }

  Future<void> _insertAuthorAndBooks(
    BuildContext context, {
    required String authorName,
    required String bookTitle,
    required int pages,
  }) async {
    if (_database == null) {
      showSnackBar(context, "Database is null");
      return;
    }
    await _database!.transaction((txn) async {
      // Insert an author
      int authorId = await txn.insert('authors', {'name': authorName});

      // Insert books for this author
      int bookId = await txn.insert('books', {
        'title': bookTitle,
        'authorId': authorId,
        'pages': pages,
      });
      if (bookId > 0) {
        _formKey.currentState?.reset();
      }
    });
    print('Author and books inserted!');
  }

  Future<void> _updateBook(
    BuildContext context,
    int bookId,
    String bookTitle,
  ) async {
    if (_database == null) {
      showSnackBar(context, "Database is null");
      return;
    }
    await _database!.transaction((txn) async {
      int id = await txn.update(
        'books',
        {'title': bookTitle},
        where: 'id = ?',
        whereArgs: [bookId],
      );
      if (id > 0) {
        _getBooksWithAuthors();
      }
    });
    print('Author and books inserted!');
  }

  Future<List<Map<String, dynamic>>> _getBooksWithAuthors() async {
    if (_database != null) {
      // Use a JOIN query to fetch books with author names
      var list = await _database!.rawQuery('''
        SELECT books.id, books.title, books.pages, authors.name AS author
        FROM books
        INNER JOIN authors ON books.authorId = authors.id
      ''');
      books = list;
      setState(() {});
      return list;
    }
    return [];
  }

  // Future<List<Map<String, dynamic>>> _paginateBooks(
  //     int limit, int offset) async {
  //   if (_database != null) {
  //     return await _database!.query(
  //       'books',
  //       limit: limit,
  //       offset: offset,
  //     );
  //   }
  //   return [];
  // }

  Future<void> _deleteAuthorAndBooks(BuildContext context, int authorId) async {
    if (_database == null) {
      showSnackBar(context, "Database is null");
      return;
    }
    await _database!.transaction((txn) async {
      // Delete books first (foreign key constraint)
      await txn.delete('books', where: 'authorId = ?', whereArgs: [authorId]);

      // Delete the author
      await txn.delete('authors', where: 'id = ?', whereArgs: [authorId]);
    });
    _getBooksWithAuthors();
    print('Author and their books deleted!');
  }

  Future<void> _deleteBook(BuildContext context, int bookId) async {
    if (_database == null) {
      showSnackBar(context, "Database is null");
      return;
    }
    await _database!.transaction((txn) async {
      // Delete books first (foreign key constraint)
      await txn.delete('books', where: 'id = ?', whereArgs: [bookId]);
    });
    _getBooksWithAuthors();
    print('Book with id $bookId is deleted!');
    showSnackBar(context, "Book with id $bookId is deleted!");
  }

  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController bookTitleController = TextEditingController();
  final TextEditingController updateBookTitleController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // GlobalKey
  // ValueKey
  // UniqueKey
  // ObjectKey
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Author Name",
                      ),
                      controller: authorNameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Book Title",
                      ),
                      controller: bookTitleController,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _insertAuthorAndBooks(
                  context,
                  authorName: authorNameController.text,
                  bookTitle: bookTitleController.text,
                  pages: Random().nextInt(500),
                ),
                child: const Text('Insert Author and Books'),
              ),
              ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> booksWithAuthors =
                      await _getBooksWithAuthors();
                  print('Books with Authors: $booksWithAuthors');
                },
                child: const Text('Get Books with Authors'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Deletes author with ID = 1
                  await _deleteAuthorAndBooks(context, 1);
                },
                child: const Text('Delete Author and Books'),
              ),
              ListView.builder(
                itemCount: books.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var book = books[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("# ${book['id']}"),
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const Text("Edit"),
                                  onTap: () {
                                    updateBookTitleController.text =
                                        book['title'];
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 32,
                                            ),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Edit Book Title",
                                                  ),
                                                  controller:
                                                      updateBookTitleController,
                                                ),
                                                const SizedBox(height: 20),
                                                TextButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    await _updateBook(
                                                      context,
                                                      book['id'],
                                                      updateBookTitleController
                                                          .text,
                                                    );
                                                    await Future.delayed(
                                                      const Duration(
                                                          seconds: 2),
                                                    );
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: isLoading
                                                      ? const CircularProgressIndicator()
                                                      : const Text("Submit"),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Text("Delete"),
                                  onTap: () async {
                                    await _deleteBook(context, book['id']);
                                    setState(() {});
                                  },
                                ),
                              ],
                              child: const Icon(Icons.more_horiz),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${book['title']}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text("${book['pages']} pages"),
                        Text(
                          "by ${book['author']} ",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
