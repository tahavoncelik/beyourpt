import 'dart:convert';
import 'package:beyourpt/modals/exercise_modal.dart';
import 'package:http/http.dart' as http;

class ExerciseService {
  Future<List<Exercise>> getExercises() async {
    print('a');
    var response = await http.get(
        Uri.https(
            "exercises-by-api-ninjas.p.rapidapi.com/v1/exercises"),
        headers: {
          'X-Rapidapi-Key': '32eabdc0c9msh83814533a97c9a7p1e5133jsn3208147b1452',
          'X-Rapidapi-Host': 'exercises-by-api-ninjas.p.rapidapi.com',
        });
    if (response.statusCode == 200) {
      var body = response.body;
      print(body);
      try {
        final exerciseMaptoList = (jsonDecode(body)['data'] as List<dynamic>)
            .cast<Map<String, dynamic>>();
        final exercises = <Exercise>[];
        for (final eachExercise in exerciseMaptoList) {
          exercises.add(Exercise.fromJson(eachExercise));
        }
        print("1 ${exercises.length}");
        return exercises;
      } catch (e) {
        print(e.toString());
        throw Exception('Failed');
      }
    } else {
      throw Exception('Failed to load teams');
    }
  }
}
