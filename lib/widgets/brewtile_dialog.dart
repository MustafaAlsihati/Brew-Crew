import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class TileDialog extends StatelessWidget {
  final Brew brew;
  TileDialog(this.brew);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
            color: Colors.brown[50],
            borderRadius: new BorderRadius.circular(10.0)),
        width: 300.0,
        height: 200.0,
        child: Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.brown),
              ),
              SizedBox(height: 10),
              Text(
                "Loading",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
