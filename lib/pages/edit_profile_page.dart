import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shimmer/shimmer.dart';


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

class ProfilePhoto extends StatelessWidget{
  final String? url;
  final bool isEditable;
  final bool hasBorder;
  final double diameter;
  const ProfilePhoto({
    super.key,
    required this.url,
    this.isEditable = false,
    this.hasBorder = false,
    this.diameter = 150
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        url != null && url!.isNotEmpty ? networkImage() : emptyProfilePhoto(),
        if(isEditable) Positioned(
          bottom: 20,
          right: 0,
          child: cameraButton(),
        )
      ],
    );
  }

  Widget networkImage(){
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: hasBorder ? Border.all(color: Colors.white, width: 2) : null
      ),
      child: ClipOval(
        child: Image.network(
          'https://images6.alphacoders.com/126/1261894.jpg',
          width: hasBorder ? diameter - 4 : diameter,
          height: hasBorder ? diameter - 4 : diameter,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress){
            if (loadingProgress == null) return child;

            return Shimmer.fromColors(
              baseColor: const Color(0xFFD2D2D2),
              highlightColor: const Color(0xFFE5E5E5),
              child: emptyProfilePhoto(),
            );
          },
          errorBuilder: (context, error, stackTrace){
            return emptyProfilePhoto();
          },
        ),
      ),
    );
  }

  Widget cameraButton() {
    return EsCircularIconButton(
        onTap: (){},
        icon: const Icon(Icons.camera_alt_outlined)
    );
  }

  Widget emptyProfilePhoto(){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: hasBorder ? Border.all(color: Colors.white, width: 2) : null
      ),
      height: diameter,
      width: diameter,
    );
  }
}

class CoverPhoto extends StatelessWidget{
  final String? url;
  final bool isEditable;
  final double height;
  const CoverPhoto({
    super.key,
    required this.url,
    this.isEditable = false,
    this.height = 150
  });

  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        if (url != null && url!.isNotEmpty)
          networkImage(fullWidth)
        else
          emptyCoverPhoto(fullWidth),
        if(isEditable) Positioned(
          bottom: 10,
          right: 20,
          child: cameraButton(),
        )
      ],
    );
  }

  Widget networkImage(double fullWidth){
    return Image.network(
      url!,
      fit: BoxFit.cover,
      height: height,
      width: fullWidth,
      loadingBuilder: (context, child, loadingProgress){
        if (loadingProgress == null) return child;

        return Shimmer.fromColors(
          baseColor: const Color(0xFFD2D2D2),
          highlightColor: const Color(0xFFE5E5E5),
          child: emptyCoverPhoto(fullWidth),
        );
      },
      errorBuilder: (context, error, stackTrace){
        return emptyCoverPhoto(fullWidth);
      },
    );
  }

  Widget emptyCoverPhoto(double fullWidth) {
    return Container(
      color: const Color(0xFFD9D9D9),
      width: fullWidth,
      height: height
    );
  }

  Widget cameraButton() {
    return EsCircularIconButton(
        onTap: (){},
        icon: const Icon(Icons.camera_alt_outlined)
    );
  }
}

class EsCircularIconButton extends StatelessWidget{
  final Color backgroundColor;
  final Widget icon;
  final void Function() onTap;
  const EsCircularIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(200),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: icon,
          ),
        ),
      ),
    );
  }
}