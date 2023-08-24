import 'package:beyourpt/modals/exercise_modal.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'selected_modal.g.dart';

@HiveType(typeId: 1)
class Selected extends Equatable {
  @HiveField(0)
  final Exercise? exercise;
  @HiveField(1)
  final int? set;
  @HiveField(2)
  final int? rep;

  const Selected(
      this.exercise,
      this.set,
      this.rep,
      );

  factory Selected.fromJson(Map<String, dynamic> json) {
    return Selected(
      json['exercise'],
      json["set"],
      json["rep"],
    );}

  factory Selected.fromDao(Map<String, dynamic> json) {
    return Selected(
        json['exercise'],
        json["set"],
        json["rep"],
    );
  }

  Map<String, Object?> toJson() {
    return {
      "exercise": exercise,
      "set": set,
      "rep": rep,
    };
  }

  @override
  List<Object?> get props => [
    exercise,
    set,
    rep,
  ];
}