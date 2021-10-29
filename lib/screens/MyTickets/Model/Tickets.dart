import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';

class Ticket {
  String title, location, image, userName, ticketNumber;
  DateTime date;
  int ticketId, eventId, eventRateId;
  fromJson(json) {
    this.ticketNumber = "";
    this.userName = json['user_first_name'] + " " + json['user_last_name'];
    this.title = json['event_title'];
    this.location = json['location'];
    this.image = HTTP().getImageBase() + json['event_image'];
    this.date = DateTime.parse(json['start_date']);
    this.ticketId = json['id'];
    this.eventId = json['event_id'];
    this.eventRateId = json['event_rate_id'];
  }
}

class Tickets {
  List<Ticket> tickets = [];
  Future<Tickets> fetchTickets(int id) async {
    Response response = await HTTP().get(path: "user-ticket/$id/");
    if (response.statusCode == 200) {
      var data = response.data;
      this.tickets = [];
      data.forEach((json) {
        Ticket ticket = Ticket();
        ticket.fromJson(json);
        tickets.add(ticket);
      });
    }
    return this;
  }
}
