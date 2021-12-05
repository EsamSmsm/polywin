import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    Key key,
    this.itemsList,
    this.onChanged,
    this.hint,
    this.value,
  }) : super(key: key);

  final List itemsList;
  final Function onChanged;
  final String hint;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 48,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButton(
          underline: SizedBox(),
          isExpanded: true,
          onChanged: onChanged,
          items: itemsList,
          hint: Text(hint),
          value: value,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffc8c8c8)),
        color: Color(0xfffcfcfc),
      ),
    );
  }
}
