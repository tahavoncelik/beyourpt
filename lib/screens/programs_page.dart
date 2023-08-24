import 'package:beyourpt/bloc/programs/programs_bloc.dart';
import 'package:beyourpt/screens/exercises_page.dart';
import 'package:flutter/material.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TitleText(),
          TitleQuote(),
          AllPrograms(),
        ],
      ),
    );
  }
}

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

class TitleQuote extends StatefulWidget {
  const TitleQuote({super.key});

  @override
  State<TitleQuote> createState() => _TitleQuoteState();
}

class _TitleQuoteState extends State<TitleQuote> {
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
              '“Small disciplines repeated with consistency every day lead to great achievements gained slowly over time.”',
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
            'John C. Maxwell',
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

class AllPrograms extends StatefulWidget {
  const AllPrograms({super.key});

  @override
  State<AllPrograms> createState() => _AllProgramsState();
}

class _AllProgramsState extends State<AllPrograms> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BoxNameState>(
        stream: boxNameBloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error : ${snapshot.error}');
          }
          final boxState = snapshot.data;
          if (boxState == null) return const SizedBox();
          final boxNames = boxState.boxNameList;
          return StreamBuilder<ProgramState>(
            stream: programBloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Error : ${snapshot.error}');
              }
              final programState = snapshot.data;
              if (boxState == null) return const SizedBox();
              final programs = programState?.currentProgramList;
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  children: [
                    const Text(
                      'PROGRAMS',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: boxNames.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {},
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      boxNames[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                style: ListTileStyle.drawer,
                                focusColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
            }
          );
        });
  }
}
