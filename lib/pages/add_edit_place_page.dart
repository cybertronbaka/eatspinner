import 'package:eatspinner/app/routes.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddEditPlacePage extends StatelessWidget {
  final bool isEdit;
  final String? id;
  const AddEditPlacePage({
    super.key,
    required this.isEdit,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddEditPlaceController>();

    return Scaffold(
      appBar: AppBar(
        leading: Obx(() => BackButton(
          onPressed: controller.isSaving.isTrue ? null : (){
            context.pop();
          },
        )),
        title:Text(isEdit ? 'Edit Place' : 'Add Place'),
      ),
      body: Obx(() => controller.isFetching.isTrue
          ? const AddEditPlaceFormShimmer()
          : const AddEditPlaceForm()
      ),
    );
  }
}

class AddEditPlaceForm extends StatelessWidget {
  const AddEditPlaceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddEditPlaceController>();

    return Obx(
      () => ReactiveForm(
          formGroup: controller.formGroup.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: SpacedColumn(
              spaceHeight: 20,
              children: [
                const EsTextField<String>(
                  formControlName: 'name',
                  labelText: 'Name',
                ),
                const EsTextField<String>(
                  formControlName: 'description',
                  labelText: 'Description',
                ),
                MapWidget(
                  onMarkerPlaced: controller.onMarkerPlaced,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RatingStars(
                    value: controller.stars.value,
                    onValueChanged: controller.onRatingChanged,
                    starCount: 5,
                    starSize: 30,
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16
                    ),
                    valueLabelRadius: 10,
                    maxValue: 5,
                    starSpacing: 2,
                    maxValueVisibility: true,
                    valueLabelVisibility: true,
                    animationDuration: const Duration(seconds: 1),
                    valueLabelPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.orange,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ReactiveFormConsumer(
                    builder: (BuildContext context, FormGroup formGroup, Widget? child) {
                      return FilledButton(
                          onPressed: controller.isSaving.isTrue || formGroup.invalid ? null : (){
                            controller.save().then((value){
                              if(value != null) context.pop();
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('SAVE'),
                          )
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}