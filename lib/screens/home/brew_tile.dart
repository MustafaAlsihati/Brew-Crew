import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/widgets/brewtile_dialog.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  // Variables:
  final Brew brew;

  // Constructor:
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              '${brew.name[0]}${brew.name[1]}',
              style: TextStyle(color: Colors.white),
            ),
            radius: 30.0,
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[
                brew.strength], // Color is based on strength of the user brew.
          ),
          title: Text(brew.name),
          subtitle: Text('Sugar(s) intakes: ${brew.sugars}'),
          onTap: () => showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return TileDialog(brew);
              }),
        ),
      ),
    );
  }
}
