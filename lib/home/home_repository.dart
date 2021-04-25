import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:devquiz/shared/models/quiz_model.dart';
import 'package:devquiz/shared/models/user_model.dart';

class HomeRepository {
  Future<UserModel> getUser() async {
    final response = await rootBundle.loadString('assets/database/user.json');
    final user = UserModel.fromJson(response);
    return user;
  }

  Future<List<QuizModel>> getQuizzes(Level currentFilter) async {
    final response =
        await rootBundle.loadString('assets/database/quizzes.json');
    final list = jsonDecode(response) as List;
    var quizzes = list.map((e) => QuizModel.fromMap(e));
    if (currentFilter != Level.all) {
      quizzes = quizzes.where((i) => i.level == currentFilter);
    }
    return quizzes.toList();
  }
}
