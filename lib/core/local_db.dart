import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static DatabaseHelper? _instance;

  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quiz_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Subject (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE Topics (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            subject_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            FOREIGN KEY (subject_id) REFERENCES Subject (id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE Quiz (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            topic_id INTEGER NOT NULL,
            title TEXT NOT NULL,
            FOREIGN KEY (topic_id) REFERENCES Topics (id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE Questions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quiz_id INTEGER NOT NULL,
            question_text TEXT NOT NULL,
            FOREIGN KEY (quiz_id) REFERENCES Quiz (id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE Options (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question_id INTEGER NOT NULL,
            option_text TEXT NOT NULL,
            is_correct BOOLEAN NOT NULL,
            FOREIGN KEY (question_id) REFERENCES Questions (id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  Future<void> insertSampleData() async {
    final dbHelper = DatabaseHelper.instance;
    // Insert sample data into Subject
    await dbHelper.insertSubject('Mathematics');
    await dbHelper.insertSubject('Science');
    await dbHelper.insertSubject('History');

    // Insert sample data into Topics
    await dbHelper.insertTopic(1, 'Algebra');
    await dbHelper.insertTopic(1, 'Geometry');
    await dbHelper.insertTopic(2, 'Physics');
    await dbHelper.insertTopic(2, 'Chemistry');
    await dbHelper.insertTopic(3, 'World History');
    await dbHelper.insertTopic(3, 'American History');

    // Insert sample data into Quiz
    await dbHelper.insertQuiz(1, 'Linear Equations Quiz');
    await dbHelper.insertQuiz(1, 'Quadratic Equations Quiz');
    await dbHelper.insertQuiz(3, 'Newton Laws Quiz');
    await dbHelper.insertQuiz(4, 'Chemical Reactions Quiz');
    await dbHelper.insertQuiz(5, 'Ancient Civilizations Quiz');

    // Insert sample data into Questions
    await dbHelper.insertQuestion(1, 'What is the solution to 2x + 3 = 7?');
    await dbHelper.insertQuestion(
        1, 'What is the slope of the line y = 2x + 1?');
    await dbHelper.insertQuestion(
        2, 'What is the area of a circle with radius 5?');
    await dbHelper.insertQuestion(3, 'What is Newton’s second law of motion?');
    await dbHelper.insertQuestion(4, 'What is the chemical formula for water?');
    await dbHelper.insertQuestion(
        5, 'Who was the first president of the United States?');

    // Insert sample data into Options
    await dbHelper.insertOption(1, 'x = 2', true);
    await dbHelper.insertOption(1, 'x = 3', false);
    await dbHelper.insertOption(2, 'Slope = 2', true);
    await dbHelper.insertOption(2, 'Slope = 1', false);
    await dbHelper.insertOption(3, 'Area = 78.5', true);
    await dbHelper.insertOption(3, 'Area = 25', false);
    await dbHelper.insertOption(4, 'F = ma', true);
    await dbHelper.insertOption(4, 'F = mv', false);
    await dbHelper.insertOption(5, 'H2O', true);
    await dbHelper.insertOption(5, 'O2', false);
    await dbHelper.insertOption(6, 'George Washington', true);
    await dbHelper.insertOption(6, 'Abraham Lincoln', false);

    print('Sample data inserted successfully!');
  }

  // CRUD Operations

  // Create Subject
  Future<void> insertSubject(String name) async {
    final db = await database;
    await db.insert('Subject', {'name': name});
  }

  // Create Topic
  Future<void> insertTopic(int subjectId, String name) async {
    final db = await database;
    await db.insert('Topics', {'subject_id': subjectId, 'name': name});
  }

  // Create Quiz
  Future<void> insertQuiz(int topicId, String title) async {
    final db = await database;
    await db.insert('Quiz', {'topic_id': topicId, 'title': title});
  }

  // Create Question
  Future<void> insertQuestion(int quizId, String questionText) async {
    final db = await database;
    await db.insert(
        'Questions', {'quiz_id': quizId, 'question_text': questionText});
  }

  // Create Option
  Future<void> insertOption(
      int questionId, String optionText, bool isCorrect) async {
    final db = await database;
    await db.insert('Options', {
      'question_id': questionId,
      'option_text': optionText,
      'is_correct': isCorrect ? 1 : 0
    });
  }

  // Read all Subjects
  Future<List<Map<String, dynamic>>> getAllSubjects() async {
    final db = await database;
    return await db.query('Subject');
  }

  // Read all Topics
  Future<List<Map<String, dynamic>>> getAllTopics() async {
    final db = await database;
    return await db.query('Topics');
  }

  // Read all Quizzes
  Future<List<Map<String, dynamic>>> getAllQuizzes() async {
    final db = await database;
    return await db.query('Quiz');
  }

  // Read all Questions
  Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final db = await database;
    return await db.query('Questions');
  }

  // Read all Options
  Future<List<Map<String, dynamic>>> getAllOptions() async {
    final db = await database;
    return await db.query('Options');
  }

  // * -- Filtered Results --
  // Get all Subjects with the number of Topics and Quizzes
  Future<List<Map<String, dynamic>>> getSubjects(
      {int? subjectId, String? subjectName}) async {
    final db = await database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (subjectId != null) {
      whereClause = 'WHERE Subject.id = ?';
      whereArgs.add(subjectId);
    } else if (subjectName != null) {
      whereClause = 'WHERE Subject.name LIKE ?';
      whereArgs.add('%$subjectName%'); // Use LIKE for partial matching
    }

    final result = await db.rawQuery('''
    SELECT 
      Subject.id, 
      Subject.name, 
      COUNT(DISTINCT Topics.id) AS topic_count, 
      COUNT(DISTINCT Quiz.id) AS quiz_count
    FROM 
      Subject
    LEFT JOIN 
      Topics ON Subject.id = Topics.subject_id
    LEFT JOIN 
      Quiz ON Topics.id = Quiz.topic_id
    $whereClause
    GROUP BY 
      Subject.id
  ''', whereArgs);

    return result;
  }

  // Get Topics by Subject ID with counts of Quizzes and Questions
  Future<List<Map<String, dynamic>>> getTopics({
    int? topicId,
    String? topicName,
    required int subjectId,
  }) async {
    final db = await database;

    String whereClause = 'WHERE Topics.subject_id = ?';
    List<dynamic> whereArgs = [subjectId];

    if (topicId != null) {
      whereClause += ' AND Topics.id = ?';
      whereArgs.add(topicId);
    } else if (topicName != null) {
      whereClause += ' AND Topics.name LIKE ?';
      whereArgs.add('%$topicName%'); // Use LIKE for partial matching
    }

    final result = await db.rawQuery('''
    SELECT 
      Topics.id, 
      Topics.name, 
      COUNT(DISTINCT Quiz.id) AS quiz_count, 
      COUNT(DISTINCT Questions.id) AS question_count
    FROM 
      Topics
    LEFT JOIN 
      Quiz ON Topics.id = Quiz.topic_id
    LEFT JOIN 
      Questions ON Quiz.id = Questions.quiz_id
    $whereClause
    GROUP BY 
      Topics.id
  ''', whereArgs);

    return result;
  }

  // Get Quizzes with their number of Questions
  Future<List<Map<String, dynamic>>> getQuizzes(
      {int? quizId, int? topicId}) async {
    final db = await database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (quizId != null) {
      whereClause = 'WHERE Quiz.id = ?';
      whereArgs.add(quizId);
    } else if (topicId != null) {
      whereClause = 'WHERE Quiz.topic_id = ?';
      whereArgs.add(topicId);
    }

    final result = await db.rawQuery('''
    SELECT 
      Quiz.id, 
      Quiz.title, 
      COUNT(Questions.id) AS question_count
    FROM 
      Quiz
    LEFT JOIN 
      Questions ON Quiz.id = Questions.quiz_id
    $whereClause
    GROUP BY 
      Quiz.id
  ''', whereArgs);

    return result;
  }

  // Get Questions with their correct Option ID from a Quiz ID
  Future<List<Map<String, dynamic>>> getQuestions(int quizId) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT 
      Questions.id AS question_id, 
      Questions.question_text, 
      Options.id AS correct_option_id
    FROM 
      Questions
    LEFT JOIN 
      Options ON Questions.id = Options.question_id
    WHERE 
      Questions.quiz_id = ? AND Options.is_correct = 1
  ''', [quizId]);

    return result;
  }

  // Get Options with the correct Option ID from a Question ID
  Future<List<Map<String, dynamic>>> getOptions(int questionId) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT 
      Options.id AS option_id, 
      Options.option_text, 
      (SELECT id FROM Options WHERE question_id = ?) AS correct_option_id
    FROM 
      Options
    WHERE 
      question_id = ?
  ''', [questionId, questionId]);

    return result;
  }

  // Future<List<Map<String, dynamic>>> getOptions(int questionId) async {
  //   final db = await database;

  //   final result = await db.rawQuery('''
  //   SELECT
  //     Options.id AS question_id,
  //     Options.question_text,
  //   LEFT JOIN
  //     Options ON Questions.id = Options.question_id
  //   WHERE
  //     Options.question_id = ? AND Options.is_correct = 1
  // ''', [questionId]);

  //   return result;
  // }

  // Update Subject
  Future<void> updateSubject(int id, String name) async {
    final db = await database;
    await db.update('Subject', {'name': name},
        where: 'id = ?', whereArgs: [id]);
  }

  // Update Topic
  Future<void> updateTopic(int id, String name) async {
    final db = await database;
    await db.update('Topics', {'name': name}, where: 'id = ?', whereArgs: [id]);
  }

  // Update Quiz
  Future<void> updateQuiz(int id, String title) async {
    final db = await database;
    await db.update('Quiz', {'title': title}, where: 'id = ?', whereArgs: [id]);
  }

  // Update Question
  Future<void> updateQuestion(int id, String questionText) async {
    final db = await database;
    await db.update('Questions', {'question_text': questionText},
        where: 'id = ?', whereArgs: [id]);
  }

  // Update Option
  Future<void> updateOption(int id, String optionText, bool isCorrect) async {
    final db = await database;
    await db.update(
        'Options', {'option_text': optionText, 'is_correct': isCorrect ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
  }

  // Delete Subject
  Future<void> deleteSubject(int id) async {
    final db = await database;
    await db.delete('Subject', where: 'id = ?', whereArgs: [id]);
  }

  // Delete Topic
  Future<void> deleteTopic(int id) async {
    final db = await database;
    await db.delete('Topics', where: 'id = ?', whereArgs: [id]);
  }

  // Delete Quiz
  Future<void> deleteQuiz(int id) async {
    final db = await database;
    await db.delete('Quiz', where: 'id = ?', whereArgs: [id]);
  }

  // Delete Question
  Future<void> deleteQuestion(int id) async {
    final db = await database;
    await db.delete('Questions', where: 'id = ?', whereArgs: [id]);
  }

  // Delete Option
  Future<void> deleteOption(int id) async {
    final db = await database;
    await db.delete('Options', where: 'id = ?', whereArgs: [id]);
  }
}

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:quiz_app/core/app_router.dart';
// import 'package:quiz_app/core/queries.dart';
// import 'package:sqflite/sqflite.dart';

// // ignore: constant_identifier_names
// enum TableName { Subject, Topics, Quiz, Questions, Options }

// class LocalDb {
//   LocalDb._();
//   static LocalDb? _instance;
//   static LocalDb get instance {
//     _instance ??= LocalDb._();
//     return _instance!;
//   }

//   late final Database _database;

//   Future<void> init() async {
//     await _initializeDatabase();
//     await _insertSampleData();
//   }

//   Future<void> _initializeDatabase() async {
//     final String databasePath = await getDatabasesPath();
//     final String path = join(databasePath, 'quiz.db');

//     try {
//       _database = await openDatabase(
//         path,
//         version: 1,
//         onCreate: (db, version) async {
//           // Create Tables table
//           await db.execute(createSubjectTableQuery);
//           await db.execute(createTopicsTableQuery);
//           await db.execute(createQuizTableQuery);
//           await db.execute(createQuestionsTableQuery);
//           await db.execute(createOptionsTableQuery);
//           print('Database created!');
//         },
//       );
//       print('Database opened');
//       print(_database);
//     } on Exception catch (e) {
//       log('Exception occured at _initializeDatabase fn: ${e.toString()}');
//     }
//   }

//   Future<void> _insertSampleData() async {
//     await _database
//         .execute("INSERT INTO Subject (name) VALUES ('SampleSubject')");
//     await _database.transaction((txn) async {
//       // Insert a Subject
//       int subjectId3 = await txn
//           .rawInsert("INSERT INTO Subject (name) VALUES ('SampleSubject')");
//       int subjectId1 = await txn.rawInsert(insertSampleSubject1);
//       int subjectId2 = await txn.rawInsert(insertSampleSubject2);

//       int topicId1 = await txn.rawInsert(insertSampleTopics1);
//       int topicId2 = await txn.rawInsert(insertSampleTopics2);
//       int topicId3 = await txn.rawInsert(insertSampleTopics3);
//       int topicId4 = await txn.rawInsert(insertSampleTopics4);

//       int quizId1 = await txn.rawInsert(insertSampleQuiz1);
//       int quizId2 = await txn.rawInsert(insertSampleQuiz2);

//       int questionId1 = await txn.rawInsert(insertSampleQuestions1);
//       int questionId2 = await txn.rawInsert(insertSampleQuestions2);

//       int optionId1 = await txn.rawInsert(insertSampleOptions1);
//       int optionId2 = await txn.rawInsert(insertSampleOptions1);
//     });
//     print('Sample data inserted!');
//     final List<Map<String, dynamic>> list =
//         await _database.rawQuery('SELECT * FROM Subject');

//     print("Subjects list: $list");
//   }

//   Future<List<Map<String, dynamic>>> getSubjects() async {
//     // Use a JOIN query to fetch all the subjects
//     // var list = await _database!.rawQuery('''SELECT * FROM Subject''');
//     // var list = await _database!.query('Subject', columns: ['id', 'name']);
//     // final List<Map<String, dynamic>> list =
//     //     await _database.rawQuery('SELECT * FROM Subject');
//     final List<Map<String, dynamic>> list = await _database.rawQuery('''SELECT
//     Subject.id AS subject_id,
//     Subject.name AS subject_name,
//     COUNT(DISTINCT Topics.id) AS topic_count,
//     COUNT(Quiz.id) AS quiz_count
// FROM
//     Subject
// LEFT JOIN
//     Topics ON Topics.subject_id = Subject.id
// LEFT JOIN
//     Quiz ON Quiz.topic_id = Topics.id
// GROUP BY
//     Subject.id, Subject.name;
// ''');

//     return list;
//   }

//   Future<List<Map<String, dynamic>>> getTopics({required int subjectId}) async {
//     // Use a JOIN query to fetch topics with subject names
//     var list = await _database.rawQuery('''
//      SELECT
//     Topics.id,
//     Topics.subject_id,
//     Topics.name AS topic_name,
//     Subject.name AS subject_name,
//     COUNT(DISTINCT Quiz.id) AS quiz_count,
//     COUNT(DISTINCT Questions.id) AS question_count
// FROM
//     Topics
// LEFT JOIN
//     Quiz ON Quiz.topic_id = Topics.id
// LEFT JOIN
//     Questions ON Questions.quiz_id = Quiz.id
// INNER JOIN
//     Subject ON Topics.subject_id = Subject.id
// WHERE
//     Topics.subject_id = $subjectId
// GROUP BY
//     Topics.id,
//     Topics.subject_id,
//     Topics.name,
//     Subject.name;
//     ''');

// //     var list = await _database.rawQuery('''
// //       SELECT Topics.id, Topics.subject_id, Topics.name as topic_name, Subject.name as subject_name
// //       COUNT(Quiz.id) AS quiz_count,
// //       COUNT(Questions.id) AS question_count
// //       FROM Topics
// // LEFT JOIN
// //       Quiz ON Quiz.topic_id = Topics.id
// // LEFT JOIN
// //       Questions ON Questions.quiz_id = Quiz.id
// // INNER JOIN Subject ON Topics.subject_id = $subjectId
// //     ''');
//     print(list);
//     return list;
//   }

//   Future<List<Map<String, dynamic>>> getQuiz({required int topicId}) async {
//     // Use a JOIN query to fetch topics with subject names
//     var list = await _database.rawQuery('''
//       SELECT Quiz.id, Quiz.topic_id, Quiz.name, Topics.name AS Topics
//       FROM Quiz
//       INNER JOIN Subject ON Quiz.topic_id = $topicId
//     ''');
//     return list;
//   }

//   Future<List<Map<String, dynamic>>> getQuestions() async {
//     // Use a JOIN query to fetch topics with subject names
//     var list = await _database.rawQuery('''
//       SELECT Questions.id, Questions.quiz_id, Questions.name, Quiz.name AS Quiz
//       FROM Questions
//       INNER JOIN Subject ON Questions.quiz_id = Quiz.id
//     ''');
//     return list;
//     return [];
//   }

//   Future<List<Map<String, dynamic>>> getOptions() async {
//     // Use a JOIN query to fetch topics with subject names
//     var list = await _database.rawQuery('''
//       SELECT Options.id, Options.question_id, Options.option_text, Options.is_correct, Questions.name AS Questions
//       FROM Options
//       INNER JOIN Subject ON Options.question_id = Questions.id
//     ''');
//     return list;
//     return [];
//   }
// }

// showSnackBar(String message) {
//   if (AppRouter.currentContext == null) return;
//   ScaffoldMessenger.of(AppRouter.currentContext!).showSnackBar(
//     SnackBar(content: Text(message)),
//   );
// }
