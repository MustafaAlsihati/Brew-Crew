import 'package:brew_crew/locale/app_localization.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class TileDialog extends StatelessWidget {
  final Brew brew;
  TileDialog(this.brew);

  @override
  Widget build(BuildContext context) {
    String coffeeStrength = AppLocalizations.of(context).text('coffeeStrength');
    String sugarIntake = AppLocalizations.of(context).text('sugarIntake');
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
            color: Colors.brown[50],
            borderRadius: new BorderRadius.circular(10.0)),
        width: 300.0,
        height: 220.0,
        child: Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                child: Text(
                  '${brew.name[0]}${brew.name[1]}',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                radius: 35.0,
                backgroundImage: AssetImage('assets/coffee_icon.png'),
                backgroundColor: Colors.brown[brew
                    .strength], // Color is based on strength of the user brew.
              ),
              SizedBox(height: 10),
              Text(
                brew.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[brew.strength],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "$coffeeStrength: ${brew.strength}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 10),
              Text(
                '$sugarIntake: ${brew.sugars}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[700], fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
