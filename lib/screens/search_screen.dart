import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_screen/screens/search_filter.dart';
import '../model/gts_model.dart';
import '../model/gts_type_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<GtsModel>> _loadGTSData() async {
    final gtsJson = await rootBundle.loadString('assets/gts.json');

    final gtsData = jsonDecode(gtsJson) as List<dynamic>;

    return gtsData.map((e) => GtsModel.fromJson(e)).toList();
  }

  String searchText = '';

  List<GtsModel> _allEntries = [];

  List<GtsTypeModel> typeList = [];
  List<String> typeListString = [];
  List<String> typeFilterList = [];

  @override
  initState() {
    _loadGTSData().then((value) {
      for (var model in value) {
        for (var type in model.type) {
          if (!typeListString.contains(type)) {
            typeListString.add(type);
            typeList.add(GtsTypeModel(type));
          }
        }
      }

      //debugPrint('typeList: $typeList');

      setState(() {
        _allEntries = value;
      });
    });

    super.initState();
  }

  bool valueCheck = true;

  bool isSearchEntryAllowed(GtsModel model){
    if (model.text.toLowerCase().contains(searchText)){
      if(model.type.contains(valueCheck)){

      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
   // debugPrint("hello");
    debugPrint(typeList.toString());
    debugPrint(typeList.toString());


    var filteredItems = _allEntries.where((element) {
      return element.text.toLowerCase().contains(searchText);
    }).toList();

    var filteredTypeItems = _allEntries.where((element) {
      return element.type.contains(typeList);
    });

   debugPrint("filteredTypeItems : $filteredTypeItems");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                        ),
                        elevation: 16,
                        child:  SearchFilter(typeList, onSubmit: () {
                          setState(() {});
                        },),
                      );
                    });
              },
              icon: const Icon(
                Icons.filter_list_rounded,
                color: Colors.black,
              )),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Row(
            children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            suffixIcon: Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),

                          ),

                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("cancel"),
                ),
              ]
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(filteredItems[index].type),
                        color: Colors.white54,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(filteredItems[index].page),
                          subtitle: Text(filteredItems[index].chapterName),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
