import 'package:flutter/material.dart';

class PeopleSelectionDialog extends StatefulWidget {
  final Function(int) onPeopleChange;
  final int adults;

  const PeopleSelectionDialog({Key key, this.onPeopleChange, this.adults})
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
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Number of Ticket",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
            )
          ],
        ),
      ),
    );
  }
}
