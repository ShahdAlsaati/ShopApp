import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/modules/shop_app/login/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/modules/shop_app/regiser/Shop_Register_sceen.dart';
import 'package:shopapp/shared/component/component.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/style/colors.dart';

import '../../../shared/component/constance.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();

    return BlocConsumer<ShopLoginCubit,ShopLoginState>(
      listener: (context,state) {
           if(state is ShopLoginSuccessState){
             if(state.loginModel.status==true){
               print(state.loginModel.status);
               print(state.loginModel.data?.token);
               print(state.loginModel.message);
               CacheHelper.saveData(key:' ',
                   value: state.loginModel.data!.token
               ).then((value){
                 token=state.loginModel.data!.token.toString();

                 print(state.loginModel.data?.token);
                 navigateAndFinish(context, ShopLayout());

               });


             }
             else{
               print(state.loginModel.message);
             }

           }
      },
      builder: (context, state) {
        bool? isDark = CacheHelper.getData(key:'isDark');

        var cubit = ShopLoginCubit.get(context);
        return Scaffold(
           body:SingleChildScrollView(
             child: Container(
               height: 1000,
               width: double.infinity,
               decoration: BoxDecoration(
                   gradient: LinearGradient(
                       begin: Alignment.topCenter,
                       colors: [
                         Colors.orange,
                         Colors.orangeAccent,
                         Colors.deepOrangeAccent,
                         Colors.deepOrange,

                       ]
                   )
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   SizedBox(height: 100,),
                   Padding(padding: EdgeInsets.all(20),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text(
                           'LOGIN',
                           style: TextStyle(
                             fontSize: 40,
                             fontWeight: FontWeight.bold,
                             color: Colors.white,

                           ),
                         ),
                     SizedBox (
                       height:15,
                     ),
                         Text(
                           'Login now to browse our hot offers',
                           style:Theme.of(context).textTheme.bodyText1?.copyWith(
                             color:Colors.grey,
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox (
                     height:20,
                   ),
                   Center(
                     child: Container(
                       // color: Colors.white,
                       height: 450,
                       width: 350,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),bottomLeft:Radius.circular(40),bottomRight: Radius.circular(40), ),
                       ),
                       child: Form(
                         key: formKey,
                         child: Center(
                           child: Padding(
                             padding: const EdgeInsets.all(20.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [

                                 SizedBox(
                                   height:70,
                                 ),
                                 Container(

                                   child: defaultFormField(
                                     context,
                                     controller: emailController ,
                                     type: TextInputType.emailAddress,
                                     label:'Email',
                                     prefix: Icons.email,
                                     //   onChanged(){
                                     // print(v);
                                     // },
                                     validator: (value) {
                                       if(value!.isEmpty){

                                         return 'Email cannot be empty';
                                       }
                                       else{
                                         print(value);
                                       }
                                       return null;
                                     },
                                     onfiled: (value) {
                                       print(value);
                                     },

                                   ),
                                   decoration: BoxDecoration(
                                       boxShadow: [
                                         BoxShadow(
                                           color:  mshmshColor.withOpacity(0.5),
                                           blurRadius: 40,
                                           offset: const Offset(10, 35),
                                         )
                                       ],
                                    border:Border(
                                      top: BorderSide(
                                        color:  mshmshColor.withOpacity(0.5),
                                      ),

                                      ) ,

                                   ),
                                 ),
                                 // SizedBox(
                                 //   height:30,
                                 // ),
                                 Container(
                                   child: defaultFormField(
                                     context,
                                     controller: passwordController ,
                                     type: TextInputType.visiblePassword,
                                     label:'password',
                                     isPassword:ShopLoginCubit.get(context).isPasswordShow,

                                     prefix: Icons.lock_outline,
                                     suffix:ShopLoginCubit.get(context).suffix,
                                     validator: (value) {
                                       if(value!.isEmpty){

                                         return 'Password cannot be empty';
                                       }
                                       else{
                                         print(value);
                                       }
                                       return null;
                                     },
                                     suffixpressed:(){
                                       ShopLoginCubit.get(context).changePPasswordVisibility();
                                     },
                                     onfiled: (value) {
                                       print(value);
                                     },

                                     onSubmit: (value){
                                       if(formKey.currentState!.validate()){
                                         ShopLoginCubit.get(context).userLogin(
                                             email: emailController.text,
                                             password: passwordController.text);
                                       }},

                                   ),
                                   decoration: BoxDecoration(
                                       border:Border(
                                         bottom: BorderSide(
                                           color:  mshmshColor,
                                         ),
                                       ) ,
                                       boxShadow: [
                                         BoxShadow(
                                           color:  mshmshColor.withOpacity(0.5),
                                           blurRadius: 40,
                                           offset: const Offset(10, 35),
                                         )
                                       ]
                                   ),

                                 ),
                                 SizedBox(
                                   height:30,
                                 ),
                                 (state is !ShopLoginLoadingState)?(defaultButton(
                                   context,
                                   onPressed: () {
                                     if(formKey.currentState!.validate()){
                                       cubit.userLogin(
                                           email: emailController.text,
                                           password: passwordController.text);

                                     }

                                   },
                                   text: 'LOGIN',
                                   isUppercase:true,

                                 )

                                 ):Center(child: CircularProgressIndicator()),
                                 SizedBox(
                                   height:15,),
                                 Row(
                                   mainAxisAlignment:MainAxisAlignment.center ,
                                   children: [
                                     Text(
                                         'don\'t have an account ?',
                                       style: TextStyle(
                                         color: Colors.black
                                       ),
                                     ),
                                     defaultTextButton(

                                       function: (){
                                         navigateTo(context,
                                           RegisterScreen(),);
                                       },
                                       text: 'Register',),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),

                 ],
               ),

             ),
           ),


        );
      },


    );
  }
}
