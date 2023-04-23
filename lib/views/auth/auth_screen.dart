import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_ar/controllers/auth_controller.dart';
import 'package:furniture_ar/controllers/database.dart';
import 'package:furniture_ar/models/user_model.dart';
import 'package:furniture_ar/shared/snackbar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: !_loading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome to FurnitureAR",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Our app requires you to login/register "
                      "with either of the following services",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45),
                    ),
                    const SizedBox(height: 80.0),
                    TextButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)))),
                      onPressed: () async {
                        setState(() => _loading = true);
                        await signInMethods(
                            AuthenticationController().signInWithGoogle());
                        setState(() => _loading = false);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/logos/g_logo.png",
                              width: 20.0, height: 20.0),
                          const SizedBox(width: 20.0),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text: "Continue with ",
                                    style: TextStyle(color: Colors.black45)),
                                TextSpan(
                                  text: "Google",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)))),
                      onPressed: () async {
                        setState(() => _loading = true);
                        await signInMethods(
                            AuthenticationController().signInWithFacebook());
                        setState(() => _loading = false);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/logos/fb_logo.png",
                              width: 20.0, height: 20.0),
                          const SizedBox(width: 20.0),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontFamily: "Montserrat", fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text: "Continue with ",
                                    style: TextStyle(color: Colors.black45)),
                                TextSpan(
                                  text: "Meta",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CupertinoActivityIndicator(
                      color: Colors.black,
                    ),
                    SizedBox(height: 20.0),
                    Text("Processing request"),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> signInMethods(Future<UserCredential> signInMethod) async {
    try {
      UserCredential userCredential = await signInMethod;
      if (userCredential.user != null &&
          userCredential.additionalUserInfo != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await DatabaseController(uid: userCredential.user!.uid).setUserData(
            UserModel(
              uid: userCredential.user!.uid,
              name: userCredential.user!.displayName ?? '',
              email: userCredential.user!.email ?? '',
              phone: userCredential.user!.phoneNumber ?? '',
            ),
          );
        }
      } else {}
    } catch (e) {
      commonSnackbar(e.toString(), context);
    }
  }
}
