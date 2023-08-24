import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shimmer/shimmer.dart';


class EditProfilePage extends StatelessWidget{
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    controller.fetchProfile();
    final profileController = Get.find<MyProfileController>();

    const coverPhotoHeight = 150.0;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: BackButton(
          onPressed: (){
            profileController.fetchProfile();
            context.pop();
          },
        ),
        title: Obx((){
          return controller.isFetching.isTrue
              ? const Text('')
              : Text(controller.profile.value?.name ?? '');
        }),
      ),
      body: Obx((){
        return controller.isFetching.isFalse
            ? ReactiveForm(
          formGroup: controller.formGroup.value!,
          child: ListView(
            children: [
              SizedBox(
                height: coverPhotoHeight * 1.5,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ReactiveValueListenableBuilder(
                      formControlName: 'cover_url',
                      builder: (context, control, _){
                        return CoverPhoto(
                            url: StorageUtils.getPublicUrl(control.value as String?),
                            isEditable: true,
                            height: coverPhotoHeight,
                            onPick: (image) => controller.uploadPhoto(image, 'cover')
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: ReactiveValueListenableBuilder(
                        formControlName: 'avatar_url',
                        builder: (context, control, child) {
                          return ProfilePhoto(
                            url: StorageUtils.getPublicUrl(control.value as String?),
                            isEditable: true,
                            hasBorder: true,
                            diameter: coverPhotoHeight,
                            onPick: (image) => controller.uploadPhoto(image, 'avatar'),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SpacedColumn(
                  spaceHeight: 20,
                  children: [
                    const EsTextField(
                      formControlName: 'name',
                      labelText: 'Name',
                    ),
                    const EsCounterField(
                        formControlName: 'age',
                        labelText: 'Age'
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
                    const EsTextField(
                      formControlName: 'email',
                      labelText: 'Email',
                      readOnly: true,
                    ),
                    const EsTextField(
                      formControlName: 'bio',
                      labelText: 'Bio',
                      maxLines: 5,
                      minLines: 3,
                    ),
                    EsFilledButton(
                      onPressed: (){
                        controller.save();
                      },
                      labelText: 'SAVE',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
            : const EditProfileShimmer();
      }),
    );
  }
}

class EditProfileShimmer extends StatelessWidget {
  const EditProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const coverPhotoHeight = 150.0;

    return ListView(
      children: [
        SizedBox(
          height: coverPhotoHeight * 1.5,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Shimmer.fromColors(
                baseColor: const Color(0xFFD2D2D2),
                highlightColor: const Color(0xFFE5E5E5),
                child: const CoverPhoto(
                  url: '',
                  isEditable: true,
                  height: coverPhotoHeight,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                child: Shimmer.fromColors(
                  baseColor: const Color(0xFFD2D2D2),
                  highlightColor: const Color(0xFFE5E5E5),
                  child: const ProfilePhoto(
                    url: '',
                    isEditable: true,
                    hasBorder: true,
                    diameter: coverPhotoHeight,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SpacedColumn(
            spaceHeight: 20,
            children: [
              const EsTextFieldShimmer(),
              const EsCounterFieldShimmer(),
              const EsDropdownFieldShimmer(),
              const EsTextFieldShimmer(),
              const EsTextFieldMultiLineShimmer(lines: 3),
              Shimmer.fromColors(
                  baseColor: const Color(0xFFD2D2D2),
                  highlightColor: const Color(0xFFE5E5E5),
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  )
              )
            ],
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}