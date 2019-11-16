import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BiPage extends StatefulWidget {
  BiPage({Key key}) : super(key: key);

  @override
  _BiPageState createState() => _BiPageState();
}

class _BiPageState extends State<BiPage> {

  List<charts.Series<Enfermedad,String>> _seriesPieData;


  var pieData = [
      Enfermedad('Xatoma eruptivo', 25.0, Colors.blue.shade300),
      Enfermedad('Pitiriasis versicolor', 25.0, Color.fromRGBO(47, 181, 121, 0.7)),
      Enfermedad('Tinea negra', 50.0, Color.fromRGBO(252, 202, 108, 0.9)),
      Enfermedad('Sindrome de Sweet', 0.0, Colors.deepOrange.shade300),
      Enfermedad('Urticaria', 0.0, Colors.red.shade300),
  ];


  @override
  Widget build(BuildContext context) {

    _seriesPieData = List<charts.Series<Enfermedad,String>>();

    _seriesPieData.add(
      charts.Series( 
        data: pieData,
        domainFn: (Enfermedad task, _) => task.nombre,
        measureFn:  (Enfermedad task, _) => task.valor,
        colorFn:  (Enfermedad task, _) => charts.ColorUtil.fromDartColor(task.color),
        id: 'Daily task',
        labelAccessorFn: (Enfermedad row, _) => '${row.valor}'
      )
    );

    return Scaffold( 
      appBar: AppBar( 
        title: Text('Inteligencia de negocios'),
      ),
      body: pieChart(),
    );

}


Widget pieChart(){
  return 
    Container(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: charts.PieChart( 
        _seriesPieData,
        animate: true,
        animationDuration: Duration(milliseconds: 1100),
          behaviors: [
            charts.DatumLegend(
              outsideJustification: charts.OutsideJustification.endDrawArea,
              horizontalFirst: false,
              desiredMaxRows: 2,
              cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
              entryTextStyle: charts.TextStyleSpec( 
                color: charts.MaterialPalette.gray.shade600,
                fontFamily: 'Georgia',
                fontSize: 11
              )
            )
          ],
        defaultRenderer: charts.ArcRendererConfig( 
          arcWidth: 100,
          arcRendererDecorators: [
            charts.ArcLabelDecorator( 
              labelPosition: charts.ArcLabelPosition.inside
            )
          ]
        ),
      ),
    );
  }
}


class Enfermedad{
  String nombre;
  double valor;
  Color color;

  Enfermedad(this.nombre, this.valor, this.color);
}