import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ContactButton extends StatefulWidget {
  bool call = true;
  ContactButton({Key? key, required this.call}) : super(key: key);

  @override
  _ContactButtonState createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 175,
        height: 35.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF12A1FF),
              Color(0xFF2980B9),
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 35.0,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: widget.call
                  ? Image.asset(
                      'assets/icons/call.png',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/icons/message.png',
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 50),
              child: widget.call
                  ? Text(
                      "Call",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      "Message",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
            ),
          ],
        ));
  }
}
