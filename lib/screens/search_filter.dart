import 'package:flutter/material.dart';

import '../model/gts_type_model.dart';

class SearchFilter extends StatefulWidget {
  final List<GtsTypeModel> typeList;
  const SearchFilter(this.typeList, {Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  bool contentCheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.typeList.length,
          itemBuilder: (context, index) => Card(
            color: Colors.white54,
            child: CheckboxListTile(
              title: Text(widget.typeList[index].name),
              value: widget.typeList[index].selected,
              autofocus: false,
              controlAffinity: ListTileControlAffinity.platform,
              onChanged: (bool? value) {
                //debugPrint("Hello: $value");
                debugPrint('typeList: ${widget.typeList.toString()}');
                setState(() {
                  widget.typeList[index].selected = value!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
