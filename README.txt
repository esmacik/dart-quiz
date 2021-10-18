CS 4381/5381: TSE -- Cross-Platform Application Development, Fall 2021

			   HOMEWORK 1: Dart
                 (File $Date: 2021/08/15 05:04:38 $)

Due: September 24

This assignment may be done individually or in pairs. If you work in
pair, you will need to fill out the contribution form.

The purpose of this assignment is to become familiar with the Dart
programming language. You will learn how to create a console-based
application and explore some of the Dart APIs such as collections,
I/O, and networking.

Develop a console-based Dart application [3] for taking quizzes. Your
application shall aid exam preparation by allowing students to take
practice tests. Your application should meet the following functional
and non-functional requirements.

R1. Your app shall maintain a pool of potential test questions (see R3
    below). There are two types of questions: multiple choice
    questions and fill-in-the-blank questions.

    A multiple choice question consists of:
    - a stem that presents the problem to be solved, or the question to
      be answered, and
    - a set of options that are possible answers.  

    A fill-in-the-blank question consists of:
    - a phrase, sentence, or paragraph with a blank space indicating 
      where the student should provide the missing word or words, and 
    - a set of answers is defined for the blank.

R2. Your app shall allow a user to take practice tests by picking up
    an appropriate number of questions, say a fixed number or a number
    requested by the user, from the question pool. The questions may
    be picked up randomly. Your app shall:
    
    a. show to the user all the test questions sequentially, one at 
       a time.
    b. prompt the user for an answer for each question.
    c. grade the test and show the earned points when all the
       questions are answered.

R3. Your app shall acquire questions from the Web service specified
    below to populate your pool of questions.

    URL: http://www.cs.utep.edu/cheon/cs4381/homework/quiz/
    Protocol: GET
    Required parameters
      Name	Type	Description
      quiz      String	Requested quiz, e.g., quiz01
    Response
      Name	Type	Description
      response	Boolean True if request is accepted; false otherwise
      reason    String  Error message if response is false
      quiz	String  JSON-encoded quiz consisting of questions 
    Examples
      http://www.cs.utep.edu/cheon/cs4381/homework/quiz?quiz=quiz99
      {"response": false, "reason": "quiz99 not found"}

      http://www.cs.utep.edu/cheon/cs4381/homework/quiz?quiz=quiz01
      {"response": true, "quiz": { "name": "Quiz 01", "question": [ 
         { "type": 1, "stem": "Flutter ...", "answer": 1, 
           "option": [ "true", "false" ]},
         { "type": 2, "stem": "________ lets you ...",
           "answer": ["Hot reload", "hot reloading"]},
         ... ]}}

R4. You should use the Model-View-Control (MVC) design [1], and your
    model classes should be completely separated from the view and
    control classes. There should be no dependency from model classes
    to view/control classes. Note that in HW2 you will reuse your
    model code to create a Flutter (GUI) version of this app.

R5. Document your code using Dartdoc comments. 

1. (10 points) Design your app and express your design by drawing a
   UML class diagram [2]. Your class diagram should include both model
   classes and UI/Control classes (see R4 above) by using a layered
   architecture, where the business logic layer is completely
   separated from the presentation layer.

   - Your class diagram should show the main components (classes) 
     of your app along with their roles and relationships. 
   - Your model (business logic) classes should be cleanly separated 
     from the view/control (UI) classes with no dependencies.
   - For each class in your diagram, define key (public) operations
     to show its roles, or responsibilities.
   - For each association including aggregation and composition, include
     at least a label, multiplicities and directions.
   - For each class appearing in your class diagram, provide a brief 
     description.

2. (90 points) Code your design by making your code conform to your
   design.

3. (20+ bonus points) Improve the user experience of your app by
   providing a way to:

    a. give better feedback of the test result, e.g., a session to
       review incorrectly-answered questions.

    b. navigate questions, e.g., move to the previous/next questions.

TESTING

   Your code should compile and run correctly on Dart 2.7.1 or later
   versions.

WHAT AND HOW TO TURN IN

   You should submit your program along with supporting documents
   through Blackboard. You should submit a single zip file that
   contains:

   - UML class diagram along with a description (pdf or docx)
   - contribution form if done in pair (pdf or docx)
   - Source code. The Dart src directory in your project folder
     (bin/main.dart and lib/*). Include only Dart source code files;
     do not include other files such as build files or the whole
     project folder.
   - pubspec.yaml: lists package dependencies and other metadata.

   If you work in pair, include both names in the zip file name and
   make only one submission.

DEMO

   You will need to make one or two minutes demo of your app to the
   course staff.

GRADING

   You will be graded on the quality of your design and how clear your
   code is. Excessively long code will be penalized: don't repeat code
   in multiple places. Your code should be well documented by using
   Dartdoc comments and sensibly indented so it is easy to read.

   Be sure your name is in the comments in your source code.

REFERENCES 

   [1] Holger Gast, How to Use Objects, Addison-Wesley, 2016.
       Sections 9.1 and 9.2. Ebook available from UTEP library.

   [2] Martina Seidl, et al., UML@Classroom: An Introduction to
       Object-Oriented Modeling, Springer, 2015. Ebook.

   [3] Write command-line apps,
       https://dart.dev/tutorials/server/cmdline
