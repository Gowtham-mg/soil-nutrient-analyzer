import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';
import 'package:soilnutrientanalyzer/model/data_model.dart';

abstract class ResultsRepository {
  Future<AppResponse<DataModel>> cropResults(Crop selectedCrop);
}

class ResultsFriebaseRepository extends ResultsRepository {
  final FirebaseFirestore firestore;

  ResultsFriebaseRepository(this.firestore);

  @override
  Future<AppResponse<DataModel>> cropResults(Crop selectedCrop) async {
    try {
      QuerySnapshot _resultSnap = await firestore.collection('cropData').get();
      List<Map> _results =
          _resultSnap.docs.map((e) => {e.id: e.data()['data']}).toList();
      var _filteredResult = _results.firstWhere(
          (e) => e.keys.first.split('|').contains(selectedCrop.name));
      Map<String, String> _data =
          Map<String, String>.from(_filteredResult.values.first);
      return AppResponse.named(data: DataModel.fromMap(_data));
    } catch (e) {
      return AppResponse.named(error: e.toString());
    }
  }
}
