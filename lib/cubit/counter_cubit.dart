import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  increase() => emit(state + 1);

  decrease() => emit(state - 1);
}
