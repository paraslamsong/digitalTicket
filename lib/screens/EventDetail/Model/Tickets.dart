import 'dart:convert';

import 'package:fahrenheit/api/API.dart';
import 'package:fahrenheit/api/APIService.dart';
import 'package:http/http.dart';

class Ticket {
  int id;
  String title, rate, image;
  bool isTicket, isTable, isVIP;
  int chairCount, floor, tableNo, event;

  mapToObject(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.rate = json['rate'];
    this.image = json['image'];
    this.isTicket = json['is_ticket'];
    this.isTable = json['is_table'];
    this.isVIP = json['isVip'];
    this.chairCount = json['chair_count'];
    this.floor = json['floor'];
    this.tableNo = json['table_no'];
    this.event = json['event'];
  }
}

class Tickets {
  List<Ticket> tickets = [];
  mapToObject(List<dynamic> json) {
    json.forEach((element) {
      Ticket ticket = new Ticket();
      ticket.mapToObject(element);
      tickets.add(ticket);
    });
  }

  fetchTickets(int id) async {
    API api = new APIService();
    Response response =
        await api.getApi(endpoint: "api/event-rate/?event_id=$id");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      mapToObject(json);
    }
    return this;
  }
}
