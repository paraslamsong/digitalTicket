import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

enum PaymentType { Khalti }

class TicketModel {
  String fullName, email, phone;
  PaymentType paymentType;
  String transactionId;
  saveData({String name, email, phone}) {
    this.fullName = name;
    this.email = email;
    this.phone = phone;
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

  bookTicket() {}
}
