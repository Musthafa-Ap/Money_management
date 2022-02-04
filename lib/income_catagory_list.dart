import 'package:flutter/material.dart';
import 'package:sample/database/catagory/catagory_db.dart';
import 'package:sample/models/catagory/catagory_model.dart';

class IncomeCatagoryList extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: CatagoryDb().incomeCatagoryListListener, 
      builder: (BuildContext ctx, List<CatagoryModel> newList, Widget? _){
      return ListView.separated
    (itemBuilder: (BuildContext ctx,int index){
      final catagory = newList[index];
      return Card(
        child : ListTile(
        title: Text(catagory.name),
        trailing : IconButton(icon : Icon(Icons.delete),
        onPressed: ()
        {
        
          CatagoryDb.instance.deleteCatagory(catagory.id);
        },)
      )
      );
    }, 
    separatorBuilder: (BuildContext ctx,int index){
      return  const SizedBox(height: 10);
    },
    itemCount:newList.length);
    });
  }
}