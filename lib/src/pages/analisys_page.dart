
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
  bool _fallo1 = false;
  bool _iscameraEnable = true;
  bool _isGalleryEnable = true;

  int cantCheck = 0;

  List<bool> selectedList = [];
  String msgAnalisis = 'Conforme al análisis realizado, se ha determinado la enfermedad cutánea con mayor probabilidad de padecer'+
  ', tomando en cuenta signos y síntomas.';
  
  String msgNoAnalisis = 'No se ha podido finalizar con el análisis debido a que el grado de efectividad no es mayor o igual al 70%'+
  ', esto porque no presenta el mínimo de síntomas necesarios para el análisis.';

  String msgPrevencion = 'Por favor, visite nuestra sección de información importante, para contactar con un especialista.';


  var enfermedad;
  var sintomas;
  var urlImg;



  AnalasisProvider analisisProv = AnalasisProvider();

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: Text(
            'Análisis de enfermedades',
            style: TextStyle( 
              fontSize: 15.0,
              color: Colors.white
            ),
          ),
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
              _determinarVista()
            ],
        )
      );
  }


  Widget _determinarVista(){

    Widget vista = Container();

    if(_isStep1){
      vista = _vistaPaso1();
    }else if(_isStep2){
      vista = _vistaPaso2();
    }else if(_isStep3){
      vista = _vistaPaso3();
    }else if(_fallo1){
      vista = _vistaFallo1();
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
                child: Stack( 
                  children: <Widget>[
                    _mostrarImagen(),
                    _crearLoading()
                  ],
                )
            ),
            _botonCargarImagen(),
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
          ' Seleccionar o tomar fotografía.',
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
    return Column( 
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
       _paso2(),
       Expanded(
         child: _crearCheckBox(),
       ),
       _botonEnviarSintomas()
      ],
    );
  }

  //GENERAR CHECKBOX
 Widget _crearCheckBox() {

    return FutureBuilder(

      future: analisisProv.consultarSintomas(enfermedad[0]['name']),
      builder: (BuildContext context, snapshot) {

        if (snapshot.hasData) {
          
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i){

              //Numero de checkbox
              cantCheck = snapshot.data.length;
              selectedList.add(false);

              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(top: 12.0),
                decoration: BoxDecoration( 
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow( 
                      color: Color.fromRGBO(185, 194, 194, 0.56),
                      blurRadius: 20.0,
                      offset: Offset(0.0, 10.0)
                    )
                  ]
                ),
                child: Column(
                  children: <Widget>[
                    Text(snapshot.data[i]),
                    Checkbox( 
                      onChanged: (bool value){
                        _setStatusList(value, i);
                      },
                      value: selectedList[i],
                    )
                  ],
                ),
              );
            },
          );

        } else {
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
        }
      },
    );
  }

  //PASO 2
  Widget _paso2(){
    return Row( 
      children: <Widget>[
        Container( 
          margin: EdgeInsets.only(left: 20.0),
          padding: EdgeInsets.symmetric(vertical: 20.0),
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


  Widget _vistaPaso3(){
        return Container( 
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView( 
        child: Center( 
          child: Column(
            children: <Widget>[
              _paso3(),
              _card1(),
              _card2(),
              _card3(),
              _botonRegresar()
            ],
          ),
        ),
      ),
    );
  }


  Widget _vistaFallo1(){
        return Container( 
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView( 
        child: Center( 
          child: Column(
            children: <Widget>[
              _paso3(),
              _cardFallo1(),
              _botonRegresar()
            ],
          ),
        ),
      ),
    );
  }
 

 Widget _cardFallo1(){
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding( 
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.warning, color: Colors.red.shade300,),
                          ),
                          Text(
                          'Análisis incompleto',
                          textAlign: TextAlign.center,
                            style: TextStyle( 
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      msgNoAnalisis,
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

   Widget _card1(){
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding( 
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.check_circle, color: Colors.teal.shade300,),
                          ),
                          Text(
                          'Análisis finalizado',
                          textAlign: TextAlign.center,
                            style: TextStyle( 
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      msgAnalisis,
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


   Widget _card2(){
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding( 
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.insert_chart, color: Colors.blue.shade300,),
                          ),
                          Text(
                          'Enfermedad detectada',
                          textAlign: TextAlign.center,
                            style: TextStyle( 
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      enfermedad[0]['name'],
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

   Widget _card3(){
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding( 
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.info, color: Colors.red.shade300,),
                          ),
                          Text(
                          'Prevención',
                          textAlign: TextAlign.center,
                            style: TextStyle( 
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                      msgPrevencion,
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

  //PASO 3
  Widget _paso3(){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row( 
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
            ' Resultado del análisis.',
              style: TextStyle( 
                color: Color.fromRGBO(63, 66, 66, 0.8),
                fontSize: 16,
                fontWeight: FontWeight.w300
              ),
            ),
          )
        ],
      ),
    );
  }

  //MOSTRAR IMAGEN
  Widget _mostrarImagen() {



    if (foto != null) {
      
      return Container(
        alignment: Alignment.center,
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: FlatButton( 
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
      ),
    );
  }

  //BOTON REGRESAR
  Widget _botonRegresar(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: FlatButton( 
        color: Colors.blue.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Text(
          'Regresar',
          style: TextStyle( 
            color: _isEnableEnviarSintomas ? Colors.white : Colors.grey,
            fontSize: 16.0,
            fontWeight: FontWeight.w300
          ),
        ),
        onPressed: _regresarMenuAnalisis,
      ),
    );
  }

  //BOTON TOMAR FOTOGRAFIA
  Widget _botonTomarFotografia() {
    return IconButton(
      icon: Icon(Icons.camera),
      color: Colors.white,
      onPressed: _iscameraEnable ? _tomarImagen : null,
    );
  }

  //BOTON SELECCIONAR IMAGEN
  Widget _botonSeleccionarImagen() {
    return IconButton(
      icon: Icon(Icons.photo_size_select_actual),
      color: Colors.white,
      onPressed: _isGalleryEnable ? _seleccionarImagen: null,
    );
  }

  //CREAR WIDGET DE CARGA
  Widget _crearLoading() {
    if (_isLoading) {
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
    } else {
      return Container();
    }
  }


  //ENVIAR SINTOMAS
  _enviarSintomas() async{

      _setStep1(false);
      _setStep2(false);

      _setLoading(true);

      //cantidad de sintomas presentados
      double promSintomas = 0.0;
      int selected = 0;

      selectedList.forEach( (n) => { if(n) selected = selected+1 } );
      promSintomas = (selected * 100) / cantCheck;


      //selecciono almenos un sintoma
      if(promSintomas >= 33.33){


          var now = DateTime.now();

          var resp = await analisisProv.insertarHistorial(prefs.email, urlImg, enfermedad[0]['name'],
          'media','${now.day}/ ${now.month}/ ${now.year}', 10.2, 'Guatemala City');


          if(resp != null){

          _setStep3(true);
          _setLoading(false);

          }else{
            _setLoading(false);
          } 

      }else{ //no selecciono ningun sintoma

        _setfallo1(true);
      }

  }

  //SUBIR IMAGEN
  _subirImagen() async{

    _iscameraEnable = false;
    _isGalleryEnable = false;

     if (foto != null) {
      
      _setButtonCargarImagenStatus(false);
      _setLoading(true);

      String resp = await analisisProv.subirImagen(foto);


      if (resp != null) {

        urlImg = resp;

        enfermedad = await analisisProv.detectarEnfermedad(resp);

        // var now = DateTime.now();

        // statusInsert = await analisiProvider.insertarHistorial(prefs.email, resp, objEnfermedad, 'Media', '${now.day}/ ${now.month}/ ${now.year}', 10.2, 'Guatemala, City');
        // print(sintomas);

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

  //REGRESAR AL MENU DE ANALISIS
  _regresarMenuAnalisis(){

    selectedList.clear();
    _setLoading(false);
    foto = null;
    _setStep1(true);
    _setStep2(false);
    _setStep3(false);
    _setfallo1(false);

    _iscameraEnable = true;
    _isGalleryEnable = true;
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
    if(this.mounted){
      setState(() {
        _isEnableCargarImagen = status;
      });
    }
  }

  //HABILITA O DESHABILITA EL LOADING
  _setLoading(bool status) {
    if(this.mounted){
      setState(() {
        _isLoading = status;
      });
    }
  }

  //CAMBIA EL ESTADO PASO 2
  _setStep2(bool status) {
    if(this.mounted){
      setState(() {
        _isStep2 = status;
      });
    }
  }
  //CAMBIA EL ESTADO PASO 2
  _setStep1(bool status) {
    if(this.mounted){
      setState(() {
        _isStep1 = status;
      });
    }
  }

  //CAMBIA EL ESTADO PASO 2
  _setStep3(bool status) {
    if(this.mounted){
      setState(() {
        _isStep3 = status;
      });
    }
  }

   //FALLO 1
  _setfallo1(bool status) {
    if(this.mounted){
      setState(() {
        _fallo1 = status;
      });
    }
  }

  //CAMBIA EL ESTADO PASO 2
  _setStatusList(bool status, index) {
    if(this.mounted){
      setState(() {
        selectedList[index] = status; 
      });
    }
  }

}
