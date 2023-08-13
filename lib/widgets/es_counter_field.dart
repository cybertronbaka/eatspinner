import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EsCounterField<T> extends StatelessWidget {
  const EsCounterField(
      {Key? key,
        required this.formControlName,
        required this.labelText,
        this.readOnly = false,
        this.onPressedUp,
        this.onPressedDown,
        this.max,
        this.min
      })
      : super(key: key);
  final String formControlName;
  final String labelText;
  final bool readOnly;
  final VoidCallback? onPressedUp;
  final VoidCallback? onPressedDown;
  final int? max;
  final int? min;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 3, child: EsTextField(
              readOnly: readOnly,
              formControlName: formControlName,
              labelText: labelText,
            )),
            const SizedBox(width: 8),
            Expanded(
                flex: 1, child: ReactiveValueListenableBuilder(
                formControlName: formControlName,
                builder: (context, control, child){
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFC6C6C6)),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        min != null
                            ?  button(
                            control,
                            readOnly || ((min != null && control.value != null && (control.value! as int) <= min!)),
                            Icons.remove,
                            -1
                        ) : button(control, readOnly, Icons.remove, -1),
                        max != null
                            ?  button(
                          control,
                          readOnly || (max != null && control.value != null && (control.value! as int) >= max!),
                          Icons.add,
                          1,
                        ) : button(control, readOnly, Icons.add, 1),
                      ],
                    ),
                  );
                }
            )
            )
          ],
        )
    );
  }

  Widget button(AbstractControl control, bool disabled, IconData icon, int step){
    return InkWell(onTap: (){
      if(disabled) return;

      if(onPressedUp != null) onPressedUp!();

      control.updateValue(control.value + step);
    },
        child: Icon(icon, size: 20, color: disabled ? const Color(0xFFc6c6c6) : const Color(0xFF626262))
    );
  }
}
