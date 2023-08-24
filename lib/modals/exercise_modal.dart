import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String? name;
  final String? type;
  final String? muscle;
  final String? equipment;
  final String? difficulty;
  final String? instructions;

  const Exercise(
      this.name,
      this.type,
      this.muscle,
      this.equipment,
      this.difficulty,
      this.instructions
      );

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      json['name'],
      json["type"],
      json["muscle"],
      json["equipment"],
      json["difficulty"],
      json["instructions"]
    );}

  factory Exercise.fromDao(Map<String, dynamic> json) {
    return Exercise(
      json['name'],
      json["type"],
      json["muscle"],
      json["equipment"],
      json["difficulty"],
      json["instructions"]
    );
  }

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "type": type,
      "muscle": muscle,
      "equipment": equipment,
      "difficulty": difficulty,
      "instructions": instructions
    };
  }

  @override
  List<Object?> get props => [
    name,
    type,
    muscle,
    equipment,
    difficulty,
    instructions,
  ];
}