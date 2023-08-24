import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpinnerController>();
    controller.fetchNearby();
    const bgColor = Color(0xFF121318);
    return Scaffold(
        // backgroundColor: bgColor,
        appBar: AppBar(
          leadingWidth: 30,
          title: const Text('Eat Spinner', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            Obx(() => IconButton(
                onPressed: controller.isSpinning.isTrue ? null : (){
                  context.push(Routes.places);
                },
                icon: const Icon(Icons.edit_outlined)
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
        Expanded(flex: 6, child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFF999572).withOpacity(0.2),
                      width: 5
                  ),
                  gradient: const LinearGradient(
                    // colors: [Color(0xFFB9D3E0), Color(0xFFC2E2EE)],
                    colors: [Color(0xFFF9F5D2), Color(0xFFD9D5B2)],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    FortuneWheel(
                        physics: NoPanPhysics(),
                        animateFirst: false,
                        rotationCount: 30,
                        styleStrategy: CustomSpinnerStyleStrategy(),
                        duration: const Duration(seconds: 10),
                        selected: controller.fortuneStream.value.stream,
                        onAnimationEnd: (){
                          controller.onSpinDone();
                          controller.showSelectedPlace(context);
                        },
                        indicators: [
                          FortuneIndicator(
                            alignment: Alignment.topCenter,
                            child: Container(color: Colors.transparent),
                          ),
                        ],
                        items: controller.places.map((e){
                          return FortuneItem(child: Text(e.name));
                        }).toList()
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF626262).withOpacity(0.8),
                            width: 5
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 20
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 70,
                        width: 70,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF999572).withOpacity(0.2),
                              width: 5
                          ),
                          gradient: const LinearGradient(
                            // colors: [Color(0xFFB9D3E0), Color(0xFFC2E2EE)],
                            colors: [Color(0xFFF9F5D2), Color(0xFFD9D5B2)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF999572).withOpacity(0.2),
                              width: 5
                            ),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF86DEF0), Color(0xFF31BCC4)],
                              begin: Alignment.centerRight,
                              end: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: CustomSpinnerIndicator(),
            )
          ],
        )),
        const SizedBox(height: 20),
        SizedBox(
          width: 1000,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: EsFilledButton(
                onPressed: controller.isSpinning.isTrue || controller.canBeSpun.isFalse ? null : (){
                  controller.spin();
                },
                labelText: 'SPIN',
            ),
          ),
        ),
        Expanded(flex: 2, child: Container())
      ],
    ));
  }
}

class CustomSpinnerStyleStrategy extends StyleStrategy{
  static const _darkBlue = Color(0xFF0B77AA);
  static const _darkGreen = Color(0xFF00A960);
  static const _orange = Color(0xFFF9A632);
  static const _brown = Color(0xFFA76A4E);
  static const _purple = Color(0xFFBA5092);
  static const _red = Color(0xFFDB2E3C);
  static const _dirtyGreen = Color(0xFF616247);
  static const _darkOrange = Color(0xFFE47A2E);

  final colorRules = [
    [_darkBlue, _brown], // 2
    [_darkBlue, _brown, _darkGreen], // 3
    [_darkBlue, _brown, _darkGreen, _orange], // 4
    [_darkBlue, _brown, _darkGreen, _orange, _purple], // 5
    [_darkBlue, _brown, _darkGreen, _orange, _purple, _red], // 6
    [_darkBlue, _brown, _darkGreen, _orange, _purple, _red, _dirtyGreen], // 7
    [_darkBlue, _brown, _darkGreen, _orange, _purple, _red, _dirtyGreen, _darkOrange], // 8
  ];

  @override
  FortuneItemStyle getItemStyle(ThemeData theme, int index, int itemCount) {
    return FortuneItemStyle(
      color: colorRules[itemCount - 2][index],
      borderColor: Colors.transparent,
      borderWidth: 0,
      textAlign: TextAlign.end,
    );
  }
}