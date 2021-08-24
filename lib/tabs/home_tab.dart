import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marianamodas/datas/product_data.dart';
import 'package:marianamodas/screens/product_screen.dart';



class HomeTab extends StatelessWidget {

  ProductData product = null;

  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 4, 125, 141),
            Color.fromARGB(255, 255, 255, 255)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                .collection("news").orderBy("date").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map(
                      (doc){
                        return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                      }
                    ).toList(),
                    children: snapshot.data.documents.map(
                      (doc){
                        return GestureDetector(
                          
                          onTap: (){

                            product = ProductData.fromDocument(doc);

                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>ProductScreen(product))
                            );

                          },

                          child: Card(

                            clipBehavior: Clip.antiAliasWithSaveLayer,

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: <Widget>[

//                                FadeInImage.memoryNetwork(
//                                  placeholder: kTransparentImage,
//                                  image: doc.data["images"][0],
//                                  fit: BoxFit.cover,
//                                ),
                                AspectRatio(
                                  aspectRatio: 1.38,
                                  child: Image.network(
                                    doc.data["images"][0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(

                                    child: Container(

                                      padding: EdgeInsets.all(4.0),

                                      child: Column(

                                        children: <Widget>[

                                          Text(
                                            doc.data["title"],
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                                          ),

                                          Text(

                                            "R\$ ${doc.data["price"].toStringAsFixed(2)}",
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold),
                                          )

                                        ],

                                      ),

                                    )

                                ),

                              ],

                            )

                          )

                        );
                      }
                    ).toList(),
                  );
              },
            )
          ],
        )
      ],
    );
  }
}
