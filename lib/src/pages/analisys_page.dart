import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class AnalisysPage extends StatefulWidget {
  AnalisysPage({Key key}) : super(key: key);

  @override
  _AnalisysPageState createState() => _AnalisysPageState();
}

class _AnalisysPageState extends State<AnalisysPage> {

  File foto;
  String status = '';
  bool _isLoading = false;

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
        _vista(),
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
          onPressed: (){
           
          },
        ),
      ),
    );
  }

  _setStatus(String message) {
    setState(() {
      status = message;
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
    setState(() {});
  }

  _seleccionarImagen() async {
    _procesarImagen(ImageSource.gallery);
    _setStatus('');
  }

  _tomarImagen() async {
    _procesarImagen(ImageSource.camera);
    _setStatus('');
  }


  void _setLoading(bool status) {
    setState(() {
      _isLoading = status;
    });
  }


}
