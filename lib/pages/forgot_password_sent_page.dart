import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordSentPage extends StatelessWidget {
  const ForgotPasswordSentPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              context.pop();
            }
          ),
        ),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SpacedColumn(
                spaceHeight: 20,
                children: [
                  SpacedColumn(
                    spaceHeight: 8,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Password reset email send.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            )
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'We have sent the password reset link to the email you have provided earlier. Please check your email to reset password.',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF626262)
                              )
                          )
                      ),
                    ],
                  ),
                  Divider()
                ],
              ),
            ),
          ),
        )
    );
  }
}