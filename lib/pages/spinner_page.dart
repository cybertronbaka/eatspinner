import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/services/deep_link_service.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SpinnerPage extends StatefulWidget{
  const SpinnerPage({super.key});

  @override
  State<StatefulWidget> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage> {

  @override
  void initState() {
    dLink.handleOnRunning(context, 'spinner');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpinnerController>();
    controller.fetchNearby(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Eat Spinner', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            Obx(() => IconButton(
              onPressed: controller.isSpinning.isTrue || controller.isLoggingOut.isTrue ? null : (){
                context.push(Routes.profile);
              },
              icon: const Icon(Icons.person_outline_outlined)
            )),
            Obx(() => IconButton(
                onPressed: controller.isSpinning.isTrue || controller.isLoggingOut.isTrue ? null : (){
                  context.push(Routes.places);
                },
                icon: const Icon(Icons.edit_outlined)
            )),
            Obx(() => IconButton(
                onPressed: controller.isSpinning.isTrue || controller.isLoggingOut.isTrue ? null : (){
                  controller.logout().then((value){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out successfully'))
                    );
                    dLink.blockRunning('spinner');
                    context.pushReplacement(Routes.login);
                  }).catchError((e){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}'))
                    );
                  });
                },
                icon: const Icon(Icons.logout)
            )),
          ],
        ),
        body: Obx(
                () => controller.isFetching.isFalse
                ?  const SpinnerPageBody()
                : const SpinnerShimmer()
        )
    );
  }
}

class SpinnerPageBody extends StatelessWidget {
  const SpinnerPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpinnerController>();

    return Obx(() => Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(flex: 6, child: Padding(
          padding: const EdgeInsets.all(20),
          child: FortuneWheel(
              physics: NoPanPhysics(),
              animateFirst: false,
              rotationCount: 30,
              duration: const Duration(seconds: 10),
              selected: controller.fortuneStream.value.stream,
              onAnimationEnd: (){
                controller.onSpinDone();
                controller.showSelectedPlace(context);
              },
              indicators: const [
                FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: TriangleIndicator(
                    color: Colors.deepOrange,
                  ),
                ),
              ],
              items: controller.places.map((e){
                return FortuneItem(child: Text(e.name));
              }).toList()
          ),
        )),
        const SizedBox(height: 20),
        SizedBox(
          width: 1000,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FilledButton(
                onPressed: controller.isSpinning.isTrue || controller.canBeSpun.isFalse || controller.isLoggingOut.isTrue ? null : (){
                  controller.spin();
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Spin'),
                )
            ),
          ),
        ),
        Expanded(flex: 2, child: Container())
      ],
    ));
  }
}