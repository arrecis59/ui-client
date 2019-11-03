import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String xatoma = "Son protuberancias firmes que puede ser color rosa o amarrillo que pueden aparecer en los brasos, tronco o piernas" +
  ". La presencia de esta lesión puede ser asociada a niveles anormales de lipidos o grasas en la sangre";
  
  String sweet = "Se caracteriza por una constelación de síntomas entre ellos fiebre, neutrofilia, lesiones cutaneas dolorosas (pápulas)" +
  ". El sindrome puede observarse en tres situaciones clásica, asociada al cancer y inducida por fármacos";
  
  String iderma = "Instituto especializado en dermatología clínica y cirugia de piel, a precios bajos de atención.";

  String tinea = "Es una infeccion fungicida de la piel que afecta la capa a su capa más exterior, llamada extra corneo. " +
  "la tinea negra produce un parche negro o marron en la piel, esta se puede confundir con decoloraciones de la piel, pero" +
  " en realidad es una afección benigna.";

  String urticaria = "Son ronchas rojizas que pueden producir picazón en la piel. Suele ser causada por una reacción alérgica a"+
  "la comida, medicamentos y otros agentes irritantes.";

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text( 
          'Información importante',
          style: TextStyle( 
            fontSize: 15.0,
            color: Colors.white
          ),
        ),
        backgroundColor: Color.fromRGBO(47, 181, 121, 0.7),
      ),
      body: Stack( 
        children: <Widget>[
          _vistaNoticias()
        ],
      ),
    );
  }

  Widget _vistaNoticias(){
    return Container( 
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView( 
        child: Center( 
          child: Column(
            children: <Widget>[
              _institucion(),
              _noticia(),
              _noticia2(),
              _noticia3(),
              _noticia4(),
              _noticia5(),
            ],
          ),
        ),
      ),
    );
  }
  

  Widget _noticia(){
    return Container( 
              
              width: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [
                  BoxShadow( 
                    color: Color.fromRGBO(185, 194, 194, 0.56),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0)
                  )
                ]
              ),
              child: Column( 
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                      '¿Qué es el xamota eruptivo?',
                       textAlign: TextAlign.center,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      xatoma,
                      textAlign: TextAlign.justify,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      );
  }

  Widget _noticia2(){
    return Container( 
              
              width: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [
                  BoxShadow( 
                    color: Color.fromRGBO(185, 194, 194, 0.56),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0)
                  )
                ]
              ),
              child: Column( 
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                      '¿Qué es el sindrome de sweet?',
                       textAlign: TextAlign.center,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      sweet,
                      textAlign: TextAlign.justify,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      );
  }

  Widget _noticia3(){
    return Container( 
              
              width: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [
                  BoxShadow( 
                    color: Color.fromRGBO(185, 194, 194, 0.56),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0)
                  )
                ]
              ),
              child: Column( 
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                      '¿Qué es la tinea negra?',
                       textAlign: TextAlign.center,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      tinea,
                      textAlign: TextAlign.justify,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      );
  }

  Widget _noticia4(){
    return Container( 
              
              width: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [
                  BoxShadow( 
                    color: Color.fromRGBO(185, 194, 194, 0.56),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0)
                  )
                ]
              ),
              child: Column( 
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                      '¿Qué es la pitiriasis versicolor?',
                       textAlign: TextAlign.center,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      tinea,
                      textAlign: TextAlign.justify,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      );
  }

  Widget _noticia5(){
    return Container( 
              
              width: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [
                  BoxShadow( 
                    color: Color.fromRGBO(185, 194, 194, 0.56),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0)
                  )
                ]
              ),
              child: Column( 
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                      '¿Qué es la urticaria?',
                       textAlign: TextAlign.center,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      urticaria,
                      textAlign: TextAlign.justify,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      );
  }

  Widget _institucion(){
    return Container( 
              
              width: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(30.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [
                  BoxShadow( 
                    color: Color.fromRGBO(185, 194, 194, 0.56),
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0)
                  )
                ]
              ),
              child: Column( 
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                      'Instituto nacional de dermatología y cirugía de piel',
                       textAlign: TextAlign.center,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Image( 
                        image: AssetImage('assets/iderma.jpg'),
                      ),
                      SizedBox(height: 20.0,),
                      Text(
                      iderma,
                      textAlign: TextAlign.justify,
                        style: TextStyle( 
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(63, 66, 66, 0.6),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row( 
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Flexible(
                            child: Column( 
                              children: <Widget>[
                                Text(' Calzada San Juan 32-11 Zona 7', textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      FlatButton( 
                        child: Row( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.call),
                            Text(
                            ' +502 2208 9494'
                            )
                          ],
                        ),
                        onPressed: (){
                          UrlLauncher.launch("tel:+502 2208 9494");
                        },
                      )
                    ],
                  )
                ],
              ),
      );
  }

}