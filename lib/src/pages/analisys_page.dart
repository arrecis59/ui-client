import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:ui_client/src/preferecias_usuario/preferencias_usuario.dart';
import 'package:ui_client/src/providers/analisis_provider.dart';
import 'package:ui_client/src/utils/utils.dart';

class AnalisysPage extends StatefulWidget {
  AnalisysPage({Key key}) : super(key: key);

  @override
  _AnalisysPageState createState() => _AnalisysPageState();
}

class _AnalisysPageState extends State<AnalisysPage> {

  File foto;
  String status = '';
  bool _isLoading = false;
  bool _isEnable = false; //boton analisis
  bool _isUpload = false;
  var enfermedad;
  var sintomas;
  var statusInsert;

  AnalasisProvider analisisProv = AnalasisProvider();

  AnalasisProvider analisiProvider = AnalasisProvider();


  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                _botonTomar(),
                _botonSeleccionar(),
              ],
            ),
          )
        ],
      ),
      body: Stack(children: <Widget>[
        _isUpload ? _vistaAnalisis() :  _vista(),
        _crearLoading()
      ],)
    );
  }


  Widget _vista(){
    return Container(
      child: SingleChildScrollView(
        child: Column( 
          children: <Widget>[
           _mostrarImagen(),
           _botonAnalisis()
          ],
        ),
      ),
    );
  }

  Widget _vistaAnalisis(){
    return Container(
      child: SingleChildScrollView(
        child: Column( 
          children: <Widget>[
            
            Text(enfermedad.toString()),
            Text(sintomas.toString()),
            Text(statusInsert.toString()),

          ],
        ),
      ),
    );
  }  


  Widget _botonTomar() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.camera),
        color: Colors.white,
        onPressed: _tomarImagen,
      ),
    );
  }

  Widget _botonSeleccionar() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.photo_size_select_actual),
        color: Colors.white,
        onPressed: _seleccionarImagen,
      ),
    );
  }

  Widget _mostrarImagen() {

    double _width = MediaQuery.of(context).size.width;

    if (foto != null) {
      return Container( 
        margin: EdgeInsets.only(top: 10.0),
        child: Image.file(
          File(foto.path),
          width: _width,
          height: 300.0,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Container( 
        margin: EdgeInsets.only(top: 20.0),
        child: Image(
          image: AssetImage('assets/no-image.png'),
          height: 300.0,
          fit: BoxFit.cover
        ),
      );
    }
  }


  Widget _botonAnalisis(){
    return Container( 
      margin: EdgeInsets.symmetric(vertical: 15.0),
      child: ButtonTheme( 
        minWidth: MediaQuery.of(context).size.width / 2,
        height: 40.0,
        child: RaisedButton( 
          color:  Colors.green.shade300,
          textColor: Colors.white,
          child: Text( 
            'Iniciar análisis'
          ),
          onPressed: _isEnable ? _iniciarAnalisis : null,
        ),
      ),
    );
  }

  void _iniciarAnalisis() async{

    if (foto != null) {
      
      _setButtonStatus(false);
      _setLoading(true);

      String resp = await analisiProvider.subirImagen(foto);


      if (resp != null) {

        enfermedad = await analisiProvider.detectarEnfermedad(resp);

        var objEnfermedad = enfermedad[0]['name'];

        sintomas = await analisiProvider.consultarSintomas(objEnfermedad);
        print(sintomas);

        statusInsert = await analisiProvider.insertarHistorial(prefs.email, resp, objEnfermedad, 'Media', '27/10/2019', 10.2, 'Guatemala, City');
        print(sintomas);


       _setLoading(false);
       _setUpload(true);
       mostrarAlerta(context, 'Imagen cargada exitosamente!', 'Info');


      }else{
        _setLoading(false);
      }
    }
  }

  _setButtonStatus(bool status){
    setState(() {
      _isEnable = status;
    });
  }




  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          )
        ],
      );
    } else {
      return Container();
    }
  }

  _procesarImagen(ImageSource origin) async {
    foto = await ImagePicker.pickImage(source: origin);
    
    if(foto != null){
      _setButtonStatus(true);
    }else{
      setState(() {});
    }

  }

  _seleccionarImagen() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarImagen() async {
    _procesarImagen(ImageSource.camera);
  }


  void _setLoading(bool status) {
    setState(() {
      _isLoading = status;
    });
  }

   void _setUpload(bool status) {
    setState(() {
      _isUpload = status;
    });
  }


}
