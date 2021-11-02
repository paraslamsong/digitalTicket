import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllEventsCubit extends Cubit<Events> {
  AllEventsCubit() : super(new Events());

  Future<void> reload() async {
    state.fetchAllEvent();
    emit(state);
  }

  void loadMore() {
    state.fetchAllEvent();
    emit(state);
  }
}
