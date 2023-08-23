import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shimmer/shimmer.dart';

class EsDropdownField<T> extends StatelessWidget{
  final String formControlName;
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  const EsDropdownField({
    super.key,
    required this.formControlName,
    required this.items,
    this.labelText = '',
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField<T>(
      formControlName: formControlName,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items
    );
  }
}

class EsDropdownFieldShimmer extends StatelessWidget {
  const EsDropdownFieldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color(0xFFD2D2D2),
        highlightColor: const Color(0xFFE5E5E5),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        )
    );
  }
}