import 'package:flutter/material.dart';
import 'package:notary_agent_app/utils/util_funcs.dart';

class DropDown extends StatefulWidget {
  final String label;
  final double? width;
  final List itemList;
  final Color? labelColor;
  const DropDown(
      {Key? key,
      this.label = "Select",
      this.width,
      required this.itemList,
      this.labelColor})
      : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? type;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.label}",
          style: TextStyle(
            color: widget.labelColor ?? const Color(0xFF172331),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        sbh(15),
        Container(
          padding: EdgeInsets.all(8),
          height: 50,
          width: widget.width ?? MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            underline: Container(
              padding: EdgeInsets.all(16),
              height: 0,
              width: widget.width ?? MediaQuery.of(context).size.width - 20,
            ),
            hint: Text(
              widget.label,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            isExpanded: true,
            // value: type,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
            ),
            elevation: 16,

            alignment: Alignment.centerLeft,
            style: const TextStyle(color: Colors.black),
            value: type,
            onChanged: (String? newValue) async {
              type = newValue!;
              print('id' + type.toString());
              if (type != null) {}
              setState(() {});
            },
            items: widget.itemList.map((e) {
              return DropdownMenuItem<String>(
                value: e['id'],
                child: Text(e['name']!),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
