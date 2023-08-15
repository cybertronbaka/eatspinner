import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';


class EditProfilePage extends StatelessWidget{
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    FormGroup _formGroup = fb.group({
      'name': ['Dorji Gyeltshen', Validators.required],
      'age': [24, Validators.required, Validators.min(15)],
      'gender': ['Male', Validators.required],
      'email': ['dg.dorjigyeltshen@gmail.com', Validators.required],
      'bio': ['This is my Bio']
    });

    const coverPhotoHeight = 150.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dorji Gyeltshen'),
      ),
      body: ReactiveForm(
        formGroup: _formGroup,
        child: ListView(
          children: [
            const SizedBox(
              height: coverPhotoHeight * 1.5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CoverPhoto(
                    // url: '',
                    // url: 'https://rare-gallery.com/resol/2560x1440/343212-Tanjirou-Tanjiro-Kamado-Demon-Slayer-Kimetsu-no-Yaiba-Anime-Kimetsu-no-Yaiba-.jpg',
                      url: 'https://images6.alphacoders.com/126/1261894.jpg',
                      isEditable: true,
                      height: coverPhotoHeight
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    child: ProfilePhoto(
                      url: 'https://images6.alphacoders.com/126/1261894.jpg',
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
      ),
    );
  }
}