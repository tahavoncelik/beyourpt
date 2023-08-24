
import 'package:beyourpt/services/exercises_service.dart';


class ExerciseRepository{

  final ExerciseService _exerciseService = ExerciseService();

  Future getExercises(){
    return _exerciseService.getExercises();
  }
}

class NetworkError extends Error{}