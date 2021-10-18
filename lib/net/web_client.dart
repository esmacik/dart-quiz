// Erik Macik
// Cross Platform Application Development Fall 2021
// Assignment 1: Dart

import 'package:http/http.dart' as http;
import '../model/multiple_choice_question.dart';
import '../model/fill_in_the_blank_question.dart';
import 'dart:convert';

/// A client to retrieve quiz questions.
class WebClient {
  /// The authority of the quiz server.
  final String _quizServer = 'www.cs.utep.edu';

  /// The path to the quiz questions.
  final String _path = '/cheon/cs4381/homework/quiz/';

  /// The number of calls this client will need to make to retrieve all questions.
  final int _numQuizzes = 15;

  /// Encoded type of a multiple choice type question.
  final int _questionTypeMultipleChoice = 1;

  /// Encoded type of a fill-in-the-blank type question.
  final int _questionTypeFillIn = 2;

  /// Create new web client.
  WebClient();

  /// Get a quiz from the server given a quiz number.
  Future<http.Response> _fetchQuiz(int quizNum) async {
    var newQuizNum =
        'quiz' + (quizNum < 10 ? '0' + quizNum.toString() : quizNum.toString());
    var queryParams = {'quiz': newQuizNum};
    Uri url = Uri.http(_quizServer, _path, queryParams);
    return await http.get(url);
  }

  /// Get all possible questions from the quiz server.
  Future<List<dynamic>> fetchAllQuestions() async {
    var responses = <http.Response>[];
    for (var i = 1; i <= _numQuizzes; i++) {
      responses.add(await _fetchQuiz(i));
    }

    var questionPool = <dynamic>[];
    for (var response in responses) {
      var parsedJson = json.decode(response.body);
      var parsedQuestions = parsedJson['quiz']['question'];

      for (var parsedQuestion in parsedQuestions) {
        var questionType = parsedQuestion['type'];
        if (questionType == _questionTypeMultipleChoice) {
          var options = <String>[];
          for (var option in parsedQuestion['option']) {
            options.add(option);
          }
          questionPool.add(MultipleChoiceQuestion(
              parsedQuestion['stem'], options, parsedQuestion['answer']));
        } else if (questionType == _questionTypeFillIn) {
          var answers = <String>{};
          for (var answer in parsedQuestion['answer']) {
            answers.add(answer);
          }
          questionPool
              .add(FillInTheBlankQuestion(parsedQuestion['stem'], answers));
        }
      }
    }

    return questionPool;
  }

  /// Return a quiz of `size` random questions.
  Future<List<dynamic>> fetchAllQuestionsShuffled([int size = 200]) async {
    var questionPool = await fetchAllQuestions();
    questionPool.shuffle();
    return questionPool.take(size).toList();
  }
}
