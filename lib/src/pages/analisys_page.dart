import 'dart:ffi';
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
  bool _isEnableCargarImagen = false; //boton analisis
  bool _isEnableEnviarSintomas = true; //boton analisis

  bool _isStep1 = true;
  bool _isStep2 = false;
  bool _isStep3 = false;

  var enfermedad;
  var sintomas;
  var statusInsert;

  AnalasisProvider analisisProv = AnalasisProvider();

  AnalasisProvider analisiProvider = AnalasisProvider();

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          actions: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  _botonTomarFotografia(),
                  _botonSeleccionarImagen()
                ],
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            _determinarVista(),
            _crearLoading()
            ],
        ));
  }


  Widget _determinarVista(){

    Widget vista = Container();

    if(_isStep1){
      vista = _vistaPaso1();
    }else if(_isStep2){
      vista = _vistaPaso2();
    }else if(_isStep3){
      vista = _vistaPaso3();
    }

    return vista;
  }

  //VISTA PANTALLA 1
  Widget _vistaPaso1() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            _paso1(),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(185, 194, 194, 0.56),
                      blurRadius: 20.0,
                      offset: Offset(0, 10)
                  )
                ]),
                child: _mostrarImagen()
            ),
            _botonCargarImagen()
          ],
        ),
      ),
    );
  }

  //PASO 1
  Widget _paso1(){
    return Row( 
      children: <Widget>[
        Container( 
          margin: EdgeInsets.only(left: 20.0),
          child: ClipOval( 
            child: Container( 
              color: Colors.orange.shade400,
              width: 30.0,
              height: 30.0,
              child: Center( 
                child: Text(
                '1',
                  style: TextStyle( 
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ),
        ),
        ),
        Container( 
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
          ' Seleccionar o tomar de fotografía.',
            style: TextStyle( 
              color: Color.fromRGBO(63, 66, 66, 0.8),
              fontSize: 16,
              fontWeight: FontWeight.w300
            ),
          ),
        )
      ],
    );
  }

  //VISTA PANTALLA 2
  Widget _vistaPaso2() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            _paso2(),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(185, 194, 194, 0.56),
                      blurRadius: 20.0,
                      offset: Offset(0, 10)
                  )
                ]),
                child: Text('Poner aquí checkboxs')
            ),
            _botonEnviarSintomas()
          ],
        ),
      ),
    );
  }

  //PASO 2
  Widget _paso2(){
    return Row( 
      children: <Widget>[
        Container( 
          margin: EdgeInsets.only(left: 20.0),
          child: ClipOval( 
            child: Container( 
              color: Colors.orange.shade400,
              width: 30.0,
              height: 30.0,
              child: Center( 
                child: Text(
                '2',
                  style: TextStyle( 
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ),
        ),
        ),
        Container( 
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
          ' Seleccionar síntomas.',
            style: TextStyle( 
              color: Color.fromRGBO(63, 66, 66, 0.8),
              fontSize: 16,
              fontWeight: FontWeight.w300
            ),
          ),
        )
      ],
    );
  }

  //VISTA PANTALLA 3
  Widget _vistaPaso3() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            _paso3(),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(185, 194, 194, 0.56),
                      blurRadius: 20.0,
                      offset: Offset(0, 10)
                  )
                ]),
                child: Text('Poner aquí resultado análisis')
            ),
          ],
        ),
      ),
    );
  }

  //PASO 3
  Widget _paso3(){
    return Row( 
      children: <Widget>[
        Container( 
          margin: EdgeInsets.only(left: 20.0),
          child: ClipOval( 
            child: Container( 
              color: Colors.orange.shade400,
              width: 30.0,
              height: 30.0,
              child: Center( 
                child: Text(
                '3',
                  style: TextStyle( 
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ),
        ),
        ),
        Container( 
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
          ' Resultados del análisis.',
            style: TextStyle( 
              color: Color.fromRGBO(63, 66, 66, 0.8),
              fontSize: 16,
              fontWeight: FontWeight.w300
            ),
          ),
        )
      ],
    );
  }

  //MOSTRAR IMAGEN
  Widget _mostrarImagen() {
    if (foto != null) {
      return Container(
        child: Image.file(
          File(foto.path),
          height: 300.0,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        child: Image(
          image: AssetImage('assets/no-image.png'),
          height: 300.0,
          fit: BoxFit.cover,
        ),
      );
    }
  }


  //BOTON INICIAR ANALISIS
  Widget _botonCargarImagen(){
    return FlatButton( 
      color: Colors.blue.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Text(
        'Continuar',
        style: TextStyle( 
          color: _isEnableCargarImagen ? Colors.white : Colors.grey,
          fontSize: 16.0,
          fontWeight: FontWeight.w300
        ),
      ),
      onPressed: _isEnableCargarImagen ? _subirImagen: null,
    );
  }

  //BOTON INICIAR ANALISIS
  Widget _botonEnviarSintomas(){
    return FlatButton( 
      color: Colors.blue.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Text(
        'Continuar',
        style: TextStyle( 
          color: _isEnableEnviarSintomas ? Colors.white : Colors.grey,
          fontSize: 16.0,
          fontWeight: FontWeight.w300
        ),
      ),
      onPressed: _isEnableEnviarSintomas ? _enviarSintomas : null,
    );
  }

  //BOTON TOMAR FOTOGRAFIA
  Widget _botonTomarFotografia() {
    return IconButton(
      icon: Icon(Icons.camera),
      color: Colors.white,
      onPressed: _tomarImagen,
    );
  }

  //BOTON SELECCIONAR IMAGEN
  Widget _botonSeleccionarImagen() {
    return IconButton(
      icon: Icon(Icons.photo_size_select_actual),
      color: Colors.white,
      onPressed: _seleccionarImagen,
    );
  }

  //CREAR WIDGET DE CARGA
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


  //ENVIAR SINTOMAS
  _enviarSintomas() async{

      _setStep1(false);
      _setStep2(false);
      _setStep3(true);
  }

  //SUBIR IMAGEN
  _subirImagen() async{

     if (foto != null) {
      
      _setButtonCargarImagenStatus(false);
      _setLoading(true);

      String resp = await analisiProvider.subirImagen(foto);


      if (resp != null) {

        enfermedad = await analisiProvider.detectarEnfermedad(resp);

        var objEnfermedad = enfermedad[0]['name'];

        sintomas = await analisiProvider.consultarSintomas(objEnfermedad);
        print(sintomas);

        var now = DateTime.now();

        statusInsert = await analisiProvider.insertarHistorial(prefs.email, resp, objEnfermedad, 'Media', '${now.day}/ ${now.month}/ ${now.year}', 10.2, 'Guatemala, City');
        print(sintomas);

      //set variables de control
       _setLoading(false);

      //set paso 2 activado
      _setStep1(false);
      _setStep2(true);


      }else{
        _setLoading(false);
        mostrarAlerta(context, 'Error al cargar fotografía intentelo nuevamente', 'Info');
        setState(() {});
      }

    }

  }

  //LLENA LA VARIABLE FOTO CON EL SOURCE
  _procesarImagen(ImageSource origin) async {

    foto = await ImagePicker.pickImage(source: origin);
    
    if (foto != null) {
      _setButtonCargarImagenStatus(true);
      setState(() {});
    } else {
      setState(() {});
    }
  }

  //SELECCIONAR IMAGEN DESDE GALERIA
  _seleccionarImagen() async {
    _procesarImagen(ImageSource.gallery);
  }

  //TOMAR IMAGEN
  _tomarImagen() async {
    _procesarImagen(ImageSource.camera);
  }

  //HABILITA O DESHABILITA EL BOTON CARGAR IMAGEN
  _setButtonCargarImagenStatus(bool status){
    setState(() {
      _isEnableCargarImagen = status;
    });
  }

  //HABILITA O DESHABILITA EL LOADING
  _setLoading(bool status) {
    setState(() {
      _isLoading = status;
    });
  }

  //CAMBIA EL ESTADO PASO 2
  _setStep2(bool status) {
    setState(() {
      _isStep2 = status;
    });
  }
  //CAMBIA EL ESTADO PASO 2
  _setStep1(bool status) {
    setState(() {
      _isStep1 = status;
    });
  }

  //CAMBIA EL ESTADO PASO 2
  _setStep3(bool status) {
    setState(() {
      _isStep3 = status;
    });
  }

}
