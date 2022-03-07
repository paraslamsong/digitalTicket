import 'package:fahrenheit/screens/EventDetail/Model/EventDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionWidget extends StatelessWidget {
  final List<Package> packages;
  final Package selected;
  final Function(Package) onSelect;

  const DateSelectionWidget({
    Key key,
    this.packages,
    this.selected,
    this.onSelect,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Date",
          style: TextStyle(
            fontFamily: "SF Pro",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 18),
        Container(
          height: 110,
          child: ListView.separated(
            itemCount: this.packages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _dateBox(context, package: this.packages[index]),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 10);
            },
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }

  Widget _dateBox(BuildContext context, {Package package}) {
    bool isSelected = package.id == selected.id;
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color(0xff1c1c1c),
      ),
      child: Stack(
        children: [
          Container(
            width: 160,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: 160,
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.red
                            : Colors.white.withOpacity(0.44),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  DateFormat("EEE").format(package.startDate) +
                      " - " +
                      DateFormat("EEE").format(package.endDate),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  DateFormat("MMMM dd").format(package.startDate) +
                      " - " +
                      DateFormat("MMMM dd").format(package.endDate),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  DateFormat("hh:mmaa").format(package.startDate) +
                      " - " +
                      DateFormat("hh:mmaa").format(package.endDate),
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                this.onSelect(package);
              },
              child: Container()),
        ],
      ),
    );
  }
}
