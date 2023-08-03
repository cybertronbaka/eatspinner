import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          Expanded(flex: 6, child: Obx((){
            if(controller.isFetching.isTrue) return const _Loader();

            return controller.places.isEmpty
                ? const NoDataWidget() : const PlacesListView();
          }))
        ],
      ),
    );
  }
}

class PlacesListView extends StatelessWidget {
  const PlacesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlacesController>();
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: controller.places.value.map((e){
        return PlaceCard(
          place: e,
          onDelete: (place){
            controller.deletePlace(place.id!);
          },
          onEdit: (place){
            context.go(Routes.editPlace(place.id!));
          },
        );
      }).toList(),
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        PlaceCardShimmer(),
        PlaceCardShimmer()
      ],
    );
  }
}

class NoDataWidget extends StatelessWidget{
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: SvgPicture.asset(
                'assets/images/nodata.svg',
                semanticsLabel: 'No Data'
              ),
            )
          ]
      ),
    );
  }
}