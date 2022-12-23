import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/cubit/cubit.dart';
import 'package:shopapp/layout/shop_app/cubit/states.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constance.dart';

class SettingsScreen extends StatelessWidget {

var formKey=GlobalKey<FormState>();

Widget build(BuildContext context){
  var nameController=TextEditingController();

  var emailController=TextEditingController();

  var phoneController=TextEditingController();
  return BlocConsumer<ShopCubit,ShopStates>(
    listener:(context,state){},
    builder:(context,state){
      var model=ShopCubit.get(context).userModel;
      nameController.text=model!.data!.name;
      emailController.text=model.data!.email;
      phoneController.text=model.data!.phone;
      return model==null?Center(child: CircularProgressIndicator(),):ConditionalBuilder(
        condition: ShopCubit.get(context).userModel!=null,
        builder:(context)=> Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserDataState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),

                  profileImage(context),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    context,
                    label: 'Name',
                    type:TextInputType.text ,
                    prefix: Icons.person,
                    controller: nameController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    context,
                    controller:emailController,
                    label:'Email',
                    prefix:Icons.email,
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height:20,
                  ),
                  defaultFormField(
                    context,

                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Phone cannot be empty';
                      }
                      return null;
                    },
                    controller:phoneController,
                    label:'Phone',
                    prefix:Icons.phone,
                    type: TextInputType.phone,


                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                  context,
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }

                    },

                    text: 'UPDATE',
                    isUppercase:true,

                  ),

                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    context,
                    onPressed: () {
                      SignOut(context);
                      ShopCubit.get(context).changeShopMode(fromShared:false) ;

                    },
                    text: 'LOGOUT',
                    isUppercase:true,
                  ),

                ],
              ),
            ),
          ),
        ),
        fallback:(context)=> Center(child: CircularProgressIndicator()) ,


      );
    },
  );

}
}



  //bool isPassword=true;
