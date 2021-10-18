// Erik Macik
// Cross Platform Application Development Fall 2021
// Assignment 1: Dart

import 'package:dart_quiz/controller/quiz_handler.dart';
import 'package:dart_quiz/net/web_client.dart';
import 'package:dart_quiz/view/console_ui.dart';
import 'package:dart_quiz/view/question_displayer.dart';

/// Main class with main entry point of application.
class Main {
  var _ui = ConsoleUI(QuestionDisplayer());
  var _quizHandler = QuizHandler();
  var webClient = WebClient();
  List<dynamic> _questionPool = <dynamic>[];

  /// Main entrypoint of the quiz application.
  void main() async {
    _ui = ConsoleUI(QuestionDisplayer());
    _quizHandler = QuizHandler();

    var numQuestions = _ui.promptQuizSize();
    _ui.informGettingQuizQuestions();
    _questionPool = await webClient.fetchAllQuestionsShuffled(numQuestions);
    _ui.informDoneGettingQuestions();

    _quizHandler.startQuiz(_ui, _questionPool);
    _ui.displayGrade(_quizHandler.gradeQuiz(_questionPool));

    var incorrectPool = _quizHandler.getIncorrectQuestions(_questionPool);
    _ui.review(incorrectPool);
  }
}

void main() {
  Main().main();
}
