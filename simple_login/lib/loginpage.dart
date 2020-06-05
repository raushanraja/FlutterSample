import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaancard/authserv.dart';
import 'package:kisaancard/constants.dart';
import 'package:kisaancard/homepage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password, _username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(K_login_page_color),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "किसान",
                      style: GoogleFonts.poppins(
                        color: Color(K_login_app_title_color),
                        fontWeight: FontWeight.w500,
                        fontSize: 40.0,
                        // letterSpacing: .5
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "कार्ड",
                      style: GoogleFonts.poppins(
                          color: Color(K_login_app_title_color),
                          fontWeight: FontWeight.w200,
                          fontSize: 40.0),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff0e2d3f),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: TextFormField(
                            style: K_login_input_textstyle,
                            decoration: K_username_field,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter correct email';
                              }
                              return null;
                            },
                            onSaved: (value) => _username = value,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff0e2d3f),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: TextFormField(
                            style: K_login_input_textstyle,
                            decoration: K_password_field,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter correct password';
                              }
                              return null;
                            },
                            onSaved: (value) => _password = value,
                          ),
                        ),
                      ),
                      SSignButton(
                        textstyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                        buttonLabel: "LOGIN",
                        onTap: () async {
                          final form = _formKey.currentState;
                          form.save();
                          if (_formKey.currentState.validate()) {
                            Map result = await Provider.of<AuthService>(context,
                                    listen: false)
                                .login(id: _username, password: _password);
                            if (result == null) {
                              _buildShowErrorDialog(context,
                                  "Error Logging In With Those Credentials");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                      title: "Hello",
                                    ),
                                  ));
                            }
                          }
                        },
                        buttonColor: Color(K_login_app_title_color),
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SSignButton extends StatelessWidget {
  const SSignButton({
    @required this.textstyle,
    @required this.buttonLabel,
    @required this.onTap,
    @required this.buttonColor,
  });
  final TextStyle textstyle;
  final String buttonLabel;
  final Function onTap;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: buttonColor,
      height: 60,
      minWidth: double.maxFinite,
      child: Text(
        buttonLabel,
        style: textstyle,
      ),
    );
  }
}

Future _buildShowErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Error Message'),
        content: Text(_message),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
