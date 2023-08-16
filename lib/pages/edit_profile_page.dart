import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';


class EditProfilePage extends StatelessWidget{
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    controller.fetchProfile();

    const coverPhotoHeight = 150.0;

    return Scaffold(
      appBar: AppBar(
        title: Obx((){
          return controller.isFetching.isTrue
              ? const Text('')
              : Text(controller.profile.value?.name ?? '');
        }),
      ),
      body: Obx((){
        final profile = controller.profile.value;

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
                    CoverPhoto(
                      // url: '',
                      // url: 'https://rare-gallery.com/resol/2560x1440/343212-Tanjirou-Tanjiro-Kamado-Demon-Slayer-Kimetsu-no-Yaiba-Anime-Kimetsu-no-Yaiba-.jpg',
                        url: profile!.coverUrl,
                        isEditable: true,
                        height: coverPhotoHeight
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: ProfilePhoto(
                        url: profile.avatarUrl,
                        isEditable: true,
                        hasBorder: true,
                        diameter: coverPhotoHeight,
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
                      onPressed: (){},
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
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }
}