import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllEventsCubit extends Cubit<Events> {
  AllEventsCubit() : super(new Events());

  Future<void> reload() async {
    emit(state);
  }

  Future<void> loadMore(BuildContext context) async {
    // await state.fetchAllEvent();
    emit(state);
  }
}
