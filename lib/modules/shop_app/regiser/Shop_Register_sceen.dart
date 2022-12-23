import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constance.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/style/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child:BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
         listener:(context, state){
           if(state is ShopRegisterSuccessState){
             if(state.loginModel.status==true){
               print(state.loginModel.status);
               print(state.loginModel.data?.token);
               print(state.loginModel.message);
               CacheHelper.saveData(key:'token',
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
            var cubit = ShopRegisterCubit.get(context);
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
                    children: [
                      SizedBox(height: 100,),
                      Padding(padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'REGISTER',
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
                              'Register now to browse our hot offers',
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
                        child: SingleChildScrollView(
                          child: Container(
                            // color: Colors.white,
                            height: 600,
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
                                        decoration: BoxDecoration(
                                            border:Border(
                                              top: BorderSide(
                                                color:  mshmshColor.withOpacity(0.5),
                                              ),
                                            ) ,

                                            boxShadow: [
                                              BoxShadow(
                                                color:  mshmshColor.withOpacity(0.5),
                                                blurRadius: 50,
                                                offset: const Offset(5, 25),
                                              )
                                            ]
                                        ),

                                        child: defaultFormField(
                                          context,
                                          controller: nameController ,
                                          type: TextInputType.name,
                                          label:'Name',
                                          prefix: Icons.person,

                                          validator: (value) {
                                            if(value!.isEmpty){
                                              return 'Please enter your name';
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
                                      ),
                                      SizedBox(
                                        height:30,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border:Border(
                                              top: BorderSide(
                                                color:  mshmshColor.withOpacity(0.5),
                                              ),
                                            ) ,

                                            boxShadow: [
                                              BoxShadow(
                                                color:  mshmshColor.withOpacity(0.5),
                                                blurRadius: 50,
                                                offset: const Offset(5, 25),
                                              )
                                            ]
                                        ),

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
                                      ),
                                      SizedBox(
                                        height:30,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                            border:Border(
                                              top: BorderSide(
                                                color:  mshmshColor.withOpacity(0.5),
                                              ),
                                            ) ,

                                            boxShadow: [
                                              BoxShadow(
                                                color:  mshmshColor.withOpacity(0.5),
                                                blurRadius: 50,
                                                offset: const Offset(5, 25),
                                              )
                                            ]
                                        ),

                                        child: defaultFormField(
                                          context,
                                          controller: passwordController ,
                                          type: TextInputType.visiblePassword,
                                          label:'password',
                                          isPassword:ShopRegisterCubit.get(context).isPasswordShow,

                                          prefix: Icons.lock_outline,
                                          suffix:ShopRegisterCubit.get(context).suffix,
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
                                            ShopRegisterCubit.get(context).changePPasswordVisibility();
                                          },
                                          onfiled: (value) {
                                            print(value);
                                          },

                                          onSubmit: (value){
                                            if(formKey.currentState!.validate()){
                                              ShopRegisterCubit.get(context).userRegister(
                                                  email: emailController.text,
                                                  password: passwordController.text,
                                                  phone: phoneController.text,
                                                  name:nameController.text);
                                            }},

                                        ),
                                      ),
                                      SizedBox(
                                        height:30,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border:Border(
                                              top: BorderSide(
                                                color:  mshmshColor.withOpacity(0.5),
                                              ),
                                            ) ,

                                            boxShadow: [
                                              BoxShadow(
                                                color:  mshmshColor.withOpacity(0.5),
                                                blurRadius: 50,
                                                offset: const Offset(5, 25),
                                              )
                                            ]
                                        ),

                                        child: defaultFormField(
                                          context,
                                          controller: phoneController ,
                                          type: TextInputType.phone,
                                          label:'Phone',
                                          prefix: Icons.phone,

                                          validator: (value) {
                                            if(value!.isEmpty){
                                              return 'Please enter your phone';
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
                                      ),

                                      SizedBox(
                                        height:30,
                                      ),
                                      ConditionalBuilder(
                                          condition: state is ! ShopRegisterLoadingState,
                                          builder:(context)=>defaultButton(
                                            context,
                                            onPressed: () {
                                              if(formKey.currentState!.validate()){
                                                cubit.userRegister(
                                                phone:phoneController.text ,
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    password: passwordController.text);

                                              }

                                            },
                                            text: 'REGISTER',
                                            isUppercase:true,

                                          ),
                                        fallback: (context)=>Center(child: CircularProgressIndicator()),),

                                      SizedBox(
                                        height:15,),

                                    ],
                                  ),
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


        )
    );}
  }

