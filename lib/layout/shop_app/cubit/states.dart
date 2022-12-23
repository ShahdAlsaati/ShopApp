import 'package:shopapp/modules/shop_app/login/cubit/cubit.dart';

import '../../../models/shop_app/Add_Favorite_Model.dart';
import '../../../models/shop_app/login_model.dart';

abstract class ShopStates{}


class ShopInitialState extends ShopStates{

}
class ShopChangeButtonNavState extends ShopStates{

}

class ShopLoadingHomeDataState extends ShopStates{

}
class ShopSuccesHomeDataState extends ShopStates{

}
class ShopErorrHomeDataState extends ShopStates{
  final String error;
  ShopErorrHomeDataState(this.error){
    print(this.error);}
}

class ShopSuccesCategoriesState extends ShopStates{

}
class ShopErorrCategoriesState extends ShopStates {
}
class ShopChangeFavoriteState extends ShopStates{

}
class ShopSuccesChangeFavoriteState extends ShopStates{
late final ChangeFavoratieModel model;
ShopSuccesChangeFavoriteState(this.model);
}
class ShopErorrChangeFavoriteState extends ShopStates {
}
class ShopLoadingGetFavoritesState extends ShopStates{

}
class ShopSuccesGetFavoritesState extends ShopStates{

}
class ShopErorrGetFavoritesState extends ShopStates {
}
class ShopLoadingUserDataState extends ShopStates{


}
class ShopSuccesUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccesUserDataState(this.loginModel);
}
class ShopErorrUserDataState extends ShopStates {
}
class ShopLoadingUpdateUserDataState extends ShopStates{


}
class ShopSuccesUpdateUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccesUpdateUserDataState(this.loginModel);
}
class ShopErorrUserUpdateDataState extends ShopStates {
}
class ShopChangeModeState extends ShopStates{}