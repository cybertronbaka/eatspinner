import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
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
                    Image.asset(
                      'assets/images/login_image.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                    const EsTextField(
                      formControlName: 'email',
                      labelText: 'Email',
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
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('Login'),
                              )
                          )),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Forgot your password? "),
                        GestureDetector(
                            onTap: (){
                              context.push(Routes.forgotPassword);
                            },
                            child: const Text(
                                'Click here',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                )
                            )
                        )
                      ],
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