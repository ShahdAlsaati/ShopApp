import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/cubit/cubit.dart';
import 'package:shopapp/layout/shop_app/cubit/states.dart';
import 'package:shopapp/models/shop_app/Categories_Model.dart';
import 'package:shopapp/models/shop_app/Home_model.dart';

class productsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>
      (listener:(context,state){
        if(state is ShopSuccesChangeFavoriteState)
          {
            if(state.model.status==false)
              print(state.model.message);

          }
    },
      builder:(context,state)
      {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition:ShopCubit.get(context).homeModel!=null&&CategoriesModel!=null ,
          builder:(context)=>productsBuilder(cubit.homeModel,cubit.categoriesModel,context) ,
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },
    );

  }
  Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          CarouselSlider(
            items: model!.data!.banners.map((e) => Image.network(
              '${e.image}',
              width: double.infinity,
              fit: BoxFit.cover,
            ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval:Duration(seconds: 3) ,
              autoPlayAnimationDuration:Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,


            ),
          ),
          SizedBox(
            height:10,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height:10,
              ),
              Container(
                color: Theme.of(context).backgroundColor,
                height: 100,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection:Axis.horizontal ,
                    itemBuilder: (context,index)=>buildCategoriesItems(categoriesModel!.data!.data[index],context),
                    separatorBuilder: (context,index)=>SizedBox(
                      width: 10,
                    ),
                    itemCount: categoriesModel!.data!.data.length),
              ),
              SizedBox(
                height:20,
              ),
              Text(
                'New Products',
                style: Theme.of(context).textTheme.headline5,

              ),
            ],
          ),
        ),

        SizedBox(
          height:10,
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          child: GridView.count(
            shrinkWrap: true,
            physics:NeverScrollableScrollPhysics() ,
            crossAxisCount: 2,
           mainAxisSpacing: 1,
           crossAxisSpacing: 1,
           childAspectRatio: 1/1.58,
           children: List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index],context)
           )
          ),
        ),
      ],
    ),
  );
  Widget buildCategoriesItems(DataModel model,context)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(

        color: Colors.black.withOpacity(0.6),
        width: 100,
        child: Text(
         '${ model.name}',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );



  Widget buildGridProduct(ProductsModel model, context)=>Container(

    color: Colors.white ,
    child: Container(
      color: Theme.of(context).backgroundColor,


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image:NetworkImage(model.image),
                width: double.infinity,
                height: 200,

              ),
              if(model.discount!=0)
              Container(
                color: Colors.red,
               padding: EdgeInsets.symmetric(horizontal:5 ),
               child: Text(
                 'DISCOUNT',
                 style: TextStyle(
                   fontSize: 10,
                   color: Colors.white,
                 ),
               ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
               model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.button,

            ),

          ),
          Row(
            children: [
              Text(
                '${model.price.round()}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,

              ),
              SizedBox(
                width: 5,
              ),
              if(model.discount!=0)
                Text(
                  '${model.old_price.round()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.overline,


                ),
              Spacer(),


              IconButton(
                  onPressed:(){
                    ShopCubit.get(context).ChangeFavorites(model.id);
                    print(model.id);
                  },
                  icon:CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context).favorite[model.id]==true?Colors.deepOrange:Colors.grey,
                    child: Icon (Icons.favorite_border,
                      size:  14,
                      color: Colors.white,
                    ),
                  )),

            ],
          ),

        ],
      ),
    ),
  );
}
