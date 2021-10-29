import 'package:fahrenheit/model/User.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocState {
  User user = new User();
}

class BlocCubit extends Cubit<BlocState> {
  BlocCubit() : super(BlocState());

  void increment() => emit(state);
  void decrement() => emit(state);

  void saveSession(User user) {
    state.user = user;
    emit(state);
  }
}
