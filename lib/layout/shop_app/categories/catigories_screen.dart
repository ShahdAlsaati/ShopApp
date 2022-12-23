import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/cubit/cubit.dart';
import 'package:shopapp/models/shop_app/Categories_Model.dart';
import 'package:shopapp/shared/component/component.dart';
import '../cubit/states.dart';

class catigoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){

    },

      builder:(context,state)=>ListView.separated(
          itemBuilder: (context,index)=>buildcategoryItem(ShopCubit.get(context).categoriesModel!.data!.data[index],context),
          separatorBuilder:(context,index)=>myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length),

    );


  }
  Widget buildcategoryItem(DataModel model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: Theme.of(context).textTheme.bodyText1,

        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios,
        color: Theme.of(context).iconTheme.color,),
      ],
    ),
  );
}