import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/cubit/states.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/modules/shop_app/onBoarding/on_boarding_screen.dart';

import 'package:shopapp/shared/bloc_observer.dart';

import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/style/themes.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login/cubit/cubit.dart';
import 'modules/shop_app/login/shopLogin_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  bool? onBoarding =CacheHelper.getData(key:'onBoarding');
  print(onBoarding);
  String? token = CacheHelper.getData(key:'token');
  print(token);
  bool? isDark = CacheHelper.getData(key:'isDark');
  print(isDark);
  if(onBoarding!=null){
    if(token!=null)
      widget=ShopLayout();
    else {
      widget = ShopLoginScreen();
      isDark=false;
    }
  }
  else{
    widget=onBoardingScreen();
    isDark=false;
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(isDark:isDark,
        startWidget:widget ,
      ));
    },
    blocObserver: MyBlocObserver(),
  );

}


class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget startWidget;
  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context)=>ShopLoginCubit()),
          BlocProvider(
              create:(context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()..changeShopMode(fromShared:isDark) ),
        ],
        child:BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme:lightTheme,
                darkTheme:darkTheme,
                themeMode: ShopCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
                home:startWidget);
          },

        )
    );

  }

}
