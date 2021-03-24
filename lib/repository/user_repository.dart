import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soilnutrientanalyzer/model/user.dart';

class LoginUserFirebaseRepository extends LoginUserRepository {
  final FirebaseFirestore firestore;

  LoginUserFirebaseRepository(this.firestore);
  @override
  Future<void> signUp(User user) async {
    await firestore.collection('users').doc(user.id).set(user.toMap());
  }
}

abstract class LoginUserRepository {
  Future<void> signUp(User user);
}
