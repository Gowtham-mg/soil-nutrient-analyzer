import 'package:flutter/material.dart';
import 'package:soilnutrientanalyzer/metadata/meta_text.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';
import 'package:soilnutrientanalyzer/model/data_model.dart';
import '../repo/data_repo.dart';

class ResultsScreen extends StatelessWidget {
  final Crop selectedCrop;
  final String language;
  final TextStyle style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  ResultsScreen({Key key, @required this.selectedCrop, @required this.language})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    DataModel data = repo
        .firstWhere((element) =>
            element.keys.first.split('|').any((e) => e == selectedCrop.name))
        ?.values
        ?.first;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MetaText.soilNutrientAnalyzer,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.asset(
                    selectedCrop.image,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  selectedCrop.name,
                  style: style,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('pH value:  ${data.ph}', style: style),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '${getTemperature()}:  ${data.temperature}',
                style: style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '${getMoisture()}:  ${data.moisture}',
                style: style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('npk ratio:  ${data.npkRatio}', style: style),
            ),
          ],
        ),
      ),
    );
  }

  String getTemperature() {
    if (language == 'English') {
      return 'Temperature';
    } else if (language == 'தமிழ்') {
      return 'வெப்ப நிலை';
    } else {
      return 'तापमान';
    }
  }

  String getMoisture() {
    if (language == 'English') {
      return 'Moisture';
    } else if (language == 'தமிழ்') {
      return 'ஈரப்பதம்';
    } else {
      return 'नमी';
    }
  }
}
