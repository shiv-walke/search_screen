import 'package:flutter/material.dart';

import '../model/gts_type_model.dart';

class SearchFilter extends StatefulWidget {
  final Function onSubmit;
  final List<GtsTypeModel> typeList;
  const SearchFilter(this.typeList, {Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  bool contentCheck = true;
  List selectedType = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
              ),
             // const SizedBox(width: 50.0,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: (){
                      widget.onSubmit();
                      Navigator.pop(context);
                      // if(widget.typeList.selectedType()){
                      //   print("You selects type");
                      // }else{
                      //   print("Types are not selected");
                      // }
                    },
                    child: const Text("Submit")),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
