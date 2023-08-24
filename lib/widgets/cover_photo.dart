import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class CoverPhoto extends StatelessWidget{
  final String? url;
  final bool isEditable;
  final double height;
  final void Function(XFile image)? onPick;
  const CoverPhoto({
    super.key,
    required this.url,
    this.isEditable = false,
    this.height = 150,
    this.onPick
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
        onTap: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
          if(image == null) return;
          if(onPick != null) onPick!(image);
        },
        icon: const Icon(Icons.camera_alt_outlined)
    );
  }
}