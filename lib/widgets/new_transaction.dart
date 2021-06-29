import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addtx;

  NewTransactions(this.addtx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime selectedDate;

  void _submit() {
    final enteredtitle = titlecontroller.text;
    final enteredamount = double.parse(amountcontroller.text);
    if (enteredtitle.isEmpty || enteredamount <= 0 || selectedDate==null) {
      return;
    }
    widget.addtx(
              enteredtitle,
              enteredamount,
              selectedDate,
              );
    Navigator.of(context)
        .pop(); //Closes the Modal bottom sheet as soon as we enter the data
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate){
         
         
          if(pickedDate==null){
            return;
          }
          else{
            setState(() {
              
           
            selectedDate=pickedDate;
 });
          }
          });  //then gives us a function to run once the user picks a date
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
          elevation: 5,
          child: Container(
            
            padding: EdgeInsets.only(
              top:10,
              left:10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  //onChanged: (value){
                  //  titleoftx=value;
                  // }, //this was for the less efficient way to store the user input
                  controller: titlecontroller,
                  onSubmitted: (_) => _submit(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  //onChanged: (val){
                  //  amountoftx=val;
                  //},

                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submit(),
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: [

                      Expanded(child: Text(selectedDate==null?'No! Date choosen': 'Picked Date: ${DateFormat.yMd().format(selectedDate)}')),
                      FlatButton(
                        textColor: Colors.purple,
                        child: Text(
                          'Choose date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: _presentDatePicker,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    child: Text('Add Transaction'),
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
