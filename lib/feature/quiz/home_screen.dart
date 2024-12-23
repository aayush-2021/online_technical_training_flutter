import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:quiz_app/core/app_checkbox.dart';
import 'package:quiz_app/core/app_router.dart';
import 'package:quiz_app/core/local_db.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsList = useState<List>([]);

    Future<void> getSubjects() async {
      subjectsList.value = await DatabaseHelper.instance.getSubjects();
      print(subjectsList.value);
    }

    useEffect(() {
      getSubjects();
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subjectsList.value.length,
              itemBuilder: (context, index) {
                var subject = subjectsList.value[index];
                return GestureDetector(
                  onTap: () => TopicsRoute(subject['id']).push(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${subject['topic_count']} Topics",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${subject['quiz_count']} Quizes",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TopicsScreen extends HookConsumerWidget {
  final int subjectId;
  const TopicsScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicsList = useState([]);

    Future<void> getTopics() async {
      topicsList.value = await DatabaseHelper.instance.getTopics(
        subjectId: subjectId,
      );
      print(topicsList.value);
    }

    useEffect(() {
      getTopics();
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Topics Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topicsList.value.length,
              itemBuilder: (context, index) {
                final topic = topicsList.value[index];
                return GestureDetector(
                  onTap: () => QuizRoute(topic['id']).push(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${topic['quiz_count']} Quizes",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${topic['question_count']}  Questions",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends HookConsumerWidget {
  final int topicId;
  const QuizScreen({super.key, required this.topicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizList = useState([]);

    Future<void> getTopics() async {
      quizList.value = await DatabaseHelper.instance.getQuizzes(
        topicId: topicId,
      );
      print(quizList.value);
    }

    useEffect(() {
      getTopics();
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quizList.value.length,
              itemBuilder: (context, index) {
                final quiz = quizList.value[index];
                return GestureDetector(
                  onTap: () => QuestionsRoute(quiz['id']).push(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${quiz['title']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${quiz['question_count']} Questions",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionsScreen extends HookWidget {
  const QuestionsScreen({super.key, required this.quizId});
  final int quizId;

  @override
  Widget build(BuildContext context) {
    final questionsList = useState([]);
    final optionsList = useState([]);
    // final selectedQuestionId = useState<int?>(null);
    final currentIndex = useState<int?>(null);
    final selectedOptions = useState([]);
    final progress = useState<double?>(null);

    Future<void> getQuestions() async {
      questionsList.value = await DatabaseHelper.instance.getQuestions(quizId);
      print(questionsList.value);
      if (questionsList.value.isNotEmpty) {
        // selectedQuestionId.value = questionsList.value[0]['question_id'];
        currentIndex.value = 0;
        selectedOptions.value =
            List.generate(questionsList.value.length, (index) => null);
      }
    }

    Future<void> getOptions() async {
      if (currentIndex.value == null) {
        return;
      }
      int selectedQuestionId =
          questionsList.value[currentIndex.value!]['question_id'];
      optionsList.value =
          await DatabaseHelper.instance.getOptions(selectedQuestionId);
      print("optionsList => ${optionsList.value}");
    }

    useEffect(() {
      getQuestions();
      return () {};
    }, []);

    useEffect(() {
      getOptions();
      progress.value = (currentIndex.value ?? 0) / questionsList.value.length;
      return () {};
    }, [currentIndex.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions Screen"),
      ),
      body: SingleChildScrollView(
        child: (questionsList.value.isEmpty || currentIndex.value == null)
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * -- Question Text --
                  Text(questionsList.value[currentIndex.value!]
                      ['question_text']),
                  // * -- Options --
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: optionsList.value.length,
                    itemBuilder: (context, index) {
                      final option = optionsList.value[index];
                      return AppCheckBox(
                        textName: option['option_text'],
                        status: selectedOptions.value[currentIndex.value!] ==
                            option['option_id'],
                        isChanged: (val) {
                          List newSelectedOption =
                              List.from(selectedOptions.value);
                          if (val == true) {
                            newSelectedOption[currentIndex.value!] =
                                option['option_id'];
                          } else {
                            selectedOptions.value[currentIndex.value!] = null;
                          }
                          selectedOptions.value = newSelectedOption;
                        },
                      );
                    },
                  ),

                  // * -- Progress Indicator --
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: LinearProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation(Colors.blue),
                      minHeight: 6,
                      value: progress.value,
                    ),
                  ),
                  // * -- Next Button --
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: currentIndex.value == 0
                              ? null
                              : () =>
                                  currentIndex.value = currentIndex.value! - 1,
                          child: const Text("Previous"),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            if (currentIndex.value ==
                                questionsList.value.length - 1) {
                              progress.value = 1;
                              // Submit the Quiz
                              _submitQuiz(
                                correctOptions: questionsList.value
                                    .map((e) => e['correct_option_id'])
                                    .toList(),
                                selectedOptions: selectedOptions.value,
                                questionsList: questionsList.value,
                              );
                              return;
                            }
                            currentIndex.value = currentIndex.value! + 1;
                          },
                          child: Text(
                            (currentIndex.value ==
                                    questionsList.value.length - 1)
                                ? "Submit"
                                : "Next",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _submitQuiz({
    required List correctOptions,
    required List selectedOptions,
    required List questionsList,
  }) async {
    // Check which are wrong...
    if (correctOptions.length != selectedOptions.length) {
      showSnackBar(" You haven't answered all the questions.");
      return;
    }
    int incorrectCount = 0;
    List wrongAnswersList = [];

    for (var i = 0; i < correctOptions.length; i++) {
      if (correctOptions[i] != selectedOptions[i]) {
        incorrectCount++;
        // wrongAnswersList.add({
        //   "question": questionsList[i]['question_text'],
        //   "selectedOption": selectedOptions[i],
        //   "correctOption": correctOptions[i],
        // });

        // List<Map<String,dynamic>> wrongAnswersList

        // List<String> question_textList
        // List<String> selectedOptionList
        // List<String> correctOptionList
      }
    }

    // Navigate to Results Screen... (with incorrect count)
    if (AppRouter.currentContext == null) return;
    ResultsRoute(
      correctCount: correctOptions.length - incorrectCount,
      incorrectCount: incorrectCount,
      wrongAnswersList: wrongAnswersList,
    ).push(AppRouter.currentContext!);
  }
}

void showSnackBar(String message) {
  if (AppRouter.currentContext == null) return;
  ScaffoldMessenger.of(AppRouter.currentContext!).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

class ResultsScreen extends HookConsumerWidget {
  const ResultsScreen({
    super.key,
    required this.correctCount,
    required this.incorrectCount,
    required this.wrongAnswersList,
  });
  final int incorrectCount;
  final int correctCount;
  final List wrongAnswersList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Total Questions: ${correctCount + incorrectCount}"),
            Text("Correct Answers: $correctCount"),
            Text("Incorrect Answers: $incorrectCount"),
            Visibility(
              visible: wrongAnswersList.isEmpty,
              replacement: const Center(
                child: Text("You've scored full marks!"),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: wrongAnswersList.length,
                itemBuilder: (context, index) {
                  final item = wrongAnswersList[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(item["question"]["question_text"]),
                        Text(
                          item["selectedOption"],
                          style: const TextStyle(color: Colors.red),
                        ),
                        Text(
                          item["correctOption"],
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
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
