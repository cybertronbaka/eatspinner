import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

    return Scaffold(
      backgroundColor: Colors.white,
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
                    spaceHeight: 5,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'You can add friends and start having conversations',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF626262)
                            )
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                      'assets/images/cat_with_hat.svg',
                      semanticsLabel: 'No Data'
                  ),
                  const EsTextField(
                    formControlName: 'name',
                    labelText: 'Name',
                  ),
                  const EsCounterField(
                    formControlName: 'age',
                    labelText: 'Age',
                    min: 13,
                  ),
                  const EsTextField(
                    formControlName: 'email',
                    labelText: 'Email',
                  ),
                  const EsDropdownField(
                      formControlName: 'gender',
                      labelText: 'Gender',
                      items: [
                        DropdownMenuItem(
                            value: 'Male',
                            child: Text('Male')
                        ),
                        DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female')
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ]
                  ),
                  const EsPasswordField(
                    formControlName: 'password',
                    labelText: 'Password',
                  ),
                  ReactiveFormConsumer(
                    builder: (context, fg, _){
                      return Obx(()=>EsFilledButton(
                        onPressed: controller.isSigningUp.isTrue || fg.invalid ? null : (){
                          controller.signUp().then((value){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signed Up in successfully'))
                            );
                            context.pushReplacement(Routes.spinner);
                          }).catchError((e){
                            print('Error: ${e.toString()}');
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: ${e.toString()}'))
                            );
                          });
                        },
                        labelText: 'SIGN UP',
                      ));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                          onTap: (){
                            context.pushReplacement(Routes.login);
                          },
                          child: const Text(
                            'Sign in here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                            )
                          )
                      )
                    ],
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