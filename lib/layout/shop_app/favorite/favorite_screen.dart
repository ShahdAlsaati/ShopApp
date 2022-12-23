import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/Favorite.dart';
import '../../../shared/component/component.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class favoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){

      },

      builder:(context,state)=>ConditionalBuilder(
        condition: state is ! ShopLoadingGetFavoritesState && (ShopCubit.get(context).favoritesModel!.data!)!=null,
        builder: (context)=>ListView.separated(
          itemBuilder: (context,index)=>buildListProduct(ShopCubit.get(context).favoritesModel?.data?.data[index].product,context),
          separatorBuilder:(context,index)=>myDivider(),
          itemCount:ShopCubit.get(context).favoritesModel!.data!.data.length,

        ),
        fallback:(context)=>Center(child: CircularProgressIndicator())

      ),
    );



  }
}