import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/component/component.dart';
import '../../../shared/style/colors.dart';
import '../login/shopLogin_screen.dart';
class BoardingModel{
   late final String? image;
   late final String? title;
   late final String? body;
   BoardingModel({
     required this.title,
     required this.image,
     required this.body,
});
}

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardController=PageController();

  List<BoardingModel>boarding=[
    BoardingModel(
      image:'assets/images/shop1.jpg',
      title: 'Shop App',
      body: 'Best online shopping app',

    ),
    BoardingModel(
      image:'assets/images/shop2.jpg',
      title: 'Shop App',
      body: 'Buy what you want at any time',
    ),
    BoardingModel(
      image:'assets/images/shop3.jpg',
      title: 'Shop App',
      body: 'Get loads of offers and sales',
    ),

  ];
  bool isLast=false;
  void submit(){
    CacheHelper.saveData(key:'onBoarding', value: false).then((value){
      if(value)
        {
          navigateAndFinish(context,ShopLoginScreen());
        }
    });
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFFDEBD),
      appBar: AppBar(
          systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor: mshmshColor,
            statusBarIconBrightness: Brightness.dark,

          ),
        backgroundColor: Color(0xFFFFDEBD),
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip',

          ),
        ],
      ),

      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }
                  else{
                    setState(() {
                      isLast=false;
                    });

                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
              itemBuilder:(context,index)=>blidBoardingItem(boarding[index]),
              itemCount:boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children:
              [

                SmoothPageIndicator(count:boarding.length ,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    expansionFactor: 4,
                    dotHeight: 10,
                    spacing: 5,
                    dotWidth: 10,
                    activeDotColor: defultColor,
                  ),
                  controller: boardController,),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  onPressed:(){
                  if(isLast){
                    submit();
                  }else{
                    boardController.nextPage(
                      duration: Duration(
                      microseconds: 750,),
                      curve: Curves.fastLinearToSlowEaseIn,);
                  }

                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                ),

              ],
            )
          ],
        ),
      ),

    );
  }

  Widget blidBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
      ),),
      SizedBox(
        height: 10,),
      Text(
        '${model.title}',
        style:TextStyle(
          fontSize:24 ,
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange
        ),
      ),
      SizedBox(
        height: 15,),
      Text(
        '${model.body}',
        style:TextStyle(
          fontSize:15 ,
          fontWeight: FontWeight.bold,
            color: Colors.deepOrange

        ),
      ),


      // PageView.builder(itemBuilder:(context,index){
      //
      // },),
    ],
  );
}
