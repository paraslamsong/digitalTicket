import 'package:fahrenheit/screens/EventDetail/Model/EventDetail.dart';
import 'package:flutter/material.dart';

class PeopleSelectionDialog extends StatefulWidget {
  final Function(int) onPeopleChange;
  final List<TicketInclusion> inclusions;
  final int adults;

  const PeopleSelectionDialog(
      {Key key, this.onPeopleChange, this.adults, this.inclusions})
      : super(key: key);
  @override
  State<PeopleSelectionDialog> createState() => _PeopleSelectionDialogState();
}

class _PeopleSelectionDialogState extends State<PeopleSelectionDialog> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.adults.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Color(0xff1C1C1E),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Number of People(Tickets)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (int.parse(_controller.text) == 1) return;
                    _controller.text =
                        (int.parse(_controller.text) - 1).toString();
                    widget.onPeopleChange(int.parse(_controller.text));
                  },
                  icon: Text(
                    "-",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff3C3A3A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    // textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    onChanged: (value) =>
                        {widget.onPeopleChange(int.parse(value))},
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (int.parse(_controller.text) >= 15) return;
                    _controller.text =
                        (int.parse(_controller.text) + 1).toString();
                    widget.onPeopleChange(int.parse(_controller.text));
                  },
                  icon: Text(
                    "+",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Visibility(
              visible: widget.inclusions.length > 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Included",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.inclusions.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffEA2D31)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.inclusions[index].included,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
