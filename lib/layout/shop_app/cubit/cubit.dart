import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/Products/prodect_screen.dart';
import 'package:shopapp/layout/shop_app/categories/catigories_screen.dart';
import 'package:shopapp/layout/shop_app/cubit/states.dart';
import 'package:shopapp/layout/shop_app/favorite/favorite_screen.dart';
import 'package:shopapp/models/shop_app/Home_model.dart';
import 'package:shopapp/modules/settings_screen/settings_screen.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import '../../../models/shop_app/Add_Favorite_Model.dart';
import '../../../models/shop_app/Categories_Model.dart';
import '../../../models/shop_app/Favorite.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../shared/component/constance.dart';
import '../../../shared/network/end_poits.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

   static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> bottomScreens=[
    productsScreen(),
    catigoriesScreen(),
    favoriteScreen(),
    SettingsScreen(),
  ];
  void ChangeBotton(int index)
  {
    currentIndex=index;
    emit(ShopChangeButtonNavState());
  }

  HomeModel? homeModel;
  Map<int,bool> favorite={};

   void getHomeData(){

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME,
      token:CacheHelper.getData(key:'token'),
    ).then((value){

      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id: element.in_favorites,
        });
      });
     // print(favorite.toString());
      emit(ShopSuccesHomeDataState());

    }).catchError((error){
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErorrHomeDataState(error.toString()));
    });
}
  CategoriesModel? categoriesModel;

  void getCategories(){


    DioHelper.getData(url: CATEGORIES,

    ).then((value){

      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccesCategoriesState());
    }).catchError((error){
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErorrCategoriesState());
    });
  }

  ChangeFavoratieModel? changefavoratieModel;


  void ChangeFavorites(int productID){
    favorite[productID]=!favorite[productID]!;

    emit(ShopChangeFavoriteState());

    DioHelper.postData(
        url: FAVOURITE,
        data: {
          'product_id':productID},
      token: CacheHelper.getData(key:'token'),

    )
        .then((value) {
          print(CacheHelper.getData(key:'token'));
      print(favorite.toString());

      changefavoratieModel=ChangeFavoratieModel.fromJson(value.data);
      if(changefavoratieModel!.status==false)
        favorite[productID]=!favorite[productID]!;
      else getFavorites();


          print(value.data);
          emit(ShopSuccesChangeFavoriteState(changefavoratieModel!));
    })
        .catchError((error){
      favorite[productID]=!favorite[productID]!;
          emit(ShopErorrChangeFavoriteState());
    });

  }

   FavoritesModel? favoritesModel;

  void getFavorites(){
       emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: FAVOURITE,
      token: CacheHelper.getData(key:'token'),


    ).then((value){

      favoritesModel=FavoritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccesGetFavoritesState());
    }).catchError((error){
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErorrGetFavoritesState());
    });
  }
  late ShopLoginModel ?userModel;

  void getUserData(){
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: SETTING,
      token: CacheHelper.getData(key:'token'),


    ).then((value){

      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccesUserDataState(userModel!));
    }).catchError((error){
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErorrUserDataState());
    });
  }

  void updateUserData({
  required String name,
    required String email,
    required String phone,

}){
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(url:update_profile ,
      token: CacheHelper.getData(key:'token'),
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },


    ).then((value){

      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccesUpdateUserDataState(userModel!));
    }).catchError((error){
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErorrUserDataState());
    });
  }
  bool isDark=false;
  void changeShopMode({bool? fromShared}){
    if(fromShared!=null){
      isDark=fromShared;
      emit(ShopChangeModeState());}
    else{
      isDark=!isDark;
      CacheHelper.putBool(key:'isDark' ,value:isDark ).then((value)
      {
        emit(ShopChangeModeState());
      }
      );
    }
  }
}