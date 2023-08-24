import 'package:beyourpt/modals/selected_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProgramsDatabase {
  // Create New Program List
  Future<void> openNewBox({required String boxName}) async {
    if (boxName.isNotEmpty) {
      bool exists = await Hive.boxExists(boxName);
      if (exists = false) {
        await Hive.openBox<Selected>(boxName);
      }
    } else {
      print('Something went wrong in opening');
    }
  }

  // Add Exercise to Current Program
  Future<void> addToProgram(
      {required Selected selected, required String boxName}) async {
    if (boxName.isNotEmpty) {
      var currentBox = Hive.box<Selected>(boxName);
      await currentBox.add(selected);
      await currentBox.close();
    } else {
      print('Something went wrong in adding');
    }
  }

  // Delete Exercise From Current Program
  Future<void> removeFromProgram({required Selected selected, required String boxName}) async {
    if (boxName.isNotEmpty) {
      var currentBox = Hive.box<Selected>(boxName);
      final index =
          currentBox.values.toList().indexWhere((item) => item == selected);
      if (index != -1) {
        await currentBox.deleteAt(index);
        await currentBox.close();
      }
    } else {
      print("Something went wrong in deleting");
    }
  }

  // Delete Current Program From Disk
  Future<void> deleteProgram({required String boxName}) async {
    if (boxName.isNotEmpty) {
      await Hive.deleteBoxFromDisk(boxName);
    } else {
      print("Something went wrong in program deleting");
    }
  }

  // Get Current Program Values
  Future<List<Selected>> getProgramValues({required String boxName}) async {
    var currentBox = Hive.box<Selected>(boxName);
    final program = currentBox.values.toList();
    return program;
  }

// Save Program Names
Future<void> saveBoxNames({required String boxName}) async {
  var boxes = Hive.box<String>('allBoxes');
  final allBoxes = boxes.values.toList();
  if (boxName.isNotEmpty) {
    if (!allBoxes.contains(boxName)) {
      await boxes.add(boxName);
    }
  } else {
    print('Something went wrong in saving');
  }
}

// Get Program Names
Future<List<String>> getBoxNames() async {
  var boxes = Hive.box<String>('allBoxes');
  final allBoxes = boxes.values.toList();
  return allBoxes;
}
}