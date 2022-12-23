class ChangeFavoratieModel{
  bool ?status;
  String ?message;
  ChangeFavoratieModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}