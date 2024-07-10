import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/counter_cubit.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: BlocBuilder<CounterCubit, int>(
          builder: (_, state) => Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("counter value: $state"),
              _increaseButton(context),
              _decreaseButton(context),
              TextButton(
                onPressed: () => context.pushNamed("first-page"),
                child: const Text("first Page"),
              )
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
