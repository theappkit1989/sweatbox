import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomApplePayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.apple, color: Colors.black, size: 32.0), // Apple icon
          SizedBox(width: 8.0), // Space between icon and text
          Text(
            'Pay with ApplePay',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}