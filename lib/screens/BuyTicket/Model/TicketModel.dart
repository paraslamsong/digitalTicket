import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

enum PaymentType { Khalti }

String getPaymentKey(PaymentType type) {
  if (type == PaymentType.Khalti) return "khalti";
  return "";
}

class TicketModel {
  String fullName, email, phone;
  PaymentType paymentType;
  String transactionId;
  saveData({String name, email, phone, paymentType}) {
    this.fullName = name;
    this.email = email;
    this.phone = phone;
    this.paymentType = paymentType;
  }

  payNow(
      {BuildContext context, PaymentType paymentType, Function() onSuccess}) {
    this.paymentType = paymentType;

    if (paymentType == PaymentType.Khalti) {
      final config = PaymentConfig(
        amount: 10000,
        productIdentity: 'dell-g5-g5510-2021',
        productName: 'Dell G5 G5510 2021',
        productUrl: 'https://www.khalti.com/#/bazaar',
        additionalData: {
          'vendor': 'Khalti Bazaar',
        },
      );
      KhaltiScope.of(context).pay(
        config: config,
        onSuccess: (PaymentSuccessModel model) {
          print(model.idx);
          print(model.token);
          this.transactionId = model.token;
          onSuccess();
        },
        onFailure: (PaymentFailureModel failure) {
          final snackBar = SnackBar(content: Text(failure.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onCancel: () {
          final snackBar =
              SnackBar(content: Text("Payment cancelled by User!"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    }
  }

  bookTicket(BuildContext context, int ticketId) async {
    Map<String, dynamic> body = {
      "email": email,
      "firstName": fullName,
      "phone": phone,
      "payment_method": getPaymentKey(paymentType),
      "eventRate": ticketId
    };
    print(body);
    Response response = await HTTP().post(
        context: context, path: "create-ticket/", body: body, useToken: true);

    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 209) {
      Fluttertoast.showToast(msg: "Event ticket is booked");
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyTicket()));
    } else {
      Fluttertoast.showToast(msg: "Sorry ticket is not booked");
    }
  }
}
