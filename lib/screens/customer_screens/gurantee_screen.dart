import 'package:flutter/material.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';


class GuaranteeScreen extends StatelessWidget {
  const GuaranteeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){Navigator.pop(context);},
                      icon:Icon(Icons.arrow_back,color: kBlueColor,size: 30,)),
                ],
              ),
              SizedBox(height: 20,),
              Text('شهادة ضمان',style: TextStyle(color: kBlueColor,
                  fontWeight: FontWeight.bold,fontSize: 24),),
              SizedBox(height: 36,),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Image(image: AssetImage('assets/images/Guarantee.png'),),
              ),
              SizedBox(height: 40,),
              Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('محمود عزت',style: TextStyle(color: Color(0xff707070),
                          fontSize: 15),),
                      SizedBox(width: 50),
                      Text('اسم العميل',style: TextStyle(fontSize: 15),textDirection: TextDirection.rtl,)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('01000506070',style: TextStyle(color: Color(0xff707070),
                          fontSize: 15),),
                      SizedBox(width: 50),
                      Text('رقم الهاتف',style: TextStyle(fontSize: 15),textDirection: TextDirection.rtl,)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('8/2/2021',style: TextStyle(color: Color(0xff707070),
                          fontSize: 15),),
                      SizedBox(width: 50),
                      Text('تاريخ الطلب',style: TextStyle(fontSize: 15),textDirection: TextDirection.rtl,),
                    ],
                  ),
                  SizedBox(height: 22,),
                ],
              ),
              SizedBox(height: 40,),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text('الصور',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
              GridView.count(
              crossAxisSpacing: 30,
              crossAxisCount: 2,
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/window.png'))
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/window.png'))
                  ),
                ),
              ],
              ),
              SizedBox(height: 50,),
              CustomButton(color: kBlueColor,label: 'تحميل الضمان',onTab: (){
                showAlertDialog(
                  context: context,
                  message: 'تم تحميل الضمان بنجاح',
                  imagePath: 'assets/images/deal.png',
                  buttonText: 'شكرا'
                );
              },),
              SizedBox(height: 40,)
            ],
          ),
        ),
      )),
    );
  }
}
