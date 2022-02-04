import 'package:flutter/material.dart';
import 'package:sample/database/catagory/catagory_db.dart';
import 'package:sample/database/transactions/transaction_db.dart';
import 'package:sample/models/catagory/catagory_model.dart';
import 'package:sample/models/transaction/transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class  ScreenTransaction extends StatelessWidget {
  const ScreenTransaction ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CatagoryDb.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier, 
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _){
        return ListView.separated(
      physics:const BouncingScrollPhysics(),
      padding:const EdgeInsets.all(10),
      itemBuilder: (BuildContext ctx, int index){
        final _value = newList[index];
        return 

            Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  label: "Delete",
                  icon: Icons.delete,
                  onPressed: (ctx){
                      
                    TransactionDB.instance.deleteTransaction(_value.id!);
                  },
                

                )
              ]),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:_value.type == CatagoryType.income? Colors.green:Colors.red,
                    radius: 30,
                    child: Text(parseDate(_value.date),textAlign: TextAlign.center,),),
                  title: Text("RS ${_value.amount}"),
                  subtitle: Text(_value.catagory.name
                  ),
                ),
              ),
            );
         
      }, 
      separatorBuilder: (BuildContext ctx, int index){
        return const Divider(height: 10,);
      }, 
      itemCount: newList.length);
      }
      );
  }

  String parseDate(DateTime date){
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';



  }


}