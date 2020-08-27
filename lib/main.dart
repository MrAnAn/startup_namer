import 'package:flutter/material.dart';

/*main(){
  runApp(MyApp());
}*/
/**
 * 普通路由的练习以及传值和一个计数器
 * 命名路由的跳转
 * {{很多的东西需要查看官方的文档}}
 */
void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',//配置初始化路由
      routes: {
        '/NewRoute':(content) => NewRoute(),
        '/':(content) => MyHomePage(title: "您好"),
        '/EchoRoute':(content) => EchoRoute(),
        '/TipRoute':(content){//配置路由,在这儿的情况是在不改变源码的情况下实现路由的跳转
          return TipRoute(text:ModalRoute.of(context).settings.arguments);
        },
      },
    );
  }
}
class MyHomePage extends StatefulWidget{
  MyHomePage({Key key,this.title}):super(key:key);
  final String title;
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
  int _count = 0;
  void _increment(){
    setState(() {
      this._count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter frist demo"),
      ),
      body: Center(
        child: Column(//垂直布局
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetPageTo(),//这个是去其他组件页面的一个自定义组件
            
            Text(widget.title),//
            Text(
              "$_count",
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              child: Text(
                "NewRoute",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.red
                ),
              ),
              onPressed: (){
                /*Navigator.push(context,
                  MaterialPageRoute(
                    builder: (content) => NewRoute(),
                  ),
                );*/
                //命名路由的跳转
                Navigator.pushNamed(context, '/NewRoute');
              },
            ),
            RaisedButton(
              child: Text("EchoRoute"),
              onPressed: (){
                Navigator.of(context).pushNamed('/EchoRoute',arguments: "路由传值");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
//定义一个新的页面
class NewRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewRoute"),
      ),
      body: Container(
        color: Colors.black54,
        child: Center(
          child: RouterTestRoute(),
        ),
      ),
    );
  }
}
//定义一个新的路由页面,并进行传值
class TipRoute extends StatelessWidget{
  //类的构造函数
  TipRoute({
    Key key,
    @required this.text,
  }):super(key: key);

  //类的成员变量
  final String text;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("TipRoute路由传值"),
       centerTitle: true,
     ),
     body: Padding(//外边距
       padding: EdgeInsets.all(18),
       child: Center(
         child: Column(
           children: [
             Text(text),
             RaisedButton(
               //返回到上一级路由
               onPressed: () => Navigator.pop(context, "您好,RouterTestRoute"),
               child: Text("返回"),
             )
           ],
         ),
       ),
     ),
   );
  }
}
class RouterTestRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async { //async是flutter的一步操作,需要配合await
          //打开 TipRoute,并等待返回结果
          var result = await Navigator.push(context,
              MaterialPageRoute(
                builder: (content){
                  return TipRoute(text: "您好,TipRoute");
                }
              ),
          );
          print("路由返回值是:$result");
        },
        child: Text("打开TipRoute"),
      ),
    );
  }
}
//定义一个新的路由,演示路由传值
class EchoRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //接收参数
    var parmater = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(parmater),
      ),
    );
  }
}
//路由生成钩子(在研究一下,不是很懂,电商app)


//下面的Widget提供跳转到其他的演示组件页面
class WidgetPageTo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //去包管理演示页面
          RaisedButton(
            
          ),
        ],
      ),
    );
  }
}