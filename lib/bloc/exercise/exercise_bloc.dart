

import 'package:beyourpt/bloc/exercise/exercise_event.dart';
import 'package:beyourpt/bloc/exercise/exercise_state.dart';
import 'package:beyourpt/modals/exercise_modal.dart';
import 'package:beyourpt/services/exercises_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState>{

  final ExerciseRepository? exerciseRepository;

  ExerciseBloc({this.exerciseRepository}) : super (const ExerciseInitial()){
    on<GetExerciseList>((event, emit) async {
      try{
        emit(const ExerciseLoading());
        final List<Exercise> exerciseList = await exerciseRepository?.getExercises();
        print(exerciseList.length);
        emit(ExerciseLoaded(exerciseList: exerciseList));
        }
        on NetworkError {
          emit(const ExerciseError(error: 'Data fetching failed '));
        }
        catch (e){
        emit(ExerciseError(error: e.toString()));
        }
    });
  }
}
