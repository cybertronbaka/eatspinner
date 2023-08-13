import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    DeepLinkService.handleOnRunning(context);
    super.initState();
  }

  @override
  void deactivate() {
    DeepLinkService.blockRunning();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
        body: SafeArea(
          child: ReactiveForm(
            formGroup: controller.formGroup,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SpacedColumn(
                  spaceHeight: 20,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const SpacedColumn(
                      spaceHeight: 8,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Sign in',
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
                      formControlName: 'email',
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.email_outlined),
                    ),
                    const EsPasswordField(
                      formControlName: 'password',
                      labelText: 'Password',
                    ),
                    ReactiveFormConsumer(
                      builder: (context, fg, _){

                        return Obx(()=> EsFilledButton(
                          onPressed: controller.isLoggingIn.isTrue || fg.invalid ? null : (){
                            controller.login().then((value){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Logged in successfully'))
                              );
                              context.pushReplacement(Routes.spinner);
                            }).catchError((e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Invalid email or password'))
                              );
                            });
                          },
                          labelText: 'LOGIN',
                        ));
                      },
                    ),
                    GestureDetector(
                        onTap: (){
                          context.push(Routes.forgotPassword);
                        },
                        child: const Text(
                            'Forgot your password?',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                            onTap: (){
                              context.pushReplacement(Routes.signup);
                            },
                            child: const Text(
                                'Sign up here',
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