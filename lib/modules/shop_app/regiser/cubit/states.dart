import 'package:bloc/bloc.dart';

import '../../../../models/shop_app/login_model.dart';

abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{

}
class ShopRegisterLoadingState extends ShopRegisterState{

}
class ShopRegisterSuccessState extends ShopRegisterState{
  late final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);

}
class ShopRegisterErrorState extends ShopRegisterState{
 final String error;

  ShopRegisterErrorState( this.error);
 }

class ShopRegisterChangePasswordvisibilityState extends ShopRegisterState{

}