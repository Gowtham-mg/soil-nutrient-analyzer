import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soilnutrientanalyzer/bloc/authbloc.dart';
import 'package:soilnutrientanalyzer/helper/validation_helper.dart';
import 'package:soilnutrientanalyzer/metadata/meta_asset.dart';
import 'package:soilnutrientanalyzer/metadata/meta_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soilnutrientanalyzer/metadata/meta_styles.dart';
import 'package:soilnutrientanalyzer/metadata/meta_text.dart';
import 'package:soilnutrientanalyzer/screens/home.dart';
import 'package:soilnutrientanalyzer/widgets/custom_outlined_button.dart';
import 'package:soilnutrientanalyzer/widgets/custom_rounded_button.dart';
import 'package:soilnutrientanalyzer/widgets/login_register_text_form_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordVisible = false;
  bool isSignup = true;
  String password;
  String email;
  final GlobalKey<FormState> _authFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(),
          Positioned(
            top: 0,
            child: Container(
              width: _width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MetaColors.signupGradient1Color,
                    MetaColors.signupGradient2Color,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.8],
                ),
              ),
              height: _height * 0.3 + 30,
              child: Center(
                child: Text(
                  MetaText.soilNutrientAnalyzer,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: _height * 0.3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              width: _width,
              height: _height - (_height * 0.3),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _width * 0.075,
                  right: _width * 0.075,
                  top: 20,
                  bottom: 15 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (BuildContext context, AuthState state) async {
                    if (state is SocialAuthSuccess ||
                        state is SignInSuccess ||
                        state is SignUpSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Home()));
                    } else if (state is AuthErrorState) {
                      Fluttertoast.showToast(
                        msg: state.error,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                  builder: (BuildContext context, AuthState state) {
                    return AbsorbPointer(
                      absorbing: state is AuthLoading,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _width * 0.925,
                            padding: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                              top: 20,
                              bottom: 15,
                            ),
                            child: Form(
                              key: _authFormKey,
                              child: Column(
                                children: [
                                  LoginRegisterTextFormField(
                                    key: ValueKey(MetaText.email),
                                    hintText: MetaText.email,
                                    onSaved: (String val) {
                                      setState(() {
                                        email = val.trim();
                                      });
                                    },
                                    validator: (String val) {
                                      print(val);
                                      return ValidationHelper
                                          .validateEmailAddress(val);
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      key: ValueKey(MetaText.password),
                                      decoration: InputDecoration(
                                        hintText: MetaText.password,
                                        hintStyle:
                                            MetaStyles.loginFormHintStyle,
                                        filled: true,
                                        fillColor: Color(0xFFE7EAEE),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabled: true,
                                        contentPadding:
                                            EdgeInsets.only(left: 22),
                                        suffixIcon: IconButton(
                                          icon: isPasswordVisible
                                              ? Icon(Icons.remove_red_eye)
                                              : SvgPicture.asset(
                                                  MetaAsset.eyeInvisible,
                                                  height: 22,
                                                  width: 22,
                                                ),
                                          onPressed: () {
                                            setState(() {
                                              isPasswordVisible =
                                                  !isPasswordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      obscureText: isPasswordVisible,
                                      validator: (String val) {
                                        return null;
                                      },
                                      // ValidationHelper.isValidPassword,
                                      onSaved: (String val) {
                                        setState(() {
                                          password = val.trim();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15.0),
                            width: _width * 0.925,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: isSignup
                                ? CustomRoundedButton(
                                    color: Color(0xFF3061E2),
                                    child: Text(
                                      MetaText.signup,
                                      style: MetaStyles.createAccount,
                                    ),
                                    onPressed: authValidation,
                                  )
                                : CustomOutlinedButton(
                                    color: Color(0xFF5B74BA),
                                    child: Text(
                                      MetaText.signin,
                                      style: TextStyle(
                                        color: Color(0xFF0F44CD),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onPressed: authValidation,
                                  ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Or',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomRoundedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  MetaAsset.google,
                                  height: 16,
                                  width: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    MetaText.continueWithGoogle,
                                    style: MetaStyles.continueWithFacebook,
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.white,
                            onPressed: onGoogleSignIn,
                          ),
                          isSignup
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                '${MetaText.alreadyHaveAnAccount}  ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                          TextSpan(
                                            text: MetaText.login,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(() {
                                                  isSignup = !isSignup;
                                                });
                                              },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 15.0,
                                    top: 25,
                                  ),
                                  width: _width * 0.925,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  child: CustomRoundedButton(
                                    color: Color(0xFF3061E2),
                                    child: Text(
                                      MetaText.createAnAccount,
                                      style: MetaStyles.createAccount,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isSignup = !isSignup;
                                      });
                                    },
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void authValidation() {
    print('Auth Validation');
    bool _formValidation = _authFormKey.currentState.validate();
    print('_formValidation $_formValidation');
    if (_formValidation) {
      _authFormKey.currentState.save();
      if (isSignup) {
        _signUp();
      } else {
        print('Executing signin');
        BlocProvider.of<AuthBloc>(context).add(SignInEvent(email, password));
      }
    }
  }

  void onGoogleSignIn() {
    BlocProvider.of<AuthBloc>(context).add(SignInFBGoogleEvent("Google"));
  }

  void _signUp() async {
    BlocProvider.of<AuthBloc>(context).add(SignUpEvent(email, password));
  }
}
