class Question {
  String questionText = '';
  bool? questionAnswer;

  // Corrected constructor with named parameters
  Question({String q = '', bool? a}) {
    questionText = q;
    questionAnswer = a;
  }
}

// Creating an instance using named parameters
Question newQuestion = Question(q: '', a: true);
