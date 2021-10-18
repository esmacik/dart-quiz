// Erik Macik
// Cross Platform Application Development Fall 2021
// Assignment 1: Dart

import '../model/fill_in_the_blank_question.dart';
import '../model/multiple_choice_question.dart';
import '../model/question.dart';

/// Helper class responsible for displaying [Question]s to the user.
class QuestionDisplayer {

  /// Display the given [Question] with question number `index`.
  /// 
  /// If the given [Question] is a [MultipleChoiceQuestion], the possible answers
  /// will be displayed as well.
  void displayQuestion(Question question, int index) {
    if (question is MultipleChoiceQuestion) {
      _displayMultipleChoiceQuestion(question, index);
    } else if (question is FillInTheBlankQuestion) {
      _displayFillInTheBlankQuestion(question, index);
    }
  }

  /// Display the correct and provided answers of the given [Question]
  /// with question number `index`.
  void displayQuestionResult(Question question, int index) {
    displayQuestion(question, index);
    if (question is MultipleChoiceQuestion) {
      _displayMultipleChoiceResult(question);
    } else if (question is FillInTheBlankQuestion) {
      _displayFillInTheBlankResult(question);
    }
  }

  /// Display the correct and provided answers of the given [MultipleChoiceQuestion]
  /// with question number `index`.
  void _displayMultipleChoiceResult(MultipleChoiceQuestion question) {
    print('Correct answer was: ${question.correct}');
    print('You chose: ${question.response ?? 'no answer provided'}');
  }

  /// Display the correct and provided answers of the given [FillInTheBlankQuestion]
  /// with question number `index`.
  void _displayFillInTheBlankResult(FillInTheBlankQuestion question) {
    var correctAnswers = '';
    for (var correctAnswer in question.correct) {
      correctAnswers += correctAnswer + ', ';
    }
    correctAnswers = correctAnswers.substring(0, correctAnswers.length - 2);
    print('Possible correct answers: $correctAnswers');
    print('You answered: ${question.response ?? 'no answer provided'}');
  }

  /// Display the given [MultipleChoiceQuestion] with question number `index`.
  void _displayMultipleChoiceQuestion(
      MultipleChoiceQuestion question, int index) {
    print('\n$index. ${question.stem}');
    int i = 1;
    for (var option in question.options) {
      print('\t${i++}. $option');
    }
  }

  /// Display the given [FillInTheBlankQuestion] with question number `index`.
  void _displayFillInTheBlankQuestion(
      FillInTheBlankQuestion question, int index) {
    print('\n$index. ${question.stem}');
  }
}
