import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/database/catagory/catagory_db.dart';
import 'package:sample/models/catagory/catagory_model.dart';



ValueNotifier<CatagoryType> selectedCatagoryNotifier = ValueNotifier(CatagoryType.expense);

final _nameEditingController = TextEditingController();

Future<void> showCatagoryAddPopup(BuildContext context) async{
 showDialog(context: context, builder: (ctx){
  return SimpleDialog(
    
    title: Text("Add Catagory"),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _nameEditingController,
         decoration: InputDecoration(
           border: OutlineInputBorder(),
           hintText:'Catagory Name'
         ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
RadioButton(title: 'Income', type: CatagoryType.income),
RadioButton(title: 'Expense', type: CatagoryType.expense),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: (){
            final _name = _nameEditingController.text;
            if(_name.isEmpty){
              return;
            }
            final _type = selectedCatagoryNotifier.value;
            final _catagory = CatagoryModel(name: _name, type: _type, id: DateTime.now().microsecondsSinceEpoch.toString());
            CatagoryDb.instance.insertCatagory(_catagory);
            Navigator.of(ctx).pop();  //melethe buildernte context thanne use cheyyanam.mate context pagente context aanh.
          }, 
          child: Text('Add')),
      )
    ],
  );
 });
}


class RadioButton extends StatelessWidget {

  final String title;
  final CatagoryType type;

  const RadioButton({ Key? key ,required this.title,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
           ValueListenableBuilder(
             valueListenable: selectedCatagoryNotifier,
              builder: (BuildContext ctx, CatagoryType newCatagory, Widget? _){
             return Radio<CatagoryType>(value: type, groupValue: newCatagory,
        onChanged: (value)
        {
          if(value == null){
            return;
          }
          selectedCatagoryNotifier.value = value;
          print(value);
        selectedCatagoryNotifier.notifyListeners();});
           }),




        Text(title),
      ]
      
    );
  }
}