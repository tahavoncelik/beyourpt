

import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable{
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class GetExerciseList extends ExerciseEvent{}