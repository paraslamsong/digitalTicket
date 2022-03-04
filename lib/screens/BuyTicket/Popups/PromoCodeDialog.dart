import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PromocodeModel {
  int id;
  String title, event, type, promo;
  double value = 0;

  double off = 0, grandtotal = 0;
  PromocodeModel.fromJson(json, code) {
    this.id = json['id'] ?? 0;
    this.title = json['title'] ?? "";
    this.event = json['event'] ?? "";
    this.type = json['discount_type'] ?? "";
    this.promo = code ?? "";
    this.value = json['value'] ?? 0.0;
  }
  calculate(double total) {
    if (type == "%") {
      off = (value / 100 * total);
    } else {
      off = value;
    }
    grandtotal = total - off;
    grandtotal = max(grandtotal, 0);
  }
}

class PromocodeBox extends StatefulWidget {
  final Function(PromocodeModel) onCodeApply;
  final int id;

  const PromocodeBox({Key key, this.onCodeApply, this.id}) : super(key: key);
  @override
  State<PromocodeBox> createState() => _PromocodeBoxState();
}

class _PromocodeBoxState extends State<PromocodeBox> {
  int currentPage = 0;
  PromocodeModel _promocodeModel = PromocodeModel.fromJson({}, "");
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 3,
        color: Color(0xff1C1C1E),
        borderRadius: BorderRadius.circular(10),
        child: [
          _AddPromocode(),
          _Promocodebox(),
          _appliedCode(),
        ][currentPage],
      ),
    );
  }

  Widget _AddPromocode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        children: [
          Text(
            "Have a Promo Code ?",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            onPressed: () {
              setState(() {
                currentPage = 1;
              });
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _Promocodebox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              controller: _controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white12),
                ),
                hintText: "Enter Promo Code",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white60,
                ),
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            onPressed: () {
              applyCode(id: widget.id, code: _controller.text);
              setState(() {
                currentPage = 1;
              });
            },
            child: Text(
              "Apply",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appliedCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        children: [
          Text(
            _promocodeModel.type == "%"
                ? (_promocodeModel.value.toString() +
                    "% OFF " +
                    "\"" +
                    _promocodeModel.promo +
                    "\"")
                : ("रू " +
                    _promocodeModel.value.toString() +
                    " OFF " +
                    "\"" +
                    _promocodeModel.promo +
                    "\""),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            onPressed: null,
            child: Text(
              "Added",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  applyCode({int id, String code}) async {
    Response response = await HTTP().post(
      path: "apply-promotion/",
      body: {"promocode": code, "event": id},
      useToken: true,
    );
    if (response.statusCode == 200) {
      var data = response.data['data'];
      _promocodeModel = PromocodeModel.fromJson(data, code);
      widget.onCodeApply(_promocodeModel);

      setState(() {
        currentPage = 2;
      });
    } else {
      Fluttertoast.showToast(msg: response.data['message']);
    }
  }
}
