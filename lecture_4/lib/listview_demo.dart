import 'package:flutter/material.dart';
const double textSize = 22;
class ListviewDemo extends StatelessWidget{
  const ListviewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index){
        return Text("Item # $index");
      }, 
      separatorBuilder: (context, index){
        return Divider(thickness: 5  ,);
      }, 
      itemCount: 5
    );
  }
}