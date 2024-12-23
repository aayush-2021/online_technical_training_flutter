// -- Create Subject table
var createSubjectTableQuery = '''CREATE TABLE Subject (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
)''';

// -- Create Topics table
var createTopicsTableQuery = '''CREATE TABLE Topics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES Subject (id) ON DELETE CASCADE
)''';

// -- Create Quiz table
var createQuizTableQuery = '''CREATE TABLE Quiz (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    topic_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    FOREIGN KEY (topic_id) REFERENCES Topics (id) ON DELETE CASCADE
)''';

// -- Create Questions table
var createQuestionsTableQuery = '''CREATE TABLE Questions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quiz_id INTEGER NOT NULL,
    question_text TEXT NOT NULL,
    FOREIGN KEY (quiz_id) REFERENCES Quiz (id) ON DELETE CASCADE
)''';

// -- Create Options table
var createOptionsTableQuery = '''CREATE TABLE Options (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_id INTEGER NOT NULL,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (question_id) REFERENCES Questions (id) ON DELETE CASCADE
)''';

// -- Insert sample data into Subject
var insertSampleSubject1 =
    '''INSERT INTO Subject (name) VALUES ('Mathematics')''';
var insertSampleSubject2 = '''INSERT INTO Subject (name) VALUES ('Science')''';

// -- Insert sample data into Topics
var insertSampleTopics1 =
    '''INSERT INTO Topics (subject_id, name) VALUES (1, 'Algebra')''';
var insertSampleTopics2 =
    '''INSERT INTO Topics (subject_id, name) VALUES (1, 'Geometry')''';
var insertSampleTopics3 =
    '''INSERT INTO Topics (subject_id, name) VALUES (2, 'Physics')''';
var insertSampleTopics4 =
    '''INSERT INTO Topics (subject_id, name) VALUES (2, 'Chemistry')''';

// -- Insert sample data into Quiz
var insertSampleQuiz1 =
    '''INSERT INTO Quiz (topic_id, title) VALUES (1, 'Linear Equations Quiz')''';
var insertSampleQuiz2 =
    '''INSERT INTO Quiz (topic_id, title) VALUES (3, 'Newton Laws Quiz')''';

// -- Insert sample data into Questions
var insertSampleQuestions1 =
    '''INSERT INTO Questions (quiz_id, question_text) VALUES (1, 'What is the solution to 2x + 3 = 7?')''';
var insertSampleQuestions2 =
    '''INSERT INTO Questions (quiz_id, question_text) VALUES (2, 'What is Newton’s second law of motion?')''';

// -- Insert sample data into Options
var insertSampleOptions1 =
    '''INSERT INTO Options (question_id, option_text, is_correct) VALUES (1, 'x = 2', 1)''';
var insertSampleOptions2 =
    '''INSERT INTO Options (question_id, option_text, is_correct) VALUES (1, 'x = 3', 0)''';
var insertSampleOptions3 =
    '''INSERT INTO Options (question_id, option_text, is_correct) VALUES (2, 'F = ma', 1)''';
var insertSampleOptions4 =
    '''INSERT INTO Options (question_id, option_text, is_correct) VALUES (2, 'F = mv', 0)''';
