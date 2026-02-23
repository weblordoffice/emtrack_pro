import 'package:emtrack/color/app_color.dart';
import 'package:emtrack/widgets/vehicle_daigram_Rotate_tyres.dart';
import 'package:flutter/material.dart';

class RotateTyresView extends StatefulWidget {
  const RotateTyresView({super.key});

  @override
  State<RotateTyresView> createState() => _RotateTyresViewState();
}

class _RotateTyresViewState extends State<RotateTyresView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Rotate Tyres", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Parent Account and Location:"),
              Text(
                "Daves Test-Daves Test",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              Divider(),
              Text("Vehicle ID:"),
              Text(
                "#4032",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  VehicleDiagramRotateTyres(),

                  Container(
                    padding: EdgeInsets.only(
                      top: 32,
                      bottom: 32,
                      left: 16,
                      right: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Column(
                      children: [
                        Text("Rotate"),
                        Text(
                          "Tire",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Rotate"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  _colorBox('N/I', Colors.grey.shade300),
                  _colorBox('<25', Colors.greenAccent),
                  _colorBox('<50', Colors.yellow),
                  _colorBox('<75', Colors.orange),
                  _colorBox('>75', Colors.redAccent),
                ],
              ),

              const SizedBox(height: 10),
              const Text(
                'Tread Depth: (To) Outside (Ti) Inside (Tm) Middle\nPressure (P) Tyre Pressure',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.buttonDanger,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.buttonDanger),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _colorBox(String text, Color color) {
    return Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        color: color,
        child: Text(text),
      ),
    );
  }
}
