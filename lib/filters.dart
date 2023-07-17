import 'package:flutter/material.dart';
//import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
class filters extends StatefulWidget {
  const filters({Key? key}) : super(key: key);

  @override
  State<filters> createState() => _filtersState();
}

class _filtersState extends State<filters> {
  double _value = 40.0;
  List<String> _myList = [];
  List<String> _myListCustom = [];
  double values=5;
  SfRangeValues _values = SfRangeValues(40.0, 80.0);
  @override
  Widget build(BuildContext context) {
    var targetPriceController;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 25,),
                ),
              ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Filters',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),),
                ),
              ),
              SizedBox(height: 10,),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Filter by price',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),),
                ),
              ),
              SfRangeSlider(
                min: 0.0,
                max: 1000.0,
                values: _values,
                interval: 20,
                //showTicks: true,
                //showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (SfRangeValues values){
                  setState(() {
                    _values = values;
                  });
                },
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(alignment:Alignment.topLeft,
                        child: Text(_values.start.toStringAsFixed(1),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),)),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/1.4,),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(alignment:Alignment.topRight,
                        child: Text(_values.end.toStringAsFixed(1),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),)),
                  ),

                ],
              ),

              SizedBox(height: 30,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Brand',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: FlutterInputChips(
                  initialValue: const [],
                  maxChips: 5,
                  onChanged: (v) {
                    setState(() {
                      values = v as double;
                    });
                  },
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter brand name",
                  ),
                  chipTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  chipSpacing: 8,
                  chipDeleteIconColor: Colors.white,
                  chipBackgroundColor: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: FlutterInputChips(
                  initialValue: const [],
                  maxChips: 5,
                  onChanged: (v) {
                    setState(() {
                      values = v as double;
                    });
                  },
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Categories",
                  ),
                  chipTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  chipSpacing: 8,
                  chipDeleteIconColor: Colors.white,
                  chipBackgroundColor: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Colors',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),),
                ),
              ),
              //SizedBox(height: 10,),
              Container(
                // color:Colors.grey ,
                height: MediaQuery.of(context).size.height/9.9,
                width: MediaQuery.of(context).size.width/1.0,
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        //margin: EdgeInsets.all(100.0),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        //margin: EdgeInsets.all(100.0),
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        //margin: EdgeInsets.all(100.0),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        //margin: EdgeInsets.all(100.0),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        //margin: EdgeInsets.all(100.0),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const forpermanentjob()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 140, vertical: 12),
                    textStyle:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w400,)),
                child: const Text('APPLY'),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
