import '../../modules/shop_app/login/shopLogin_screen.dart';
import '../network/local/cache_helper.dart';
import 'component.dart';

void SignOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value==true)
      navigateAndFinish(context, ShopLoginScreen());
  });
}

void printFullText(String text)
{
  final pattern=RegExp('.{1,800');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
String token='';