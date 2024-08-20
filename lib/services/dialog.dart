import 'package:flutter/material.dart';

class DialogHandler {

  void showOkDialog(BuildContext context, String title, String msg, VoidCallback onPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: onPressed,
                child: const Text("Ok"),
              )
            ],
          );
        }
    );
  }

  void showYesNoDialog(BuildContext context, String title, String msg, VoidCallback onPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: (){Navigator.of(context).pop();},
                child: const Text("No"),
              ),
              TextButton(
                onPressed: onPressed,
                child: const Text("Yes"),
              ),
            ],
          );
        }
    );
  }

  // Redo later on
  void loadingCircle(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
        }
    );
  }
}