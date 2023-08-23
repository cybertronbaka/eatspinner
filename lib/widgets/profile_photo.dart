import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePhoto extends StatelessWidget{
  final String? url;
  final bool isEditable;
  final bool hasBorder;
  final double diameter;
  final void Function(XFile image)? onPick;
  const ProfilePhoto({
    super.key,
    required this.url,
    this.isEditable = false,
    this.hasBorder = false,
    this.diameter = 150,
    this.onPick
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
          url!,
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
        onTap: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
          if(image == null) return;
          if(onPick != null) onPick!(image);
        },
        icon: const Icon(Icons.camera_alt_outlined)
    );
  }

  Widget emptyProfilePhoto(){
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        shape: BoxShape.circle,
        border: hasBorder ? Border.all(color: Colors.white, width: 2) : null
      ),
      height: diameter,
      width: diameter,
    );
  }
}