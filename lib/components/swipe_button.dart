// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SwipeButton extends StatefulWidget {
  final String buttonText;
  final Function() onSubmitted;

  const SwipeButton({super.key, required this.buttonText, required this.onSubmitted});

  @override
  _SwipeButtonState createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  bool _isSwiped = false;
  double _dragStart = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _dragStart = details.localPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        if (!_isSwiped && details.localPosition.dx - _dragStart > 100) {
          setState(() {
            _isSwiped = true;
          });
          widget.onSubmitted();
        }
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _isSwiped ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
