import 'package:flutter/material.dart';
import '../../layout/shop_app/cubit/cubit.dart';

Widget defaultTextButton({
  required Function? function,
  required String text,

})=> TextButton(

  onPressed:(){
    function!();
  },
  child: Text(
      text.toUpperCase(),
    style: TextStyle(
      color: Colors.deepOrange,
    ),

  ),

);

Widget defaultButton(context,{

   double width=double.infinity,
   Color background=Colors.deepOrange,
  bool isUppercase=true,
  double radius =10.0,
  required VoidCallback? onPressed,
  required String? text,

  })=>Container(
  height: 40,
  width: width,
  child: MaterialButton(
    onPressed: onPressed,

    child: Text(
        isUppercase? text!.toUpperCase():text!,
      style: Theme.of(context).textTheme.bodyText2,
    ),
  ),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,

      ),
    color: Theme.of(context).iconTheme.color,
  ),


);

Widget defaultFormField( context, {
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator<String>? validator,

  bool isPassword = false,
  Function? onSubmit,
  //Function? onChange,
  //Function? onTap,

  required String label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixpressed,
   bool isClickable=true,
  Function? onfiled,

})=> TextFormField(
  cursorColor:Theme.of(context).iconTheme.color,
  controller: controller,
  keyboardType: TextInputType.emailAddress,
   obscureText: isPassword,
   enabled: isClickable,
  onFieldSubmitted:(s){
    onSubmit!(s);

  },
  // onChanged: (s){
  //   onChange!(s);
  //
  // },


    validator:validator,


  decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: Theme.of(context).iconTheme.color,
    ),
    prefixIcon:Icon(
         prefix!,
      color:Theme.of(context).iconTheme.color,
    ),

    suffixIcon:suffix!=null?IconButton(
        onPressed:(){
          suffixpressed!();
        },
      icon: Icon(suffix,
        color:Theme.of(context).iconTheme.color,

      ), ):null,
    border: InputBorder.none,
    

    // fillColor:  Theme.of(context).splashColor,
    //  filled:true ,
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width:double.infinity ,
    height:1 ,
    color: Colors.grey[300],
  ),
);

void navigateTo(context,Widget)=>Navigator.push(context,
  MaterialPageRoute(
    builder:(context)=>Widget,
  ),
);
void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder:(context)=>Widget,
  ),
    (Route<dynamic> route)=>false,
);
Widget profileImage(context){
  return Stack(
    children:<Widget> [
      CircleAvatar(
        radius:80 ,
        backgroundImage:AssetImage('assets/images/heart.jpg') ,
      ),
      Positioned(
        bottom: 5,
        right: 5,
        child: IconButton(
          icon: Icon(
            Icons.camera_alt,
            color:Theme.of(context).iconTheme.color,
          ),
          onPressed: () {

          },

        ),

      )
    ],
  );
}
Widget buildListProduct(model,context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage('${model!.image}'),
              width: 120,
              height: 120,


            ),
            if(model.discount!=0&&isOldPrice==true)
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
        SizedBox(
          width: 20,
        ),


        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.button,


              ),
              Spacer(),
              Row(
                children:[ Text(
                  '${model.price.toString()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),

                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount!=0&&isOldPrice==true)
                    Text(
                      '${model.oldPrice.toString()}',
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
                        backgroundColor:(ShopCubit.get(context).favorite[model.id])!?Colors.deepOrange:Colors.grey,
                        child: Icon (Icons.favorite_border,
                          size:  14,
                          color: Colors.white,
                        ),
                      )),
                ],),

            ],),
        ),

      ],
    ),
  ),
);
