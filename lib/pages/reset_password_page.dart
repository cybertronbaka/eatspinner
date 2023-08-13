import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();

    return Scaffold(
      body: SafeArea(
        child: ReactiveForm(
          formGroup: controller.formGroup,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SpacedColumn(
                spaceHeight: 20,
                children: [
                  const SizedBox(height: 20),
                  const SpacedColumn(
                    spaceHeight: 8,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Resetting password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Set new password for your account.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF626262)
                            )
                        ),
                      ),
                    ],
                  ),
                  const EsPasswordField(
                    formControlName: 'password',
                    labelText: 'Password',
                  ),
                  ReactiveFormConsumer(
                    builder: (context, fg, _){
                      return Obx(() => EsFilledButton(
                        onPressed: controller.isPending.isTrue || fg.invalid ? null : (){
                          controller.resetPassword().then((value){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Reset Password link has been sent your email'))
                            );
                            context.pushReplacement(Routes.login);
                          }).catchError((e){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: ${e.toString()}'))
                            );
                          });
                        },
                        labelText: 'RESET PASSWORD',
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}