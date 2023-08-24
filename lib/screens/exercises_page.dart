import 'package:beyourpt/bloc/exercise/exercise_bloc.dart';
import 'package:beyourpt/bloc/exercise/exercise_event.dart';
import 'package:beyourpt/bloc/exercise/exercise_state.dart';
import 'package:beyourpt/bloc/programs/programs_bloc.dart';
import 'package:beyourpt/services/databases/programs_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

final client = Client();
final programBloc = ProgramsBloc(ProgramsDatabase());
final boxNameBloc = BoxNamesBloc(ProgramsDatabase());
final exerciseBloc = ExerciseBloc();

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExerciseBloc>(
      create: (context) => ExerciseBloc(),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            TitleText(),
            QuoteText(),
            AllExercises(),
          ],
        ),
      ),
    );
  }
}

// Be Your PT Text and Bottom Line
class TitleText extends StatefulWidget {
  const TitleText({super.key});

  @override
  State<TitleText> createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: const Text(
            "Be Your PT",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          indent: 110,
          endIndent: 110,
          color: Colors.black,
        )
      ],
    );
  }
}

// Arnold Quote
class QuoteText extends StatefulWidget {
  const QuoteText({super.key});

  @override
  State<QuoteText> createState() => _QuoteTextState();
}

class _QuoteTextState extends State<QuoteText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 170,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '"The meaning of life is not simply to exist, to survive, but to move ahead, to go up, to conquer."',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Arnold Schwarzenegger',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 110,
            endIndent: 110,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

// Exercises List + Filter
class AllExercises extends StatefulWidget {
  const AllExercises({super.key});

  @override
  State<AllExercises> createState() => _AllExercisesState();
}

class _AllExercisesState extends State<AllExercises> {
  bool? _isChecked = false;
  @override
  void initState() {
    context.read<ExerciseBloc>().add(GetExerciseList());
    exerciseBloc.add(GetExerciseList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
      if (state is ExerciseError) {
        return Center(child: Text(state.error));
      } else if (state is ExerciseInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ExerciseLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ExerciseLoaded) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EXERCISES',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    physics: const ScrollPhysics(),
                    itemCount: state.exerciseList.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<BoxNameState>(
                          stream: boxNameBloc.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print('Error : ${snapshot.error}');
                            }
                            final boxState = snapshot.data;
                            if (boxState == null) return const SizedBox();
                            final boxNames = boxState.boxNameList;
                            return GestureDetector(
                              onLongPress: () {
                                showModalBottomSheet(
                                    backgroundColor: const Color(0xFF333333),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    )),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Add Exercise',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              height: 20,
                                              thickness: 1,
                                              indent: 110,
                                              endIndent: 110,
                                              color: Colors.white,
                                            ),
                                            const Text(
                                              'Set & Rep',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Set',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  SizedBox(
                                                    height: 35,
                                                    width: 100,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  '3'),
                                                              labelStyle: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 0.5,
                                                              )),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                width: 0.5,
                                                              ))),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Rep',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  SizedBox(
                                                    height: 35,
                                                    width: 100,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  '12'),
                                                              labelStyle: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 0.5,
                                                              )),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                width: 0.5,
                                                              ))),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Text(
                                              'Choose Program',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 40,
                                                    width: 150,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              label: const Text(
                                                                  'New Program...'),
                                                              labelStyle: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 0.5,
                                                              )),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                width: 0.5,
                                                              ))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        side: const BorderSide(
                                                          width: 1,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      child: const Row(
                                                        children: [
                                                          Icon(Icons
                                                              .playlist_add_outlined),
                                                          Text(
                                                            'Create New',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                            ),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                ListView.builder(
                                                    itemCount: boxNames.length,
                                                    itemBuilder: (context, index) {
                                                  return CheckboxListTile(
                                                      title: Text(
                                                          boxNames[index]),
                                                      value: _isChecked,
                                                      checkColor: Colors.white,
                                                      activeColor:
                                                          Colors.orange,
                                                      fillColor: MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                                  .grey
                                                                  .shade600),
                                                      onChanged:
                                                          (bool? newValue) {
                                                        setState(() {
                                                          _isChecked = newValue;
                                                        });
                                                      });
                                                }),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () {},
                                                  minWidth: 100,
                                                  height: 50,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  splashColor: Colors.red[900],
                                                  color: Colors.red,
                                                  textColor: Colors.white,
                                                  child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons
                                                            .cancel_outlined),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text('Cancel'),
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                MaterialButton(
                                                  onPressed: () {},
                                                  minWidth: 100,
                                                  height: 50,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  splashColor: Colors.blue[900],
                                                  color: Colors.blue,
                                                  textColor: Colors.white,
                                                  child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.add),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text('Add Exercise'),
                                                      ]),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.black,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            child: Image.asset(
                                                'lib/Assets/incline.webp')),
                                      ),
                                      Text(
                                        state.exerciseList[index].name ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                state.exerciseList[index].muscle
                                                        ?.toUpperCase() ??
                                                    '',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12)),
                                            Text(
                                                state.exerciseList[index]
                                                        .difficulty ??
                                                    '',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
