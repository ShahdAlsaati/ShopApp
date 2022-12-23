import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/cubit/cubit.dart';
import 'package:shopapp/layout/shop_app/cubit/states.dart';
import 'package:shopapp/layout/shop_app/search/search_screen.dart';
import 'package:shopapp/shared/component/component.dart';
import '../../shared/style/colors.dart';

class ShopLayout extends StatefulWidget {

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder:(context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text( 'Salla',
              style: TextStyle(
              ),
            ),
            actions: [
              IconButton(onPressed:(){
                navigateTo(context, searchScreen());
              },
                  icon: Icon(
                Icons.search,
              )),
              IconButton(onPressed: (){
                ShopCubit.get(context).changeShopMode();
              },
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],

          ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 70.0,
            color:Theme.of(context).dialogBackgroundColor,
            buttonBackgroundColor:Theme.of(context).dialogBackgroundColor,
           backgroundColor:Theme.of(context).backgroundColor,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index){
              cubit.ChangeBotton(index);
            },
            items: <Widget>[
              Icon(Icons.home, size: 30,color:mshmshColor ,),
              Icon(Icons.apps, size: 30,color:mshmshColor ,),
              Icon(Icons.favorite, size: 30,color:mshmshColor,),
              Icon(Icons.settings, size: 30,color:mshmshColor ,),
            ],

            //currentIndex: cubit.currentIndex,

          ),

        );
      },

    );
  }
}
