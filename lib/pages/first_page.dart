import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/cubit/counter_cubit.dart';

class FirstPage extends StatelessWidget {
  final Duration? duration;
  const FirstPage({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (_, state) => Column(
            children: [
              Text('counter value: $state'),
              _increaseButton(context),
              _decreaseButton(context),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _increaseButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<CounterCubit>(context).increase();
      },
      child: const Text('Increase counter'),
    );
  }

  Widget _decreaseButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<CounterCubit>(context).decrease();
      },
      child: const Text('Decrease counter'),
    );
  }
}
