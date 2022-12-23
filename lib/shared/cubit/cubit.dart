import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/states.dart';
import '../../modules/shop_app/login/shopLogin_screen.dart';
import '../network/local/cache_helper.dart';

class AppCubite extends Cubit<AppStates>
{
  AppCubite(): super(AppInitianlState());

  static AppCubite get (context)=>BlocProvider.of(context);

  bool isDark=false;
  void changeAppMode({bool? fromShared}){
    if(ShopLoginScreen()==true)
      {
        isDark=false;
      }
      if(fromShared!=null){
        isDark=fromShared;
        emit(AppChangeModeState());}
      else{
    isDark=!isDark;
    CacheHelper.putBool(key:'isDark' ,value:isDark ).then((value)
    {
      emit(AppChangeModeState());
    }
    );
      }
  }

}