import 'package:flutter/material.dart';
import 'package:ui_client/src/preferecias_usuario/preferencias_usuario.dart';
import 'package:ui_client/src/providers/analisis_provider.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final prefs = new PreferenciasUsuario();
  AnalasisProvider anProvider = AnalasisProvider();
  bool existeHistorial = false;
  int nElementos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial de análisis',
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange.shade300,
      ),
      body: Stack(
        children: <Widget>[
          _crearListado()
        ],
      ),
    );
  }



  Widget _crearListado() {

    return FutureBuilder(

      future: anProvider.consultarHistorial(prefs.email),
      builder: (BuildContext context, snapshot) {

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {

              return Container(
                padding: EdgeInsets.all(30.0),
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                          snapshot.data[i]['fecha'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800
                          ),
                        ),
                        SizedBox(height: 4.0,),
                        Text(
                          snapshot.data[i]['hora'] + ' Horas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(63, 66, 66, 0.8),
                          ),
                        ),
                        
                        SizedBox(
                          height: 16.0,
                        ),
                        Row( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Enfermedad: ',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(63, 66, 66, 0.8),
                              ),
                            ),
                            Text(
                              snapshot.data[i]['enfermedad'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(63, 66, 66, 0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Gravedad: ',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(63, 66, 66, 0.8),
                              ),
                            ),
                            Text(
                              snapshot.data[i]['gravedad'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(63, 66, 66, 0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Ubicación: ',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(63, 66, 66, 0.8),
                              ),
                            ),
                            Text(
                              snapshot.data[i]['ubicacion'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(63, 66, 66, 0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
          return Center( 
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image( 
                  image: AssetImage('assets/nofound.png'),
                ),
                SizedBox(height: 20.0,),
                Text(
                  'Aún no tienes historial',
                   style: TextStyle( 
                     color: Color.fromRGBO(63, 66, 66, 0.8),
                   ),
                )
              ],
            )
          );
      },
    );
  }





}
