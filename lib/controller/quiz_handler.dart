// Erik Macik
// Cross Platform Application Development Fall 2021
// Assignment 1: Dart

import '../model/fill_in_the_blank_question.dart';
import '../model/multiple_choice_question.dart';
import '../model/question.dart';
import '../view/console_ui.dart';

/// Handler containing logic to execute a quiz.
class QuizHandler {

  /// Create new `QuizHandler`.
  QuizHandler();

  /// Begine the quiz.
  void startQuiz(ConsoleUI ui, List<dynamic> questions) {
    var response;
    int questionIndex = 0;
    while (questionIndex >= 0 && questionIndex < questions.length) {
      var currQuestion = questions[questionIndex];
      ui.displayQuestion(currQuestion, questionIndex);

      if (currQuestion.hasResponse) {
        ui.informAlreadyAnswered(currQuestion.response ?? '');
      }

      if (currQuestion is MultipleChoiceQuestion) {
        response = ui.promptAnswer(currQuestion.options.length);
      } else if (currQuestion is FillInTheBlankQuestion) {
        response = ui.promptAnswer();
      }

      if (response == 'n') {
        questionIndex = (questionIndex + 1) % questions.length;
      } else if (response == 'p') {
        questionIndex =
            (questionIndex == 0) ? questions.length - 1 : questionIndex - 1;
      } else if (response == 's') {
        return;
      } else {
        currQuestion.response = response;
        questionIndex = (questionIndex + 1) % questions.length;
      }

      if (allQuestionsAnswered(questions)) {
        ui.remindUserDone();
      }
    }
  }

  /// Return the user's grade given the list of submitted questions.
  int gradeQuiz(List<dynamic> questions) {
    return ((questions.length - getIncorrectQuestions(questions).length) /
            questions.length *
            100)
        .round();
  }

  /// Return the incorrect questions given a list of questions.
  List<dynamic> getIncorrectQuestions(List<dynamic> questions) {
    return questions
        .where((element) => !(element as Question).isAnswerCorrect)
        .toList();
  }

  /// `true` if all questions have been answered and `false` otherwise.
  bool allQuestionsAnswered(List<dynamic> questions) {
    return questions
        .where((element) => !(element as Question).hasResponse)
        .isEmpty;
  }
}
