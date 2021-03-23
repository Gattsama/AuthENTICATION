import 'package:codespiration_signin/auth.dart';
import 'package:codespiration_signin/menu_frame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  final Function goToSignUpCallBack;

  SignIn({@required this.goToSignUpCallBack});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscurePassword = true;
  bool _rememberPassword = false;
  String email;
  String password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Text(
                'SIGN IN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 26.0),
              ),
              TextFormField(
                onChanged: (val) {
                  email = val;
                },
                validator: (name) {
                  if (name.isEmpty) {
                    return 'Must enter email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Enter User Name',
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    )),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  password = val;
                },
                obscureText: obscurePassword,
                style: TextStyle(color: Colors.white, fontSize: 22),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(FontAwesomeIcons.eye),
                      onPressed: () {
                        print(obscurePassword);
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      }),
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                      activeColor: Colors.orange,
                      value: _rememberPassword,
                      onChanged: (newValue) {
                        setState(() {
                          _rememberPassword = newValue;
                        });
                      }),
                  Text(
                    'Remember Password',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  SignInMethods()
                      .signInWithEmailPassword(email, password)
                      .then((value) {
                    print(FirebaseAuth.instance.currentUser);

                    if (FirebaseAuth.instance.currentUser != null &&
                        !FirebaseAuth.instance.currentUser.emailVerified) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'ERROR',
                                textAlign: TextAlign.center,
                              ),
                              content: Text('Please verify sent email',
                                  textAlign: TextAlign.center),
                            );
                          });
                    }
                    if (FirebaseAuth.instance.currentUser == null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'ERROR',
                                textAlign: TextAlign.center,
                              ),
                              content: Text('Incorrect UserName or Password',
                                  textAlign: TextAlign.center),
                            );
                          });
                    } else if (FirebaseAuth.instance.currentUser != null &&
                        FirebaseAuth.instance.currentUser.emailVerified) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Container(
                              color: Colors.purple,
                              child: TextButton(
                                  onPressed: () {
                                    SignInMethods().signOut();
                                    SignInMethods().signOutGoogle();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MenuFrame();
                                    }));
                                  },
                                  child: Text('Logged in\Sign Out')),
                            );
                          },
                        ),
                      );
                    }
                  });
                  //     .catchError((e) {
                  //   print('THERE WAS AN ERROR');
                  // });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white),
                  child: Text(
                    'LOG IN',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      SignInMethods().singInWithGoogle();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.red,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                  ),
                  SizedBox(width: 30),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.red,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                // padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: Colors.red[800]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account. Create One:  ',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.goToSignUpCallBack();
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
