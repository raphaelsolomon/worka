import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    required this.title,
    required this.title2,
  }) : super(key: key);
  final String title;
  final String title2;

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return _dropDown();
  }

  Widget _dropDown() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45.0,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              margin: const EdgeInsets.only(top: 5.0),
              child: FormBuilderDropdown(
                name: 'skill',
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  labelText: widget.title,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 9.9, vertical: 5.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color: const Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color: const Color(0xFF1B6DF9).withOpacity(.2)),
                  ),
                ),
                // initialValue: 'Male',
                hint: Text(
                  widget.title2,
                  style: const TextStyle(fontSize: 10, fontFamily: 'Lato'),
                ),

                items: ['boy', 'girl', 'man', 'woman']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
}
