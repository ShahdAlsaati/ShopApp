import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/end_poits.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;
  
  void userLogin({
    required String email,
    required String password,
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,

      data:{
        'email':email,
        'password':password,
      },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(loginModel?.data?.token);
      // print(loginModel?.message);
      // print(loginModel?.Status);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  bool isPasswordShow= true;

  IconData  suffix= Icons.visibility_outlined;
  void changePPasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix=isPasswordShow? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ShopChangePasswordvisibilityState());
  }
}