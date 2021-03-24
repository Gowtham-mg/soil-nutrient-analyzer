import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';

abstract class CropRepository {
  Future<AppResponse<List<String>>> translateSoilType(String language);
  Future<AppResponse<List<Crop>>> translateCrop(String language);
  Future<AppResponse<Map<String, String>>> translateBasicWords(String language);
}

class CropFirebaseRepository extends CropRepository {
  final FirebaseFirestore firestore;

  CropFirebaseRepository(this.firestore);
  @override
  Future<AppResponse<List<Crop>>> translateCrop(String language) async {
    try {
      DocumentSnapshot _cropsSnap =
          await firestore.collection(language).doc('crops').get();
      var _crops = _cropsSnap.data()['crops'];
      DocumentSnapshot _assetsSnap = await firestore.doc('en/asset').get();
      var _assets = _assetsSnap.data()['assetPath'];
      List<Crop> crops = [];
      for (int i = 0; i < 16; i++) {
        crops.add(Crop.named(image: _assets[i], name: _crops[i]));
      }
      return AppResponse.named(data: crops);
    } catch (e) {
      return AppResponse.named(error: e.toString());
    }
  }

  @override
  Future<AppResponse<List<String>>> translateSoilType(String language) async {
    try {
      DocumentSnapshot _soilSnap =
          await firestore.doc('$language/soilType').get();
      List<String> soilTypes = _soilSnap.data()['type'].cast<String>();
      return AppResponse.named(data: soilTypes);
    } catch (e) {
      return AppResponse.named(error: e.toString());
    }
  }

  @override
  Future<AppResponse<Map<String, String>>> translateBasicWords(
      String language) async {
    try {
      DocumentSnapshot _basicWordsSnap =
          await firestore.doc('$language/basicwords').get();
      Map<String, String> _words =
          Map<String, String>.from(_basicWordsSnap.data()['words']);
      return AppResponse.named(data: _words);
    } catch (e) {
      return AppResponse.named(error: e.toString());
    }
  }
}
