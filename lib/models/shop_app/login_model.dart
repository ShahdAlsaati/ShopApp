class ShopLoginModel
{
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String,dynamic> json)
  {

  status=json['status'];
  message=json['message'];
  data=json['data']!=null? UserData.fromJson(json['data']):null ;

  }


}
class UserData{
  int? id;
  late String name;
  late String email;
  late String phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  // UserData({
  //   this.name,
  //   this.id,
  //   this.token,
  //   this.phone,
  //   this.image,
  //   this.email,
  //   this.credit,
  //   this.points,
  // });
  UserData.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    credit=json['credit'];
    points=json['points'];
    token=json['token'];


  }


}