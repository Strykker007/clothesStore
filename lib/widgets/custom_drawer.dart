import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marianamodas/models/user_model.dart';
import 'package:marianamodas/screens/login_screen.dart';
import 'package:marianamodas/screens/update_user_screen.dart';
import 'package:marianamodas/tiles/drawer_tile.dart';

import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  DocumentSnapshot userInfo;

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Mariana\nModas",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              model.isLoggedIn() ? GestureDetector(

                                child: Text(

                                  "Editar Informa????es",

                                  style: TextStyle(

                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold

                                  ),

                                ),

                                onTap: (){

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateUserScreen()));

                                },

                              ) : Text(""),

                              Text("Ol??, ${!model.isLoggedIn() ? " " : model.userData["name"]}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Entre ou cadastre-se >"
                                  : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>LoginScreen())
                                    );
                                  else
                                    model.signOut();
                                  },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "In??cio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              //DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 2),
              DrawerTile(Icons.help, "Contate-nos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}