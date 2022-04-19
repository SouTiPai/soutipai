import 'package:flutter/material.dart';

class WrongQuestionsBook extends StatefulWidget {
  const WrongQuestionsBook({Key? key}) : super(key: key);

  @override
  State<WrongQuestionsBook> createState() => WrongQuestionsBookState();
}

class WrongQuestionsBookState extends State<WrongQuestionsBook> {

  //每个按钮块要展示的信息，在这里传到outlinedButton的Text中
  //还需要数据库传数据来
  //在这里定义onPressed的action
  final List<Widget> questions=new List<Widget>.generate(20, (index) =>OutlinedButton(
    onPressed: (){},
    child:Text("题目 $index"), //还需要考虑格式问题
    style: ButtonStyle(
        side:MaterialStateProperty.all(
            BorderSide(
              color:Colors.blueGrey,
            )
        ),

        minimumSize: MaterialStateProperty.all(Size(100,170)),

        textStyle: MaterialStateProperty.all(
            TextStyle(
              color:Colors.black,
              fontFamily: "LiShu",
            )
        )
    ),
  ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(

        child:Column(
          children: <Widget>[

            //背景图片和三省亭的层叠布局
            Stack(
                alignment: Alignment.center,
                children:<Widget>[
                  //图片
                  Image.asset('assets/images/wrong_questions_book/SanXingTing_sus.jpg'),

                  //三省亭，stack里用positioned绝对定位
                  Positioned(
                    left:150,
                    bottom: 93,
                    child:Text('三省亭',
                      style: TextStyle(
                        fontFamily:"LiShu",
                        fontSize: 50,
                      ),
                    ),
                  ),

                  //返回按钮
                  Positioned(
                    child:IconButton(
                      icon:Icon(Icons.keyboard_arrow_left),
                      onPressed:()=>Navigator.pushNamed(context,'/'),
                      iconSize: 40,
                    ),
                    left:10,
                    top:25,
                  )

                ]
            ),

            //错题按钮展示
            Expanded(
                child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0),topRight: Radius.circular(100.0) ),
                      color:Colors.white,
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.all(40),
                      itemCount: questions.length,
                      itemBuilder: (context,index){
                        return questions[index];
                      },
                      separatorBuilder: (context,index){
                        return Divider(
                          color:Colors.white,
                        );
                      },
                    )
                )
            ),

          ],
        ),
      ),
    );
  }
}
