import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marianamodas/models/user_model.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateUserScreen extends StatefulWidget {

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {

  final _nameController = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _cpf = TextEditingController();
  final _streetAddress = TextEditingController();
  final _numberAddress = TextEditingController();
  final _neighborhoodAddress = TextEditingController();
  final _cityAddress = TextEditingController();
  final _postcodeAddress = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var maskFormatterPhone = new MaskTextInputFormatter(mask: ' (##) ####-####', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterCPF = new MaskTextInputFormatter(mask: ' ###.###.###-##', filter: { "#": RegExp(r'[0-9]') });


  Map<String, dynamic> userData = {"name" : null};
  int fields = 0;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Editar Conta"),
          centerTitle: true,

        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.isLoading){

              return Center(child: CircularProgressIndicator(),);

            }

            else{

              return StreamBuilder(
                  stream: Firestore.instance.collection("users").document(model.getUID()).snapshots(),

                  builder: (context,snapshot){

                    if(!snapshot.hasData || snapshot.data == null)
                      return Center(child: CircularProgressIndicator(),);

                    return Form(
                      key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.all(16.0),
                        children: <Widget>[

                          Container(

                            padding: EdgeInsets.all(8),

                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[

                                Text(

                                  "Dados do Usuário",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),

                                ),

                                Text("Nome: " + snapshot.data["name"]),

                                Text("CPF: " + snapshot.data["cpf"]),

                                Text("Telefone: " + snapshot.data["phone"]),

                                SizedBox(height: 20,),

                                Text("Endereço"),

                                Divider(color: Colors.black,),

                                Text("Rua: " + snapshot.data["street"]),

                                Text("Número: " + snapshot.data["number"]),

                                Text("Bairro: " + snapshot.data["neighborhood"]),

                                Text("Cidade: " + snapshot.data["city"]),

                                Text("CEP: " + snapshot.data["postcode"]),


                                Divider(color: Colors.black,),

                              ],

                            ),

                          ),

                          Divider(color: Colors.black,),

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

                          ),

                          SizedBox(height: 16.0,),

                          TextFormField(

                            controller: _cpf,
                            inputFormatters: [maskFormatterCPF],
                            decoration: InputDecoration(

                                hintText: "Digite seu CPF"

                            ),



                          ),

                          SizedBox(height: 16.0,),

                          TextFormField(

                            controller: _phoneNumber,
                            inputFormatters: [maskFormatterPhone],
                            decoration: InputDecoration(

                                hintText: "Telefone para contato - (99) 9999-9999"

                            ),



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



                          ),
                          TextFormField(

                            controller: _numberAddress,
                            decoration: InputDecoration(

                                hintText: "Número"

                            ),



                          ),
                          TextFormField(

                            controller: _neighborhoodAddress,
                            decoration: InputDecoration(

                                hintText: "Digite aqui seu bairro"

                            ),



                          ),
                          TextFormField(

                            controller: _cityAddress,
                            decoration: InputDecoration(

                                hintText: "Digite aqui sua cidade"

                            ),



                          ),
                          TextFormField(

                            controller: _postcodeAddress,
                            decoration: InputDecoration(

                                hintText: "Digite o código postal"

                            ),

                          ),

                          SizedBox(height: 40.0,),

                          Divider(color: Colors.black,),

                          SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                              child: Text("Atualizar Conta",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              onPressed: (){

                                _infoUser(snapshot);

                                userData["email"] = snapshot.data["email"];

                                model.updateUser(
                                    userData: userData,
                                    onSuccess: _onSuccess,
                                    onFail: _onFail
                                );



                              },
                            ),
                          ),
                        ],
                      ),
                    );

                  }

              );

            }
          },
        )
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário editado com sucesso!"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });

    fields = 0;
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao editar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

  void _infoUser(var snapshot){

    if(_nameController.text.length > 0){

      userData["name"] = _nameController.text;

    }

    if(_nameController.text.length <= 0){

      userData["name"] = snapshot.data["name"];

    }

    if(_phoneNumber.text.length > 0){

      userData["phone"] = _phoneNumber.text;


    }
    if(_phoneNumber.text.length <= 0){

      userData["phone"] = snapshot.data["phone"];

    }

    if(_streetAddress.text.length > 0){

      userData["street"] = _streetAddress.text;


    }
    if(_streetAddress.text.length <= 0){

      userData["street"] = snapshot.data["street"];

    }

    if(_numberAddress.text.length > 0){

      userData["number"] = _numberAddress.text;


    }
    if(_numberAddress.text.length <= 0){

      userData["number"] =snapshot.data["number"];

    }
    if(_neighborhoodAddress.text.length > 0){

      userData["neighborhood"] = _neighborhoodAddress.text;


    }
    if(_neighborhoodAddress.text.length <= 0){

      userData["neighborhood"] = snapshot.data["neighborhood"];

    }

    if(_cityAddress.text.length > 0){

      userData["city"] = _cityAddress.text;


    }
    if(_cityAddress.text.length <= 0){

      userData["city"] = snapshot.data["city"];

    }

    if(_postcodeAddress.text.length > 0){

      userData["postcode"] = _postcodeAddress.text;


    }
    if(_postcodeAddress.text.length <= 0){

      userData["postcode"] = snapshot.data["postcode"];

    }

  }

}