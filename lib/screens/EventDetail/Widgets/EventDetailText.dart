import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailDescription extends StatefulWidget {
  String detail;
  EventDetailDescription({Key key, this.detail}) : super(key: key);
  @override
  State<EventDetailDescription> createState() => EventDetailDescriptionState();
}

class EventDetailDescriptionState extends State<EventDetailDescription> {
  bool isShown = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: isShown
          ? ListView(
              children: [
                Text(
                  widget.detail +
                      " kdlsjafo dfsalkfahsdoif fdsklfhjsaodfjos fdsjafnksanb fdsa fsdafsa ",
                  style: GoogleFonts.openSans(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            )
          : Text(
              widget.detail,
              maxLines: 7,
              style: GoogleFonts.openSans(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
    );
  }
}
