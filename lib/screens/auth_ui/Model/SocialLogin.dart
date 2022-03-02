import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/MainScreen/MainScreen.dart';
import 'package:fahrenheit/screens/utils/loadingOverlay.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/src/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<void> googleSignIn(BuildContext context, value) async {
  Response response = await HTTP().post(
    path: "google/",
    body: {"access_token": value.accessToken},
    context: context,
  );
  if (response != null) {
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      var data = response.data['data'];
      Fluttertoast.showToast(msg: response.data['message']);
      debugPrint({
        "access": data['access_token'],
        "refresh": data['refresh_token']
      }.toString());
      User().setTokens(
          access: data['access_token'], refresh: data['refresh_token']);
      User().saveToken();
      print(User().getAcess());
      Fluttertoast.showToast(msg: "Logged in", backgroundColor: Colors.green);
      OverlayLoader(context).hide();
      context.read<SessionCubit>().loggedIn();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      OverlayLoader(context).hide();
      Fluttertoast.showToast(msg: response.data['message']);
    }
    print(response.data);
  }
}

class SocialLogin {
  static googlelogin(BuildContext context) async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
      );
      debugPrint((await _googleSignIn.isSignedIn()).toString());
      if (await _googleSignIn.isSignedIn()) {
        _googleSignIn.signOut();
      }
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

      googleSignInAccount.authentication.then((value) async {
        print(value.accessToken);
        // context.loaderOverlay.show();
        print(value.accessToken);
        googleSignIn(context, value);
      });
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  static applelogin(BuildContext context) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    OverlayLoader(context).show();
    print(credential.authorizationCode);
    print(credential.email);
    print(credential.givenName);
    print(credential.familyName);
    print(credential.identityToken);

    Response response = await HTTP().post(
      path: "apple/",
      body: {
        "access_token": credential.authorizationCode,
        "id_token": credential.identityToken
      },
      context: context,
    );
    // ignore: unnecessary_null_comparison
    if (response != null) {
      OverlayLoader(context).hide();
      if (response.statusCode == 200) {
        var data = response.data['data'];
        Fluttertoast.showToast(msg: response.data['message']);
        User().setTokens(
            access: data['access_token'], refresh: data['refresh_token']);
        User().saveToken();
        print(User().getAcess());
        Fluttertoast.showToast(msg: "Logged in", backgroundColor: Colors.green);
        OverlayLoader(context).hide();
        context.read<SessionCubit>().loggedIn();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } else if (response.statusCode != 500) {
        Fluttertoast.showToast(msg: response.data['message']);
      } else {
        Fluttertoast.showToast(msg: response.data);
      }
      print(response.statusCode);
      print(response.data);
    }
  }
}
