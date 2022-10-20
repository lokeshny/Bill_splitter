import 'package:flutter/material.dart';

import 'hexacolor.dart';

class BillSpliter extends StatefulWidget {
  const BillSpliter({Key? key}) : super(key: key);

  @override
  State<BillSpliter> createState() => _BillSpliterState();
}

class _BillSpliterState extends State<BillSpliter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 160,
              height: 130,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total per person",
                    style: TextStyle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "\$ ${calculateTotalPerson(_billAmount, _personCounter, _tipPercentage)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _purple,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.greenAccent.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        prefixText: "Bill amount ",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                          )),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {}
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.2)),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                fontSize: 17.0,
                                fontStyle: FontStyle.normal,
                                color: _purple,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.2)),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),

                          //tip
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "\$ ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}",
                          style: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  //slider
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                          color: _purple,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          //divisions:  10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _tipPercentage = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerson(double billAmount, int splitBy, int tipPercentage) {
    double totalPerPerson =
        (calculateTotalTip(_billAmount, splitBy, tipPercentage) + _billAmount) /
            splitBy;
    String total1 = totalPerPerson.toStringAsPrecision(5);
    double totalPerPerson2 = double.parse(total1);

    return totalPerPerson2;
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;

    if (billAmount < 0 ||
        _billAmount.toString().isEmpty ||
        _billAmount == null) {
    } else {
      totalTip = (billAmount * _tipPercentage) / 100;
    }

    return totalTip;
  }
}