import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ui_client/src/providers/metricas_provider.dart';

class BiPage extends StatefulWidget {
  BiPage({Key key}) : super(key: key);

  @override
  _BiPageState createState() => _BiPageState();
}

class _BiPageState extends State<BiPage> {
  List<charts.Series<Enfermedad, String>> _seriesPieData;
  MetricasProvider metricProv = MetricasProvider();

  bool vistaInicial = true;
  bool vistaEnfermedades = false;
  bool press = false;

  @override
  Widget build(BuildContext context) {
    _seriesPieData = List<charts.Series<Enfermedad, String>>();

    return Stack(
      children: <Widget>[
      !vistaInicial ? _botonRegresar(): Container(), 
      _determinarVista()
      ],
    );
  }

  Widget _determinarVista() {
    Widget vista = Container();

    if (vistaInicial) {
      vista = _vistaInicial();
    } else if (vistaEnfermedades) {
      vista = _pieChart();
    }

    return vista;
  }

  Widget _pieChart() {
    return FutureBuilder(
      future: metricProv.obtenerMetricaEnfermedades(),
      builder: (BuildContext context, snapShot) {
        if (snapShot.hasData) {
          _setData(snapShot.data);
          return Container(
            padding: EdgeInsets.only(top: 130.0),
            child: charts.PieChart(
              _seriesPieData,
              animate: true,
              animationDuration: Duration(milliseconds: 1100),
              behaviors: [
                charts.DatumLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: false,
                    desiredMaxRows: 2,
                    cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                    entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.gray.shade600,
                        fontFamily: 'Georgia',
                        fontSize: 11))
              ],
              defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 100,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.inside)
                  ]),
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()],
            )
          ],
        );
      },
    );
  }

  Widget _botonRegresar() {

    return Container(
      margin: EdgeInsets.only(top: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 1.5,
            height: 40.0,
            child: FlatButton(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
              color: Color.fromRGBO(255, 111, 112, 1),
              textColor: Colors.white,
              child: Text(
                'Regresar'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onPressed:(){
                setState(() {
                  vistaEnfermedades = false;
                  vistaInicial = true;
                });
              },
            ),
          )
        ],
      ),
    );
  
  }

  Widget _vistaInicial() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  vistaInicial = false;
                  vistaEnfermedades = true;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.15,
                padding: EdgeInsets.all(30.0),
                margin: EdgeInsets.only(top: 70.0, bottom: 20.0),
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

  _setData(var snapShot) {
    double xatoma = double.parse(snapShot['xatoma_eruptivo'].toString());
    double pitiriasis =
        double.parse(snapShot['pitiriasis_versicolor'].toString());
    double tinea = double.parse(snapShot['tinea_nigra'].toString());
    double sweet = double.parse(snapShot['sindrome_de_sweet'].toString());
    double urticaria = double.parse(snapShot['urticaria'].toString());

    var pieData = [
      Enfermedad('Xatoma eruptivo', xatoma, Colors.blue.shade300),
      Enfermedad('Pitiriasis versicolor', pitiriasis,
          Color.fromRGBO(47, 181, 121, 0.7)),
      Enfermedad('Tinea negra', tinea, Color.fromRGBO(252, 202, 108, 0.9)),
      Enfermedad('Sindrome de Sweet', sweet, Colors.deepOrange.shade300),
      Enfermedad('Urticaria', urticaria, Colors.red.shade300),
    ];

    _seriesPieData.add(charts.Series(
        data: pieData,
        domainFn: (Enfermedad task, _) => task.nombre,
        measureFn: (Enfermedad task, _) => task.valor,
        colorFn: (Enfermedad task, _) =>
            charts.ColorUtil.fromDartColor(task.color),
        id: 'Daily task',
        labelAccessorFn: (Enfermedad row, _) => '${row.valor}'));
  }
}

class Enfermedad {
  String nombre;
  double valor;
  Color color;

  Enfermedad(this.nombre, this.valor, this.color);
}
