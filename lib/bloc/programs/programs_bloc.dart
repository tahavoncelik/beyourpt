import 'dart:async';

import 'package:beyourpt/modals/selected_modal.dart';
import 'package:beyourpt/services/databases/programs_database.dart';


// Programs BLOC for adding/deleting exercise
class ProgramsBloc {
  final ProgramsDatabase _programsDatabase;

  ProgramsBloc(this._programsDatabase) {
    _eventStreamController.stream.listen(_raProgram);
  }

  final StreamController<ProgramState> _programStreamController =
  StreamController.broadcast();
  StreamSink<ProgramState> get _stateSink => _programStreamController.sink;
  Stream<ProgramState> get stream =>
      _programStreamController.stream.asBroadcastStream();

  final StreamController<ProgramEvent> _eventStreamController = StreamController();

  // Exercise Add/Remove to/from Program
  Future<void> _raProgram(ProgramEvent event) async {
    if (event is AddProgramFetchedEvent) {
      await _programsDatabase.addToProgram(selected: event.selected, boxName: event.boxName);
      final favList = await _programsDatabase.getProgramValues(boxName: event.boxName);
      _stateSink.add(ProgramState(favList));
    }
    if (event is RemoveProgramFetchedEvent) {
      await _programsDatabase.removeFromProgram(selected: event.selected, boxName: event.boxName);
      final favList = await _programsDatabase.getProgramValues(boxName: event.boxName);
      _stateSink.add(ProgramState(favList));
    }
  }


  void addProgramFetchedEvent({required Selected selected, required String boxName}) {
    _eventStreamController.add(AddProgramFetchedEvent(selected, boxName));
  }

  void getCurrentProgram({required String boxName}) async {
    final favList = await _programsDatabase.getProgramValues(boxName: boxName);
    _stateSink.add(ProgramState(favList));
  }

  void removeProgramFetchedEvent({required Selected selected, required String boxName}) {
    _eventStreamController.add(RemoveProgramFetchedEvent(selected, boxName));
  }

  void dispose() {
    _programStreamController.close();
  }
}

class ProgramState {
  final List<Selected> currentProgramList;
  ProgramState(this.currentProgramList);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProgramState && other.currentProgramList == currentProgramList);
  }

  @override
  int get hashCode => currentProgramList.hashCode;
}

abstract class ProgramEvent {
  const ProgramEvent();
}

class ProgramFetchedEvent extends ProgramEvent {
  final Selected selected;
  final String boxName;
  const ProgramFetchedEvent(
      this.selected,
      this.boxName
      );

  // To support value equality
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProgramFetchedEvent && other.selected == selected);
  }

  @override
  int get hashCode => selected.hashCode;
}

class AddProgramFetchedEvent extends ProgramEvent {
  final Selected selected;
  final String boxName;

  const AddProgramFetchedEvent(
      this.selected,
      this.boxName
      );

  // To support value equality
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddProgramFetchedEvent && other.selected == selected);
  }

  @override
  int get hashCode => selected.hashCode;
}

class RemoveProgramFetchedEvent extends ProgramEvent {
  final Selected selected;
  final String boxName;

  const RemoveProgramFetchedEvent(
      this.selected,
      this.boxName
      );

  // To support value equality
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RemoveProgramFetchedEvent && other.selected == selected);
  }

  @override
  int get hashCode => selected.hashCode;
}


// Box BLOC for Deleting/Opening Program
class BoxNamesBloc {
  final ProgramsDatabase _programsDatabase;

  BoxNamesBloc(this._programsDatabase) {
    _eventStreamController.stream.listen(_daBox);
  }

  final StreamController<BoxNameState> _boxStreamController =
  StreamController.broadcast();
  StreamSink<BoxNameState> get _stateSink => _boxStreamController.sink;
  Stream<BoxNameState> get stream =>
      _boxStreamController.stream.asBroadcastStream();

  final StreamController<BoxNameEvent> _eventStreamController = StreamController();

  // Exercise Add/Remove to/from Program
  Future<void> _daBox(BoxNameEvent event) async {
    if (event is AddBoxFetchedEvent) {
      await _programsDatabase.openNewBox(boxName: event.boxName);
      final boxNameList = await _programsDatabase.getBoxNames();
      _stateSink.add(BoxNameState(boxNameList));
    }
    if (event is DeleteBoxFetchedEvent) {
      await _programsDatabase.deleteProgram(boxName: event.boxName);
      final boxNameList = await _programsDatabase.getBoxNames();
      _stateSink.add(BoxNameState(boxNameList));
    }
  }


  void addBoxFetchedEvent({required String boxName}) {
    _eventStreamController.add(AddBoxFetchedEvent(boxName));
  }

  void getCurrentProgram({required String boxName}) async {
    final boxNameList = await _programsDatabase.getBoxNames();
    _stateSink.add(BoxNameState(boxNameList));
  }

  void deleteBoxFetchedEvent({required String boxName}) {
    _eventStreamController.add(DeleteBoxFetchedEvent(boxName));
  }

  void dispose() {
    _boxStreamController.close();
  }
}

class BoxNameState {
  final List<String> boxNameList;
  BoxNameState(this.boxNameList);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BoxNameState && other.boxNameList == boxNameList);
  }

  @override
  int get hashCode => boxNameList.hashCode;
}

abstract class BoxNameEvent {
  const BoxNameEvent();
}

class BoxFetchedEvent extends BoxNameEvent {
  final String boxName;
  const BoxFetchedEvent(
      this.boxName
      );

  // To support value equality
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProgramFetchedEvent && other.boxName == boxName);
  }

  @override
  int get hashCode => boxName.hashCode;
}

class AddBoxFetchedEvent extends BoxNameEvent {
  final String boxName;

  const AddBoxFetchedEvent(
      this.boxName
      );

  // To support value equality
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddProgramFetchedEvent && other.boxName == boxName);
  }

  @override
  int get hashCode => boxName.hashCode;
}

class DeleteBoxFetchedEvent extends BoxNameEvent {
  final String boxName;

  const DeleteBoxFetchedEvent(
      this.boxName
      );

  // To support value equality
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeleteBoxFetchedEvent && other.boxName == boxName);
  }

  @override
  int get hashCode => boxName.hashCode;
}
