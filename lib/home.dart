import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercengtage = 0;
  int _PersonCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tip Calculator"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(12.0),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.yellow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Total Per Person", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("\$ ${calculateTotalPerPerson(_billAmount, _PersonCounter, _tipPercengtage)}", style: const TextStyle(fontSize: 34.0, fontWeight:FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        prefixText: "Bill Amount ",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Split",
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_PersonCounter > 1) {
                                      _PersonCounter--;
                                    } else {
                                      //do nothing
                                    }
                                  });
                                },
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.yellow,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "-",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                )),
                            Text(
                              "$_PersonCounter",
                              style: const TextStyle(fontSize: 17.0),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _PersonCounter++;
                                  });
                                },
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.yellow,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "+",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Tip",
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          "\$ ${calculateTotalTip(_billAmount, _PersonCounter, _tipPercengtage).toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercengtage%",
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.yellow,
                          inactiveColor: Colors.orange.shade100,
                          value: _tipPercengtage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercengtage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

calculateTotalPerPerson(double BillAmount, int splitby, int tipPercentage){
  var totalPerPerson = (calculateTotalTip(BillAmount, splitby, tipPercentage) + BillAmount)/splitby;
  return totalPerPerson.toStringAsFixed(2);
}

calculateTotalTip(double BillAmount, int splitby, int tipPercentage){
double TotalTip = 0.0;
  if(BillAmount<0 || BillAmount.toString().isEmpty || BillAmount == null ){

  }else{
    TotalTip = (BillAmount * tipPercentage)/100;
  }
  return TotalTip;
}
