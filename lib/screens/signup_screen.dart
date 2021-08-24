import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marianamodas/models/user_model.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _passControllerValidate = TextEditingController();
  final _phoneNumber = TextEditingController();

  final _streetAddress = TextEditingController();
  final _numberAddress = TextEditingController();
  final _neighborhoodAddress = TextEditingController();
  final _cityAddress = TextEditingController();
  final _postcodeAddress = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var maskFormatterPhone = new MaskTextInputFormatter(mask: ' (##) ####-####', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterCPF = new MaskTextInputFormatter(mask: ' ###.###.###-##', filter: { "#": RegExp(r'[0-9]') });

  int group = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          actions: <Widget>[

            FlatButton(
                onPressed: (){

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));

                },
                child: Text("Login",
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                )
            )

          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[

                  Text(

                    "Informações Pessoais",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                  ),
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: "Nome Completo",
                    ),
                    validator: (text){
                      if(text.isEmpty) return "Nome Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _cpfController,
                    inputFormatters: [maskFormatterCPF],
                    decoration: InputDecoration(
                      hintText: "CPF",
                    ),
                    validator: (text){
                      if(text.isEmpty) return "CPF Inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail, ex.: example@example.com"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha inválida!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passControllerValidate,
                    decoration: InputDecoration(
                        hintText: "Confirmação de Senha",
                    ),
                    obscureText: true,
                    validator: (text){

                      if(text.isEmpty || _passController.text != _passControllerValidate.text) return "As senhas não são iguais!";

                      },
                  ),

                  SizedBox(height: 16.0,),


                  TextFormField(

                    controller: _phoneNumber,
                    inputFormatters: [maskFormatterPhone],
                    decoration: InputDecoration(

                      hintText: "Telefone para contato - (99) 9999-9999"

                    ),

                    validator: (text){

                      if(text.isEmpty) return "Campo obrigatório";

                    },

                  ),

                  SizedBox(height: 40.0,),
                  Text(
                    "Endereço",
                    style: TextStyle(

                      fontSize: 18,
                      fontWeight: FontWeight.bold

                    ),
                  ),
                  Divider(color: Colors.black,),

                  TextFormField(

                    controller: _streetAddress,
                    decoration: InputDecoration(

                        hintText: "ex.: rua da consolação"

                    ),

                    validator: (text){

                      if(text.isEmpty) return "Campo obrigatório";

                    },

                  ),
                  TextFormField(

                    controller: _numberAddress,
                    decoration: InputDecoration(

                        hintText: "Número"

                    ),

                    validator: (text){

                      if(text.isEmpty) return "Campo obrigatório";

                    },

                  ),
                  TextFormField(

                    controller: _neighborhoodAddress,
                    decoration: InputDecoration(

                        hintText: "Digite aqui seu bairro"

                    ),

                    validator: (text){

                      if(text.isEmpty) return "Campo obrigatório";

                    },

                  ),
                  TextFormField(

                    controller: _cityAddress,
                    decoration: InputDecoration(

                        hintText: "Digite aqui sua cidade"

                    ),

                    validator: (text){

                      if(text.isEmpty) return "Campo obrigatório";

                    },

                  ),
                  TextFormField(

                    controller: _postcodeAddress,
                    decoration: InputDecoration(

                        hintText: "Digite o código postal"

                    ),

                    validator: (text){

                      if(text.isEmpty) return "Campo obrigatório";

                    },

                  ),

                  SizedBox(height: 40.0,),

                  Divider(color: Colors.black,),

                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Criar Conta",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "cpf" : _cpfController.text,
                            "email": _emailController.text,
                            "phone": _phoneNumber.text,
                            "street" : _streetAddress.text,
                            "number" : _numberAddress.text,
                            "neighborhood" : _neighborhoodAddress.text,
                            "city" : _cityAddress.text,
                            "postcode" : _postcodeAddress.text

                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}

