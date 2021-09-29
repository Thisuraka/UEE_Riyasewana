import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_checkbox.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:riyasewana/styles.dart';

class VehicleFilter extends StatefulWidget {
  @override
  _VehicleFilterScreen createState() => _VehicleFilterScreen();
}

class _VehicleFilterScreen extends State<VehicleFilter> {
  final int _minPrice = 0;
  final int _maxPrice = 110;
  bool _selected = false;

  final SfRangeValues _prices = SfRangeValues(40.0, 90.0);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.only(top: 50),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/icons/pop-arrow.png',
                        height: 30,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        "Filter",
                        style: HeaderStyle,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 10),
                child: Text(
                  "Price range (Lakhs)",
                  style: HintStyle1,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SfRangeSelector(
                  min: _minPrice,
                  max: _maxPrice,
                  initialValues: _prices,
                  interval: 20,
                  activeColor: DefaultColor,
                  labelPlacement: LabelPlacement.onTicks,
                  enableIntervalSelection: true,
                  showTicks: true,
                  showLabels: true,
                  child: Container(
                    height: 10,
                  ),
                  // onChanged: ,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  "Vehicle type",
                  style: HintStyle1,
                ),
              ),
              Container(
                width: 305,
                height: 120,
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  childAspectRatio: 60 / 35,
                  children: List.generate(VehcileTypeList.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CustomCheckbox(
                        text: VehcileTypeList[index],
                        width: 63,
                        height: 35,
                        selected: false,
                        small: true,
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  "Condition",
                  style: HintStyle1,
                ),
              ),
              Container(
                width: 300,
                height: 40,
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  childAspectRatio: 60 / 35,
                  children: List.generate(VehicleConditionList.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      child: CustomCheckbox(
                        text: VehicleConditionList[index],
                        width: 60,
                        height: 35,
                        selected: false,
                        small: true,
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  "Fuel type",
                  style: HintStyle1,
                ),
              ),
              Container(
                width: 300,
                height: 40,
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  childAspectRatio: 60 / 35,
                  children: List.generate(VehicleFuelList.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CustomCheckbox(
                        text: VehicleFuelList[index],
                        width: 63,
                        height: 35,
                        selected: false,
                        small: true,
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                child: Text(
                  "Transmission",
                  style: HintStyle1,
                ),
              ),
              Container(
                width: 300,
                height: 40,
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  childAspectRatio: 60 / 35,
                  children:
                      List.generate(VehicleTransmissionList.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CustomCheckbox(
                        text: VehicleTransmissionList[index],
                        width: 63,
                        height: 35,
                        selected: false,
                        small: true,
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 120),
                child: CustomButton(
                  text: "Filter",
                  width: 330.0,
                ),
              )
            ]),
      ),
    );
  }
}
