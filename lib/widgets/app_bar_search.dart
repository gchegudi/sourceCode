import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/providers/search_provider.dart';
import 'dart:math';

import 'package:provider/provider.dart';
class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  Function onClickCategory;
  Function onClickCity;
  Function onClickSubmit;
  TextEditingController searchtextController;
  TextEditingController citytextController;
  TextEditingController categorytextController;

  @override
  AppBarSearch(
      {Key key,
      this.onClickCategory,
      this.onClickCity,
      this.searchtextController,
      this.citytextController,
      this.categorytextController,
      this.onClickSubmit})
      : preferredSize = Size.fromHeight(kToolbarHeight + 200),
        super(key: key);

  @override
  _AppBarSearchState createState() => _AppBarSearchState();

  @override
  final Size preferredSize;
}

class _AppBarSearchState extends State<AppBarSearch> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, value,child) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(
            children: [
              AppBar(title: Text("Search"),),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextField(
                  controller: widget.searchtextController,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Colors.grey[800],
                      ),
                      hintText: "Search...",
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _getCategoryList(),


              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    widget.onClickSubmit();

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search,color: Colors.white,),
                      SizedBox(width: 5,),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  _getCategoryList(){
    return   Container(color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (index,context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Container(

              width: 36,
              height: 36,
              child: Icon(Icons.person,color: Colors.white,),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
               // shape: BoxShape.circle,
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              ),
            ),
          );

        },
        itemCount: 10,
      ),

    );
  }


}
