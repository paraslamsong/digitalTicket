import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<bool> {
  SessionCubit() : super(false);

  void loggedIn() => emit(true);
  void loggOut() => emit(false);
}
