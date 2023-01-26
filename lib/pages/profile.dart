

import 'package:burs_app/widgets/special_button.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _profile();

}
class _profile extends State<Profile>{
  List<TextEditingController> controller = [TextEditingController()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,
      appBar: AppBar(
        title: const Text('پروفایل'),
      ),
      body:ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width*0.64,
              width: MediaQuery.of(context).size.width,
              child:
              Stack(
                children: [
                  Image.asset('assets/images/profileTop.jpg'),
                  Align(alignment: Alignment.bottomCenter,
                    child: Padding(padding:
                    EdgeInsets.only(bottom: MediaQuery.of(context).size.width*0.09),
                      child: const Icon(Icons.account_circle_outlined,size: 90,),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            DataFild('نام', Icons.account_circle),
            const SizedBox(height: 5,),
            DataFild('نام خانوادگی', Icons.account_box),
            const SizedBox(height: 5,),
            DataFild('شماره موبایل', Icons.mobile_friendly_outlined),
            const SizedBox(height: 5,),
            DataFild('نام کاربری', Icons.account_box_outlined),
            // const SizedBox(height: 5,),
            // DataFild('کد بورسی', Icons.format_list_numbered_sharp),
            const SizedBox(height: 5,),
            DataFild('توضیحات', Icons.note_add_outlined),
            const SizedBox(height: 5,),
            Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: (MediaQuery.of(context).size.width/ 2) - 40,
                    child:SpecialButton(
                        backGroundColor: ThemeColors.PRIMARY_DARK,
                            children: const [
                              Text('خروج',style:TextStyle(color:ThemeColors.LIGHT,fontSize: 15,
                                  fontWeight: FontWeight.bold),),
                            ],
                            onPressed:()=>{}
                        )
                    ),

                    const SizedBox(width: 10,),

                    SizedBox(width: (MediaQuery.of(context).size.width/ 2) - 40,
                    child:SpecialButton(
                      backGroundColor: ThemeColors.PRIMARY_DARK,
                        children :const [
                          Text('بازگشت',style: TextStyle(color:ThemeColors.LIGHT,fontSize: 15,
                              fontWeight: FontWeight.bold),),
                        ],
                        onPressed: ()=>Navigator.pop(context)

                    )
                      ,
                    )
                  ],
                )
            ),
          ]
        ),
    );
  }

  Widget DataFild(String text,IconData data) =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
          child: Row(
            children: [
              Icon(data,color: ThemeColors.PRIMARY_DARK,size: 40,),
              const SizedBox(width: 6,),
              Text(text,style: _style(30,ThemeColors.PRIMARY),)
            ],
          )
      );

  TextStyle _style([double? size,Color? color]) =>
      TextStyle(color: color ?? ThemeColors.PRIMARY_DARK,fontSize: size ?? 15,
      fontWeight: FontWeight.bold);

}