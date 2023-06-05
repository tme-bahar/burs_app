

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
    return DefaultTextStyle(
        style: TextStyle(),
    child:Container(
        margin:
        EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width/2)-220,
            vertical:  (MediaQuery.of(context).size.height/2)-330),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),color: ThemeColors.LIGHT,
        ),
        child:ListView(
          children: <Widget>[
            // getRow([
            //   Text("پروفایل",
            //     style: const TextStyle(color: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),
            //
            //   Material(
            //     child: InkWell(splashColor: ThemeColors.LIGHT,
            //       borderRadius: BorderRadius.all(Radius.circular(10)),
            //       onTap: ()=>Navigator.pop(context),
            //       child: const Icon(Icons.cancel,size: 30,),),
            //     color: ThemeColors.LIGHT,
            //   ),
            // ],),
            SizedBox(
              height: 290,
              width: 440,
              child:
              Stack(
                children: [

                  Image.asset('assets/images/profileTop.jpg'),
                  const Align(alignment: Alignment.topCenter,
                    child: Padding(padding:
                    EdgeInsets.only(top: 135),
                      child: Icon(Icons.account_circle_outlined,size: 120,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10,right: 10),
                    alignment: Alignment.topRight,
                    child:
                  Material(
                    child: InkWell(splashColor: ThemeColors.PRIMARY_DARK,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: ()=>Navigator.pop(context),
                      child: const Icon(Icons.cancel,size: 30,color: Colors.white,),),
                    color: ThemeColors.PRIMARY_DARK,
                  )
                    ,),
                ],
              ),
            ),

            const SizedBox(height: 0,),
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
            const SizedBox(height: 20,),
            Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 190,
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

                    SizedBox(width: 190,
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

    )));

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
  Padding getRow(List<Widget> children) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    ),
  );
}