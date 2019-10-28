import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String xatoma = "son protuberancias firmes que puede ser color rosa o amarrillo que pueden aparecer en los brasos, tronco o piernas" +
  ". La presencia de esta lesión puede ser asociada a niveles anormales de lipidos o grasas en la sangre";
  
  String sweet = "se caracteriza por una constelación de síntomas entre ellos fiebre, neutrofilia, lesiones cutaneas dolorosas (pápulas)" +
  ". El sindrome puede observarse en tres situaciones clásica, asociada al cancer y inducida por fármacos";

  String iderma = "centro especializado en dermatología clínica y cirugía con bajos precios de atención. " +
  "Ubicado en Calzada San Juan 32-11 Zona 7";

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text( 
          'Lo más relevante',
          style: TextStyle( 
            fontSize: 17.0,
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
                          fontSize: 14.0,
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
                          fontSize: 14.0,
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
                          fontSize: 14.0,
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

}