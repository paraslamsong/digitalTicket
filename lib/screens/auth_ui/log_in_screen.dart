import 'package:fahrenheit/screens/SignUp/TabView.dart';
import 'package:fahrenheit/screens/auth_ui/Model/UserLogin.dart';
import 'package:fahrenheit/screens/utils/validators.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  AutovalidateMode _autovalidateMode;
  bool isLoading = false;
  String token;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffold,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            // image: DecorationImage(
            //   image: AssetImage("images/background_image.jpeg"),
            //   fit: BoxFit.cover,
            //   colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
            // ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.decal),
                ),
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      controller: emailEditingController,
                                      validator: validateEmail,
                                      decoration: new InputDecoration(
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: TextFormField(
                                      obscureText: !_showPass,
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      controller: passwordEditingController,
                                      validator: validatePassword,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          splashRadius: 20,
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _showPass = !_showPass;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 60.0, right: 60.0),
                                    child: Hero(
                                      tag: "LoginBtn",
                                      child: TextButton(
                                        style: ButtonStyle(),
                                        onPressed: () {
                                          _validateInputs();
                                        },
                                        child: Text(
                                          "LOG IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don\'t have an account?",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                      ),
                                      SizedBox(width: 10.0),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return TabView();
                                          }));
                                        },
                                        child: Hero(
                                          tag: "register",
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: Text(
                                              "REGISTER",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 120,
                        child: Hero(
                          tag: "Logo",
                          child: Image.asset(
                            "assets/icons/logo.png",
                            width: 200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _logIn() async {
    UserLogin userLogin = new UserLogin(
        emailEditingController.text, passwordEditingController.text);

    userLogin.doLogin(context);
  }

  void _validateInputs() {
    // if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    _logIn();
    // }
  }
}
