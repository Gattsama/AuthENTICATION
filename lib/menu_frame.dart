import 'package:codespiration_signin/home_signin_widget.dart';
import 'package:codespiration_signin/create_login.dart';
import 'package:codespiration_signin/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuFrame extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 123, 67, 1),
                  Color.fromRGBO(245, 50, 111, 1)
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.user,
                  color: Color.fromRGBO(245, 48, 111, 1),
                  size: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Auth',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(245, 48, 111, 1)),
                    ),
                    Text(
                      'ENTICATION',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                Text(
                  'Master Login Template',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 100),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      HomeSignInWidget(
                        //page 0
                        //these are both callbacks
                        goToSignIn: () {
                          _pageController.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        goToSignUp: () {
                          _pageController.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
                      SignIn(
                        //page 1
                        goToSignUpCallBack: () {
                          _pageController.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
                      CreateLogin(cancelBackToHome: () {
                        //page 2
                        _pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
