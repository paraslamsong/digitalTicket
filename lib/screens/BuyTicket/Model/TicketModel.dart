import 'package:dio/dio.dart';
import 'package:fahrenheit/api/API.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/BuyTicket/Popups/PromoCodeDialog.dart';
import 'package:fahrenheit/screens/EventDetail/Model/EventDetail.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:fahrenheit/screens/utils/loadingOverlay.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/src/provider.dart';

enum PaymentType { Khalti }

String getPaymentKey(PaymentType type) {
  if (type == PaymentType.Khalti) return "khalti";
  return "";
}

class TicketModel {
  String fullName, email, phone;
  PaymentType paymentType;
  String transactionId;
  Rate rate;
  String organizer;
  int peopleCounts;
  PromocodeModel promocode = PromocodeModel.fromJson({}, "");
  saveData(
      {String name,
      email,
      phone,
      paymentType,
      rate,
      organizer,
      counts,
      PromocodeModel code}) {
    this.fullName = name;
    this.email = email;
    this.phone = phone;
    this.paymentType = paymentType;
    this.rate = rate;
    this.organizer = organizer;
    this.peopleCounts = counts;
    promocode = code;
  }

  payNow({
    BuildContext context,
    PaymentType paymentType,
    Function(dynamic, dynamic, dynamic, dynamic) onSuccess,
    String productName,
    String ticketNumber,
    var additionalData,
  }) {
    this.paymentType = paymentType;

    if (paymentType == PaymentType.Khalti) {
      final config = PaymentConfig(
        amount: ((peopleCounts * rate.rate - promocode.off) * 100).toInt(),
        productIdentity: ticketNumber,
        productName: organizer + " - " + ticketNumber,
        productUrl: "http://www.meroticketapp.com/",
        additionalData: {
          "oragnizer": organizer,
          "ticketType": rate.name,
          "ticketId": rate.id.toString(),
          "ticketNumber": ticketNumber,
          "paiedDateTime": DateTime.now().toString(),
        },
      );
      KhaltiScope.of(context).pay(
        config: config,
        onSuccess: (PaymentSuccessModel model) {
          onSuccess(model.idx, model.token, model.amount, ticketNumber);
        },
        onFailure: (PaymentFailureModel failure) {
          OverlayLoader(context).hide();
          final snackBar = SnackBar(content: Text(failure.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onCancel: () {
          OverlayLoader(context).hide();
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
      "eventRate": ticketId,
      "ticket_count": peopleCounts,
      "code": promocode.promo,
    };

    OverlayLoader(context).show();
    Response response = await HTTP().post(
        context: context,
        path: "create-ticket/",
        body: body,
        useToken: context.read<SessionCubit>().state);

    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 209) {
      User().setTokens(
          access: response.data['access'], refresh: response.data['refresh']);
      context.read<SessionCubit>().loggedIn();
      if ((peopleCounts * rate.rate * 100).toInt() == 0) {
        OverlayLoader(context).hide();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyTicket()));
      } else {
        this.payNow(
          context: context,
          paymentType: this.paymentType,
          ticketNumber: response.data['ticket_number'],
          onSuccess: (idx, token, amount, ticketNumber) async {
            Response response = await HTTP()
                .post(context: context, path: "verify-khalti/", body: {
              "idx": idx,
              "token": token,
              "amount": amount,
              "ticketNumber": ticketNumber,
            });
            print(response.statusCode);
            if (response.statusCode == 200) {
              OverlayLoader(context).hide();
              Fluttertoast.showToast(msg: "Event ticket is booked");
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyTicket()));
            } else {
              OverlayLoader(context).hide();
              Fluttertoast.showToast(msg: response.data['message']);
            }
          },
        );
      }
    } else {
      OverlayLoader(context).hide();
      Fluttertoast.showToast(msg: "Sorry ticket is not booked");
    }
  }
}
