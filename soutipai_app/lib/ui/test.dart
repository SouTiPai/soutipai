import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:soutipai_app/utils/dio_utils.dart';

class Test extends StatefulWidget{
  const Test({Key ? key}):super(key:key);

  @override
  State<Test> createState() => TestState();
}

class TestState extends State<Test>{
  String mes ="";

  @override
  void initState(){
    super.initState();
    Map userInfo={
      "username":"123",
      "age":"666",
    };
    print(json.encode(userInfo));//学习map类型和json字符串和二者的相互转换，
                                 // 为下一步get post再处理数据作准备
  }

  //请求数据的函数
  getData () async {
    //把借口地址传入，通过Uri.parse方法，把地址转换成某种类型，下一步用
    var apiUrl = Uri.parse("https://jd.itying.com/api/httpGet");
    //通过http.get方法，将url作为参数，返回Response类型的返回值，里面有Body和status
    var response =await http.get(apiUrl);
    //final res = await HttpUtils.instance.get("/collections/getAll", params: {"userId":"098da7e20aa44aaa81dc4f70a5ebc5be"},tips: true);
    print('Response body : ${response.body}' );

    setState(() {
      this.mes =json.decode(response.body)["msg"];
    });
  }

  //提交数据的函数
  postData () async{
    var apiUrl = Uri.parse('https://jd.itying.com/api/httpPost');
    var response = await http.post(apiUrl,body:{"username":"张三","age":"20"});
    print('Response status : ${response.statusCode}');
    //print('Response body : ${response.body}');
  }

  //请求数据并渲染的函数
  _getData() async{
    var apiUrl = Uri.parse('https://jd.iting.com/api/pcate');
    var response =await http.get(apiUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child:Column(
            children:[
              SizedBox(height:100),
              Text(mes),
              OutlinedButton(
                child:const Text("get请求数据"),
                  onPressed:getData,),
              OutlinedButton(
                  child:const Text("post提交数据"),
                  onPressed: postData,),
              OutlinedButton(
                  child:const Text("get请求数据，渲染数据"),
                  onPressed: (){}),
            ]
        )
    );
  }
}

