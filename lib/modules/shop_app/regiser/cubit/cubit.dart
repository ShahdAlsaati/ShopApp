import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/regiser/cubit/states.dart';
import 'package:shopapp/shared/network/end_poits.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;
  
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,

      data:{
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      // print(loginModel?.data?.token);
      // print(loginModel?.message);
      // print(loginModel?.Status);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  bool isPasswordShow= true;

  IconData  suffix= Icons.visibility_outlined;
  void changePPasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix=isPasswordShow? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordvisibilityState());
  }
}