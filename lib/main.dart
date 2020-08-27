import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner:false,
    title: "My App",
    //home: MyScaffold(),
    //home:TutoriaHome(),
    //home:MyButton(),
    //home:Conuter(),
    //home:Counter(),
    home: ShoppingList(
      products: [
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chococate chips'),
      ],
    ),
  ));
}
class MyApp extends StatelessWidget{
  MyApp({this.title});
  // Widget子类中的字段往往都会定义为"final"
  final Widget title;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue[500],
      ),
      child: Row(//水平方向的线性布局
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: "Navigation menu",
            onPressed: null,
          ),
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
class MyScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          MyApp(
            title: Text(
                "Example title",
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text("Hello word"),
            ),
          ),
        ],
      ),
    );
  }
}
class TutoriaHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(//Scaffold是Material中主要的布局组件.
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Navigation menu",
          onPressed: null,
        ),
        title: Text("Example title"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "Search",
            onPressed: null,
          ),
        ],
      ),
      body: Center(
        child: Text("Hello word"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
//处理手势
class MyButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    /**
     * 该GestureDetector widget并不具有显示效果，
     * 而是检测由用户做出的手势。
     * 当用户点击Container时，
     * GestureDetector会调用它的onTap回调，
     * 在回调中，将消息打印到控制台。
     * 您可以使用GestureDetector来检测各种输入手势，
     * 包括点击、拖动和缩放。
     *
     * 许多widget都会使用一个GestureDetector为其他widget提供可选的回调。
     * 例如，IconButton、 RaisedButton、 和FloatingActionButton ，
     * 它们都有一个onPressed回调，它会在用户点击该widget时被触发。
     */
    return GestureDetector(
      onTap: (){
        print("MyButton was tapped");
      },
      child: Container(
        height: 36,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightGreen,
        ),
        child: Center(
          child: Text("Engage"),
        ),
      ),
    );
  }
}

//根据用户的如改变widget(有状态的组件)
/*class Conuter extends StatefulWidget{
  @override
  _ConuterState createState() => _ConuterState();

}
class _ConuterState extends State<Conuter>{
  int _count = 0;
  void _increment(){
    setState(() {
      _count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("根据输入改变组件"),
      ),
      body: Row(//水平布局
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text("Increment"),
            onPressed: (){
              _increment();//调用方法
            },
          ),
          Text("Count: $_count"),
        ],
      ),
    );
  }
}*/
//
class CounterDisplay extends StatelessWidget{
  CounterDisplay({this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return Text("Count: $count");
  }
}
class CounterIncrementor extends StatelessWidget{
  CounterIncrementor({this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text("Increment"),
    );
  }
}
class Counter extends StatefulWidget{
  @override
  _CounterState createState () => _CounterState();
}
class _CounterState extends State<Counter>{
  int _count = 0;
  void _incrrement(){
    _count++;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //调用自定义的组件
        CounterIncrementor(onPressed: _incrrement),
        CounterDisplay(count: _count),
      ],
    );
  }
}

//综合案列
class Product{//普通的Dart类
  const Product({this.name});
  final String name;
}
typedef void CartChangedCallback(Product product,bool inCart);

class ShoppingListItem extends StatelessWidget{
  ShoppingListItem({Product product,this.inCart,this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;


  Color _getColor (BuildContext context){
    return inCart?Colors.black54:Theme.of(context).primaryColor;
  }
  TextStyle _getTextStyle(BuildContext context){
    if(!inCart) return null;
    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}
class ShoppingList extends StatefulWidget{
  ShoppingList({Key key,this.products}):super(key: key);
  final List<Product> products;
  _ShoppingListState createState () => _ShoppingListState();
}
class _ShoppingListState extends State<ShoppingList>{
  @override
  Widget build(BuildContext context) {
    Set<Product> _shoppingCart = new Set<Product>();
    void _handleCartChanged(Product product, bool inCart){
      setState(() {
        if(inCart){
          _shoppingCart.add(product);
        }else{
          _shoppingCart.remove(product);
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoping List"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
  
}