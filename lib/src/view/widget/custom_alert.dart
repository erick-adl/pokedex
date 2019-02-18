import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String text;
  final String opcao1;
  final Function function1;
  final String opcao2;
  final Function function2;

  CustomAlert(BuildContext context, this.text, {this.opcao1, this.function1,
      this.opcao2, this.function2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.text, style: Theme.of(context).textTheme.body2),
      actions: <Widget>[
        RaisedButton(
            child: Text(
              this.opcao1,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: this.function1),
        this.opcao2 != null
            ? RaisedButton(
                child: Text(
                  this.opcao2,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: this.function2)
            : Container()
      ],
    );
  }
}
