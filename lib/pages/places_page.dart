import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlacesController>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            context.go(Routes.spinner);
          },
        ),
        title: const Text('Places'),
        actions: [
          IconButton(
            onPressed: (){
              context.go(Routes.addPlace);
            },
            icon: const Icon(Icons.add_outlined)
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: ReactiveForm(
                  formGroup: controller.formGroup,
                  child: EsTextField<String>(
                    formControlName: 'query',
                    labelText: 'Search...',
                    suffixIcon: const Icon(Icons.search_outlined),
                    onChanged: (control){
                      if(control.value == null || control.value!.length < 3) return;

                      controller.search(control.value!);
                    },
                    onEditingComplete: (control) => controller.search(control.value!)
                  ),
                )),
              ],
            ),
          )),
          Expanded(flex: 6, child: Obx(
            () => controller.isFetching.isFalse ? ListView(
              physics: const BouncingScrollPhysics(),
              children: controller.places.value.map((e){
                return PlaceCard(place: e);
              }).toList(),
            ) : const Column(children: [SizedBox(height: 20), SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: Colors.blue))],)
          ))
        ],
      ),
    );
  }
}