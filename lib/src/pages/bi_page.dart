import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ui_client/src/providers/metricas_provider.dart';

class BiPage extends StatefulWidget {
  BiPage({Key key}) : super(key: key);

  @override
  _BiPageState createState() => _BiPageState();
}

class _BiPageState extends State<BiPage> {

  bool inicial = true;
  bool comunes = false;
  bool ubicacion = false;
  bool rendimiento = false;
  
  List<charts.Series<Task,String>> _seriesPieData;

  MetricasProvider metriProv = MetricasProvider();

  // @override
  // void initState(){
  //   super.initState();
  //   _seriesPieData = List<charts.Series<Task,String>>();
  // }

  @override
  Widget build(BuildContext context) {

     _seriesPieData = List<charts.Series<Task,String>>();

    _abc();
    _generateData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Inteligencía de negocios',
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        backgroundColor: Color.fromRGBO(242, 195, 53, 0.7),
      ),
      body: _detectarVista()
    );
  }

  Widget _detectarVista(){
    Widget vista = Container();

    if(inicial){
      vista = _vistaPie();
    }

    return vista;

  }

  Widget _vistaInicial() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.15,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(185, 194, 194, 0.8),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0))
              ]),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Enfermedades más comunes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Según los 5 tipos de enfermedad comparados con los análisis realizados',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.15,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(185, 194, 194, 0.8),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0))
              ]),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Ubicación según enfermedad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Ubicaciones en donde afectan más cierta enfermedad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.15,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(185, 194, 194, 0.56),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0))
              ]),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Rendimiento de la detección',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Redimiento del algoritmo al detectar una efermedad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vistaPie(){
    return Padding( 
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      child: Center( 
        child: Column( 
          children: <Widget>[
            Flexible(
            child: charts.PieChart( 
              _seriesPieData,
              animate: true,
              animationDuration: Duration(milliseconds: 2500),
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
            ),
            Text('Xatoma eruptivo: 300'),
            Text('Xatoma eruptivo: 300'),
            Text('Xatoma eruptivo: 300'),
            Text('Xatoma eruptivo: 300'),
            Text('Xatoma eruptivo: 300'),
          ],
        ),
      ),
    );
  }

  _generateData(){

    var pieData = [
      Task('Xatoma eruptivo', 25.0, Colors.blue.shade300),
      Task('Pitiriasis versicolor', 25.0, Color.fromRGBO(47, 181, 121, 0.7)),
      Task('Tinea negra', 50.0, Color.fromRGBO(252, 202, 108, 0.9)),
      Task('Sindrome de Sweet', 0.0, Colors.deepOrange.shade300),
      Task('Urticaria', 0.0, Colors.red.shade300),
    ];

    _seriesPieData.add(
      charts.Series( 
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn:  (Task task, _) => task.taskValue,
        colorFn:  (Task task, _) => charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Daily task',
        labelAccessorFn: (Task row, _) => '${row.taskValue}'
      ),
    );
  }

  _abc() async{
    final res = await metriProv.obtenerMetricaEnfermedades();
    print(res);

  }


}

class Task{
  String task;
  double taskValue;
  Color colorval;

  Task(this.task, this.taskValue, this.colorval);

}
