// Erik Macik
// Cross Platform Application Development Fall 2021
// Assignment 1: Dart

import 'dart:io';
import '../model/question.dart';
import 'question_displayer.dart';
import '../model/multiple_choice_question.dart';
import '../model/fill_in_the_blank_question.dart';

/// Display information about the quiz to the console.
class ConsoleUI {
  /// The question displayer to help the [ConsoleUI] display questions.
  final QuestionDisplayer _questionDisplayer;

  /// Create a new [ConsoleUI] with the given [QuestionDisplayer]
  ConsoleUI(this._questionDisplayer);

  /// Ask the user for the number of questions they'd like their quiz to have.
  int promptQuizSize() {
    stdout.write("\nHow many questions would you like? ");
    return int.parse(stdin.readLineSync() ?? '0');
  }

  /// Inform the user that the program is in the process of retrieving
  ///  quiz questions.
  void informGettingQuizQuestions() {
    stdout.write("\nGetting questions from server...\n");
  }

  /// Inform the user that the program is done getting quiz questions.
  void informDoneGettingQuestions() {
    stdout.write("\nDone getting questions!\n");
  }

  /// Inform the user that this question has already been answered.
  ///
  /// Also displays the provided answer to the question.
  void informAlreadyAnswered(answer) {
    stdout.write(
        'You have already answered this question. Your answer was: $answer\n');
  }

  /// Remind the user that the test has been completed.
  void remindUserDone() {
    stdout.write(
        '\n\tALL QUESTIONS HAVE BEEN ANSWERED.\n\tReminder: [s]ubmit when you are done.\n');
  }

  /// Display the given [Question] with the question number `index`.
  void displayQuestion(Question question, int index) {
    _questionDisplayer.displayQuestion(question, index + 1);
  }

  /// Prompt the answer for a response to a question.
  ///
  /// If `range` is provided, the question type is assumed to be a [MultipleChoiceQuestion].
  /// Otherwise, it is assumed to be a [FillInTheBlankQuestion].
  /// 
  /// The return value may be:
  /// * `'n'` - User wants to see the next question.
  /// * `'p'` - User wants to see the previous question.
  /// * `'s'` - User wants to submit the quiz.
  /// * An `int` - The answer to a [MultipleChoiceQuestion].
  /// * Any other [String] - The answer to a [FillInTheBlankQuestion].
  dynamic promptAnswer([int? range]) {
    if (range == null) {
      stdout.write(
          'Enter your answer, go to the [n]ext or [p]revious question, or [s]ubmit: ');
      return stdin.readLineSync() ?? '';
    } else {
      var response = null;
      while (response == null) {
        stdout.write(
            'Enter your answer (1-$range), go to the [n]ext or [p]revious question, or [s]ubmit: ');
        var entered = stdin.readLineSync() ?? '';
        if (entered == 'n' || entered == 'p' || entered == 's') {
          return entered;
        }
        response = int.tryParse(entered);
        if (response != null && response <= range && response > 0) {
          return response;
        } else {
          response = null;
        }
      }
    }
  }

  /// Display this grade to the user.
  void displayGrade(int grade) {
    stdout.write("\nFinal grade: %$grade\n");
  }

  /// Begin the review for these incorrect questions.
  /// 
  /// Nothing happens if the given list is empty.
  /// 
  /// During execution of this method, possible inputs include:
  /// * `'n'` - User wants to see the next question.
  /// * `'p'` - User wants to see the previous question.
  /// * `'q'` - User wants to end the review.
  void review(List<dynamic> incorrectQuestions) {
    if (incorrectQuestions.isEmpty) {
      return;
    }
    stdout.write('\nIncorrect question review...\n');
    var questionIndex = 0;
    var input = '';
    while (input != 'q') {
      _questionDisplayer.displayQuestionResult(
          incorrectQuestions[questionIndex], questionIndex + 1);
      stdout.write(
          'Go to the [n]ext or [p]revious question, or [q]uit the review: ');
      input = stdin.readLineSync() ?? '';
      if (input == 'n') {
        questionIndex = (questionIndex + 1) % incorrectQuestions.length;
      } else if (input == 'p') {
        questionIndex = (questionIndex == 0)
            ? incorrectQuestions.length - 1
            : questionIndex - 1;
      } else if (input == 'q') {
        return;
      }
    }
  }
}
