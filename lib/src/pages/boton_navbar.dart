import 'package:flutter/material.dart';

class BotonNavbar extends StatefulWidget {
  BotonNavbar({Key key}) : super(key: key);

  @override
  _BotonNavbarState createState() => _BotonNavbarState();
}

class _BotonNavbarState extends State<BotonNavbar> {

  int selectedIndex = 0;
  Color backgroudColor = Colors.white;

  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.home), Text('Home'), Colors.blue.shade300),
    NavigationItem(Icon(Icons.insert_chart), Text('Análisis'), Colors.pink.shade200),
    NavigationItem(Icon(Icons.history), Text('Historial'), Colors.deepOrange.shade300),
    NavigationItem(Icon(Icons.person_outline), Text('Cuenta'), Colors.teal.shade200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      // height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.5),
      decoration: BoxDecoration(
        color: backgroudColor,
        boxShadow: [
          BoxShadow( 
            color: Colors.black26,
            blurRadius: 4.0
          )
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item){

          var itemIndex = items.indexOf(item);

          return GestureDetector( 
            onTap: (){
              setState(() {
                selectedIndex = itemIndex; 
              });
            },
            child: _builItem(item, selectedIndex == itemIndex),
          );
        }).toList()
      ),
    );
  }

  Widget _builItem(NavigationItem item, bool isSelected){
    return AnimatedContainer(
      duration: Duration(microseconds: 200800),
      height: double.maxFinite,
      width: isSelected ? 125.0: 50.0,
      padding: isSelected ? EdgeInsets.only(left: 12.0, right: 12.0): null,
      decoration: isSelected ? BoxDecoration( 
        color: item.color,
        borderRadius: BorderRadius.all(Radius.circular(32.0))
      ): null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
         Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconTheme(
            data: IconThemeData(
              size: 24,
              color: isSelected ? backgroudColor : Colors.black
            ),
            child: item.icon,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: isSelected ? 
              DefaultTextStyle.merge(
                style: TextStyle(color: Colors.white), 
                child: item.title
              )
              : Container(),
            ),
          ],
         )
        ],
      ),
    );
  }

}

class NavigationItem{
  final Icon icon;
  final Text title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}

