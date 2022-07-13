import 'package:clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final textEditingController = TextEditingController();
  late String inputString;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onSubmitted: (_) {
            dispatchConcrete();
          },
          controller: textEditingController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputString = value;
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: const Text('Search'),
                onPressed: () {
                  dispatchConcrete();
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                child: const Text('Get random trivia'),
                onPressed: () {
                  dispatchRandom();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    textEditingController.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaForConcreteNumber(inputString),
    );
  }

  void dispatchRandom() {
    textEditingController.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaForRandomNumber(),
    );
  }
}
