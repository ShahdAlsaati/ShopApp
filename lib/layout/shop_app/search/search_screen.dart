import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/search/cubit/cubit.dart';
import 'package:shopapp/layout/shop_app/search/cubit/state.dart';
import '../../../shared/component/component.dart';

class searchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var searchController=TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),

      child: BlocConsumer<SearchCubit,SearchState>(
        listener: ( context, state) {  },
        builder: ( context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(              // backgroundColor:Color(0xFFFFDEBD),

              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          context,
                        controller: searchController ,
                        type: TextInputType.text,
                        label:'Search',
                        prefix: Icons.search,

                        validator: (value) {
                          if(value!.isEmpty){

                            return 'please enter text';
                          }
                          else{
                            print(value);
                          }
                          return null;
                        },
                     onSubmit: (String text){
                          SearchCubit.get(context).search(text);
                     }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      if(state is SearchSucssesState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index)=>buildListProduct(SearchCubit.get(context).searchModel!.data.data[index],context,isOldPrice:false),
                          separatorBuilder:(context,index)=>myDivider(),
                          itemCount:SearchCubit.get(context).searchModel!.data.data.length,

                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );

  }
}
