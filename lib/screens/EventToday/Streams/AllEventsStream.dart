import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'dart:async';

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
    subs = _eventStream.listen((AllEventsListener event) {
      _stateSink.add(state);
      switch (event.action) {
        case EventsActions.loadmore:
          if (state.hasNext) {
            state.isLoading = true;
            state.fetchAllEvent();
          }
          break;
        case EventsActions.refresh:
          state.reload();
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
  AllEventsListener(this.action);
}
