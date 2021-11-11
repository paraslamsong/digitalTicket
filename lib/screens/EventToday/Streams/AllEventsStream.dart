import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum EventsActions { loadmore, refresh }

class AllEventsModelBuilder {
  Events state = Events();
  // ignore: close_sinks
  final _stateStreamController = StreamController<Events>.broadcast();
  StreamSink<Events> get _stateSink => _stateStreamController.sink;
  Stream<Events> get stateStream => _stateStreamController.stream;

  // ignore: close_sinks
  final _eventStreamController =
      StreamController<AllEventsListener>.broadcast();
  StreamSink<AllEventsListener> get eventSink => _eventStreamController.sink;
  Stream<AllEventsListener> get _eventStream => _eventStreamController.stream;
  var subs;
  AllEventsModelBuilder() {
    subs = _eventStream.listen((AllEventsListener event) async {
      switch (event.action) {
        case EventsActions.loadmore:
          if (state.hasNext) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: "Loading more");
            await state.fetchAllEvent(event.context);
          }
          break;
        case EventsActions.refresh:
          state.events = [];
          state.page = 1;
          _stateSink.add(state);
          state.hasNext = true;
          await state.fetchAllEvent(event.context);
          break;
        default:
          break;
      }
      _stateSink.add(state);
    });
  }

  endStream() {
    subs.cancel();
  }
}

class AllEventsListener {
  EventsActions action;
  BuildContext context;
  AllEventsListener({this.action, this.context});
}
