import 'package:codespiration_signin/auth.dart';
import 'package:codespiration_signin/menu_frame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateLogin extends StatefulWidget {
  final Function cancelBackToHome;

  CreateLogin({@required this.cancelBackToHome});

  @override
  _CreateLogin createState() => _CreateLogin();
}

class _CreateLogin extends State<CreateLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String passwordConfrim;
  bool obscurePassword = true;
  bool _termsAgreed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'CREATE YOUR LOGIN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 26.0),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (text) {
                  email = text;
                },
                validator: (emailVal) {
                  if (emailVal.isEmpty) {
                    return 'This field is mandatory';
                  }
                  // using regular expression
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
                    return "Please enter a valid email address";
                  }

                  // the email is valid
                  return null;
                },
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Enter Email',
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    )),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                validator: (passwdVal) {
                  if (passwdVal.isEmpty) {
                    return 'This field is mandatory';
                  }
                  if (passwdVal.length < 6) {
                    return 'Password Must be greater than 6 characters';
                  }
                  return null;
                },
                obscureText: obscurePassword,
                style: TextStyle(color: Colors.white, fontSize: 22),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
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
              TextFormField(
                onChanged: (text) {
                  passwordConfrim = text;
                },
                validator: (passwdConFirmVal) {
                  if (passwdConFirmVal.isEmpty) {
                    return 'This field is mandatory';
                  }
                  if (passwdConFirmVal != password) {
                    return 'Passwords Must Match';
                  }
                  return null;
                },
                obscureText: obscurePassword,
                style: TextStyle(color: Colors.white, fontSize: 22),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                      icon: Icon(FontAwesomeIcons.eye),
                      onPressed: () {
                        print(obscurePassword);
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      }),
                  labelText: 'Re-Enter Password',
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
                      value: _termsAgreed,
                      onChanged: (newValue) {
                        setState(() {
                          _termsAgreed = newValue;
                        });
                      }),
                  Text(
                    'Agree to Terms & Conditions',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => widget.cancelBackToHome(),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .catchError((error) {
                          print(error.code);
                          if (error.code == 'email-already-in-use') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Account already exists with provided Email'),
                                  );
                                });
                          }
                        });
                        if (!FirebaseAuth.instance.currentUser.emailVerified) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      'Please Check Email For Verification'),
                                );
                              });
                        } else {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Container(
                              child: TextButton(
                                onPressed: () {
                                  SignInMethods().signOut();
                                  SignInMethods().signOutGoogle();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MenuFrame();
                                  }));
                                },
                                child: Text('New User Created\nSign Out'),
                              ),
                              color: Colors.purple,
                            );
                          }));
                        }
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white),
                      child: Text(
                        'SAVE',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Terms & Conditions',
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              )
            ],
          ),
        ),
      ),
    );
  }
}
