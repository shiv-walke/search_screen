
class GtsModel{
  final String page;
  final String text;
  final String chapterName;
  final List<String> type;

    GtsModel(
      this.page,
      this.text,
      this.chapterName,
      this.type,

      );

   factory GtsModel.fromJson(Map <String, dynamic> json){
      return GtsModel(
          json['page'] ,
          json['text'] ,
          json['chapterName'] ,
          json['type'] != null ? json['type'].cast<String>() : []
     );

   }
 }