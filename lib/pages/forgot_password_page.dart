import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            context.pushReplacement(Routes.login);
          }
        ),
      ),
      body: SafeArea(
          child: ReactiveForm(
            formGroup: controller.formGroup,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SpacedColumn(
                  spaceHeight: 20,
                  children: [
                    const SpacedColumn(
                      spaceHeight: 8,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              )
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                'Please enter the email address associated with your account. A link will be sent to the email address you enter.',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF626262)
                                )
                            )
                        ),
                      ],
                    ),
                    const EsTextField(
                      formControlName: 'email',
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.mark_email_unread_outlined),
                    ),
                    ReactiveFormConsumer(
                      builder: (context, fg, _){
                        return Obx(()=> EsFilledButton(
                          onPressed: controller.isPending.isTrue || fg.invalid ? null : (){
                            controller.resetPassword().then((value){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Reset Password link has been sent your email'))
                              );
                              context.pushReplacement(Routes.forgotPasswordSent);
                            }).catchError((e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: ${e.toString()}'))
                              );
                            });
                          },
                          labelText: 'PROCEED',
                        ));
                      },
                    ),
                    const Divider()
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}