import 'package:deezer_media_player/auth/auth.dart';
import 'package:deezer_media_player/pages/home/home_page.dart';
import 'package:deezer_media_player/pages/login/widgets/input_text_login.dart';
import 'package:deezer_media_player/utils/app_colors.dart';
import 'package:deezer_media_player/utils/extras.dart';
import 'package:deezer_media_player/utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ForgotPasswordForm extends StatefulWidget {
  final VoidCallback onGoToLogin;
  const ForgotPasswordForm({required this.onGoToLogin});

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _sent = false;
  final GlobalKey<InputTextLoginState> _emailKey = GlobalKey();

  void _goTo(BuildContext context, User user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print("login failed");
    }
  }

  Future<void> _submit() async {
    final String email = _emailKey.currentState!.value;
    final bool emailOk = _emailKey.currentState!.isOk;

    if (emailOk) {
      final bool isOk =
          await Auth.instance.sendResetEmailLink(context, email: email);
      setState(() {
        _sent = isOk;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Reset Password",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 30,
                    fontFamily: 'raleway',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Lorem ipsum dolor sit amet,  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
              _sent
                  ? Text("The email to reset your password was sent.")
                  : InputTextLogin(
                      key: _emailKey,
                      iconPath: 'assets/pages/login/icons/email.svg',
                      placeholder: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) => Extras.isValidEmail(text),
                    ),
              SizedBox(
                height: responsive.ip(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: widget.onGoToLogin,
                    child: Text("← Back to Log In"),
                  ),
                  if (!_sent) ...[
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text("Send"),
                      onPressed: this._submit,
                    ),
                  ]
                ],
              ),
              SizedBox(
                height: responsive.ip(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
