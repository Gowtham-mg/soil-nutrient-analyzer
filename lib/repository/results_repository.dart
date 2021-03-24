import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/bloc/result_bloc.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';
import 'package:soilnutrientanalyzer/model/data_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

abstract class ResultsRepository {
  Future<AppResponse<DataModel>> cropResults(Crop selectedCrop);
  Future<void> saveResult(ResultSuccess success);
}

class ResultsFriebaseRepository extends ResultsRepository {
  final FirebaseFirestore firestore;
  final Box box;
  final Uuid uuid;
  ResultsFriebaseRepository(this.firestore, this.box, this.uuid);

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

  @override
  Future<void> saveResult(ResultSuccess success) async {
    String token = box.get('token').toString();
    await firestore
        .collection('result')
        .add(success.toMap()..addEntries([MapEntry('id', token)]));
  }
}
