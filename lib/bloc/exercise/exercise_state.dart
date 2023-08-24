
import 'package:beyourpt/modals/exercise_modal.dart';
import 'package:equatable/equatable.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState{
  const ExerciseInitial();
}

class ExerciseLoading extends ExerciseState{
  const ExerciseLoading();
}

class ExerciseLoaded extends ExerciseState{
  final List<Exercise> exerciseList;
  const ExerciseLoaded({required this.exerciseList});

  @override
  List<Object> get props => [exerciseList];
}

class ExerciseError extends ExerciseState{
 final String error;
 const ExerciseError({required this.error});

 @override
  List<Object> get props => [error];
}