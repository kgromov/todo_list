import 'package:flutter/material.dart';
import '../Services/oauth2_authentication_service.dart';
import './home_screen.dart';

class SigninPage extends StatelessWidget {
  final Oauth2AuthenticationService authService;

  const SigninPage(this.authService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Signin with Google!')),
        body: Align(
            alignment: Alignment.center,
            child: OutlinedButton(
                onPressed: () {
                  authService.signIn()
                  .then((user) => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen(user)))
                  });
                },
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                // splashColor: Colors.grey,
                // borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                            image: AssetImage('assets/google_logo.png'),
                            height: 35),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Sign in with Google',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 25)))
                      ],
                    )
                )
            )
        )
    );
  }
}
