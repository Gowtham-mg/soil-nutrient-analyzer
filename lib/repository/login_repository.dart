import 'package:google_sign_in/google_sign_in.dart';
import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/user.dart' as us;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:soilnutrientanalyzer/repository/user_repository.dart';

abstract class AuthRepository {
  Future<AppResponse<us.User>> signIn(String email, String password);
  Future<AppResponse<us.User>> signUp(String email, String password);
  Future<AppResponse<us.User>> googleAuth();
}

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final Box box;
  final LoginUserRepository userRepository;

  FirebaseAuthRepository(this.firebaseAuth, this.box, this.userRepository);

  @override
  Future<AppResponse<us.User>> googleAuth() async {
    try {
      GoogleSignIn _googleSign = GoogleSignIn();
      await _googleSign.signOut();
      var response = await _googleSign.signIn();
      var authentication = await response.authentication;
      var googleResponse =
          await firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      ));
      us.User user = us.User.named(id: googleResponse.user.uid);
      bool _isNewUser = googleResponse.additionalUserInfo.isNewUser;
      await box.put('token', user.id);

      user = user.copyWith(email: googleResponse.user.email);
      if (_isNewUser) {
        await userRepository.signUp(user);
      }
      return AppResponse.named(data: user);
    } catch (e) {
      print(e.toString());
      return AppResponse.named(error: "Google Login Error");
    }
  }

  @override
  Future<AppResponse<us.User>> signIn(String email, String password) async {
    try {
      var userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      us.User user = us.User.named(id: userCredential.user.uid);
      await box.put('token', user.id);
      user = us.User.named(
        email: email,
        password: password,
      );
      if (userRepository != null) {
        await userRepository.signUp(user);
      }
      return AppResponse.named(data: user);
    } catch (e) {
      return AppResponse.named(error: e.toString());
    }
  }

  @override
  Future<AppResponse<us.User>> signUp(String email, String password) async {
    try {
      var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = us.User.named(id: userCredential.user.uid);
      await box.put('token', user.id);
      user = user.copyWith(
        email: user.email,
        password: user.password,
      );
      if (userRepository != null) {
        await userRepository.signUp(user);
      }
      return AppResponse.named(data: user);
    } catch (e) {
      return AppResponse.named(error: e.toString());
    }
  }
}
