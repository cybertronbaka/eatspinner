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
        backgroundColor: Colors.white,
        body: ReactiveForm(
          formGroup: controller.formGroup,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SpacedColumn(
                  spaceHeight: 20,
                  children: [
                    const Text('Update your password!'),
                    Image.asset(
                      'assets/images/login_image.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                    const EsPasswordField(
                      formControlName: 'password',
                      labelText: 'Password',
                    ),
                    ReactiveFormConsumer(
                      builder: (context, fg, _){
                        return SizedBox(
                          width: 1000,
                          child: Obx(() => FilledButton(
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
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Reset'),
                            )
                          )),
                        );
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