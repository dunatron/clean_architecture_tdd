import 'package:clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_tdd/injectionContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // top half
              // crea a WIdget That listens to the Bloc
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Emtpy) {
                    return const MessageDisplay(message: "Start Searching");
                  } else if (state is Loading) {
                    return LoadingWidget();
                    // return const CircularProgressIndicator();
                  } else if (state is Loaded) {
                    return MessageDisplay(message: state.trivia.text);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              // bottom half
              const TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
