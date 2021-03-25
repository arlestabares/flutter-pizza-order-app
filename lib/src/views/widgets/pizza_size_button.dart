import 'package:flutter/material.dart';

class PizzaSizeButton extends StatelessWidget {
  final bool selected;
  final String text;
  final VoidCallback onTap;

  const PizzaSizeButton({
    Key key,
    @required this.selected,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: selected
                ? [
                    BoxShadow(
                      spreadRadius: 3.0,
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              text,
              style:
                  TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
    );
  }
}