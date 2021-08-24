import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class aboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(

        children: <Widget>[
          
          Container(
            
            padding: EdgeInsets.all(16),
            
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
                
                Text(

                    "Queremos oferecer uma experiência ainda melhor para "
                        "nossos clientes: um app moderno e cheio do promoções.",
                  textAlign: TextAlign.justify,

                ),

                SizedBox(height: 20,),

                Text(
                    "Aproveite nossas ofertas exclusivas e nossos produtos e "
                        "serviços de onde estiver. Todos nossos produtos na palma "
                        "da sua mão! Não perca tempo peça logo seu produto!",
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 20,),

                Text(

                    "Por aqui o cliente é sempre prioridade!",
                  textAlign: TextAlign.justify,

                  style: TextStyle(

                    fontSize: 15,
                    fontWeight: FontWeight.bold

                  ),

                ),

                SizedBox(height: 20,),

                Divider(color: Colors.black,),

                SizedBox(height: 20,),

                Text(

                  "Mariana Modas",

                  textAlign: TextAlign.start,
                  style: TextStyle(

                    fontWeight: FontWeight.bold,
                    fontSize: 16

                  ),

                ),
                Text(

                    "Rua 102, n˚ 398 - Centro - Capinópolis - MG\n"
                    "Telefone: (34) 3263-1619\n"
                    "Whatsapp: (34) 99996-0072"

                ),

                SizedBox(height: 50,),

                Text("Versão 1.0")
                
              ],
              
            ),
            
          )

        ],

      ),

    );
  }
}
