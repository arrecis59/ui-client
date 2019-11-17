import 'dart:developer';
import 'dart:convert';
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
  List<charts.Series<Ubicacion, int>> _seriesPointData;
  List<charts.Series<Rendimiento, int>> _seriesScatterData;
  MetricasProvider metricProv = MetricasProvider();

  bool vistaInicial = true;
  bool vistaEnfermedades = false;
  bool vistaUbicacion = false;
  bool vistaRendimiento = false;

  @override
  Widget build(BuildContext context) {

    _seriesPieData = List<charts.Series<Enfermedad, String>>();
    _seriesPointData = List<charts.Series<Ubicacion, int>>();
   _seriesScatterData = List<charts.Series<Rendimiento, int>>();

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
    }else if (vistaUbicacion) {
      vista = _pointChart();
    }else if (vistaRendimiento) {
      vista = _scatterChart();
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

  Widget _pointChart() {

    final customTickFormatter =
    charts.BasicNumericTickFormatterSpec((num value) {
      if (value == 0) {
        return "Zona 1";
      } else if (value == 1) {
        return "Zona 2";
      } else if (value == 2) {
        return "Zona 5";
      }

    });

    return FutureBuilder(
      future: metricProv.obtenerMetricaUbicacion(),
      builder: (BuildContext context, snapShot) {
        if (snapShot.hasData) {

          _setDataPoint(snapShot.data);
          return Container(
            padding: EdgeInsets.only(top: 130.0, bottom: 20.0, left: 10.0, right: 10.0),
            child: charts.LineChart(
              _seriesPointData,
              animate: true,
              animationDuration: Duration(milliseconds: 1100),
              defaultRenderer: charts.LineRendererConfig(includePoints: true, includeArea: true),
              domainAxis: charts.NumericAxisSpec(
              tickProviderSpec:
              charts.BasicNumericTickProviderSpec(desiredTickCount: 3),
              tickFormatterSpec: customTickFormatter,
            ),
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

  Widget _scatterChart() {


    return FutureBuilder(
      future: metricProv.obtenerMetricaRendimiento(),
      builder: (BuildContext context, snapShot) {
        if (snapShot.hasData) {

          _setDataScatter(snapShot.data);
          return Container(
            padding: EdgeInsets.only(top: 130.0, bottom: 20.0, left: 10.0, right: 10.0),
            child: charts.ScatterPlotChart(
              _seriesScatterData,
              animate: true,
              animationDuration: Duration(milliseconds: 1100),
              defaultRenderer: charts.PointRendererConfig(),
              customSeriesRenderers: [
                charts.LineRendererConfig( 
                  customRendererId: 'customeLine',
                  layoutPaintOrder: charts.LayoutViewPaintOrder.point + 1
                )
              ],
             
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
      margin: EdgeInsets.only(top: 50.0),
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
                          'Porcentaje de enfermedades según historial',
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
            InkWell(
              onTap: (){
                setState(() {
                  vistaInicial = false;
                  vistaEnfermedades = false;
                  vistaUbicacion = true;
                });
              },
              child: Container(
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
            ),
            InkWell(
              onTap: (){
                setState(() {
                  vistaInicial = false;
                  vistaEnfermedades = false;
                  vistaUbicacion = false;
                  vistaRendimiento = true;
                });
              },
              child: Container(
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
                          'Redimiento del algoritmo por mes al detectar una efermedades',
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

  _setDataPoint(var snapShot) {

    int zona1 = int.parse(snapShot['Zona 1'].toString());
    int zona2 = int.parse(snapShot['Zona 2'].toString());
    int zona5 = int.parse(snapShot['Zona 5'].toString());

    var lineData = [
      Ubicacion(0, zona1),
      Ubicacion(1, zona2),
      Ubicacion(2, zona5),
    ];

    _seriesPointData.add(charts.Series(
        data: lineData,
        domainFn: (Ubicacion task, _) => task.correlativo,
        measureFn: (Ubicacion task, _) => task.valor,
       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        id: 'Daily task',
      )
    );
  }

  
  _setDataScatter(var snapShot) {
    
    List<Rendimiento> scatterData = [];

    var enero = snapShot['enero'];
    var febrero = snapShot['febrero'];
    var marzo = snapShot['marzo'];
    var abril = snapShot['abril'];
    var mayo = snapShot['mayo'];
    var junio = snapShot['junio'];
    var julio = snapShot['julio'];
    var agosto = snapShot['agosto'];
    var septiembre = snapShot['septiembre'];
    var octubre = snapShot['octubre'];
    var noviembre = snapShot['noviembre'];
    var diciembre = snapShot['diciembre'];
    
    //ENERO
    if(enero.length > 0){
      
      for(int i = 0; i < enero.length; i++){
        scatterData.add(Rendimiento(0, double.parse(enero[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(0, 0.0, 3.0));
    }

    //FEBRERO
    if(febrero.length > 0){
      
      for(int i = 0; i < febrero.length; i++){
        scatterData.add(Rendimiento(1, double.parse(febrero[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(1, 0.0, 3.0));
    }

    //MARZO
    if(marzo.length > 0){
      
      for(int i = 0; i < marzo.length; i++){
        scatterData.add(Rendimiento(2, double.parse(marzo[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(2, 0.0, 3.0));
    }

    //ABRIL
    if(abril.length > 0){
      
      for(int i = 0; i < abril.length; i++){
        scatterData.add(Rendimiento(3, double.parse(abril[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(3, 0.0, 3.0));
    }

    //MAYO
    if(mayo.length > 0){
      
      for(int i = 0; i < mayo.length; i++){
        scatterData.add(Rendimiento(4, double.parse(mayo[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(4, 0.0, 3.0));
    }

    //JUNIO
    if(junio.length > 0){
      
      for(int i = 0; i < junio.length; i++){
        scatterData.add(Rendimiento(5, double.parse(junio[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(5, 0.0, 3.0));
    }

    //JULIO
    if(julio.length > 0){
      
      for(int i = 0; i < julio.length; i++){
        scatterData.add(Rendimiento(6, double.parse(julio[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(6, 0.0, 3.0));
    }

    //AGOSTO
    if(agosto.length > 0){
      
      for(int i = 0; i < agosto.length; i++){
        scatterData.add(Rendimiento(7, double.parse(agosto[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(7, 0.0, 3.0));
    }

    //SEPTIEMBRE
    if(septiembre.length > 0){
      
      for(int i = 0; i < septiembre.length; i++){
        scatterData.add(Rendimiento(8, double.parse(septiembre[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(8, 0.0, 3.0));
    }

    //OCTUBRE
    if(octubre.length > 0){
      
      for(int i = 0; i < octubre.length; i++){
        scatterData.add(Rendimiento(9, double.parse(octubre[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(9, 0.0, 3.0));
    }

    //NOVIEMBRE
    
    if(noviembre.length > 0){
      
      for(int i = 0; i < noviembre.length; i++){
        scatterData.add(Rendimiento(10, double.parse(noviembre[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(10, 0.0, 3.0));
    }

    //DICIEMBRE
    
    if(diciembre.length > 0){
      
      for(int i = 0; i < diciembre.length; i++){
        scatterData.add(Rendimiento(11, double.parse(diciembre[i].toString()) , 3.0));
      }

    }else{
      scatterData.add(Rendimiento(11, 0.0, 3.0));
    }


    _seriesScatterData.add(charts.Series(

        data: scatterData,
        colorFn: (Rendimiento ren, _) {
          // Bucket the measure column value into 3 distinct colors.
          return charts.MaterialPalette.blue.shadeDefault;
        },
       domainFn: (Rendimiento ren, _) => ren.mes,
       measureFn: (Rendimiento ren, _) => ren.valor,
      // Providing a radius function is optional.
       radiusPxFn: (Rendimiento ren, _) => ren.radio,
      id: 'Daily task',
      )..setAttribute(charts.rendererIdKey, "customeLine")
    );
  }
}

class Enfermedad {
  String nombre;
  double valor;
  Color color;

  Enfermedad(this.nombre, this.valor, this.color);
}

class Ubicacion {
  int correlativo;
  int valor;

  Ubicacion(this.correlativo, this.valor);
}

class Rendimiento {
  int mes;
  double valor;
  double radio;

  Rendimiento(this.mes, this.valor, this.radio);
}
