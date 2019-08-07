import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {

  final Widget child;
  final VoidCallback onPressed;

  ListItemCard({this.child,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: child,
        ),
      ),
    );
  }
}
