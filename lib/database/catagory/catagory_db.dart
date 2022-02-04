import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sample/income_catagory_list.dart';
import 'package:sample/models/catagory/catagory_model.dart';



const CATAGORY_DB_NAME ='catagory-database';

abstract class CatagoryDbFunctions{
  Future<List<CatagoryModel>> getCatagories();
  Future<void> insertCatagory(CatagoryModel value);
  Future<void> deleteCatagory(String CatagoryID);
}



class CatagoryDb implements CatagoryDbFunctions{



//CatagoryDb uyde orotta object ellaayidathum use cheyyaan vendiyaanh ith cheyyunnath.
CatagoryDb._internal();
static CatagoryDb instance = CatagoryDb._internal();      
factory CatagoryDb(){
  return instance;
}




ValueNotifier<List<CatagoryModel>> incomeCatagoryListListener = ValueNotifier([]);
ValueNotifier<List<CatagoryModel>> expenseCatagoryListListener = ValueNotifier([]);

  @override
  Future<void> insertCatagory(CatagoryModel value)async {
    final _catagoryDB =await Hive.openBox<CatagoryModel>(CATAGORY_DB_NAME);
    await _catagoryDB.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CatagoryModel>> getCatagories()async{
    final _catagoryDB =await Hive.openBox<CatagoryModel>(CATAGORY_DB_NAME);
    return _catagoryDB.values.toList();
  }

  Future<void> refreshUI() async {
      final _allCatagories = await getCatagories();
      incomeCatagoryListListener.value.clear();
      expenseCatagoryListListener.value.clear();
     await Future.forEach(_allCatagories, (CatagoryModel catagory) {
        if(catagory.type == CatagoryType.income){
          incomeCatagoryListListener.value.add(catagory);
        }else{
          expenseCatagoryListListener.value.add(catagory);
        }
      });

   incomeCatagoryListListener.notifyListeners();
   expenseCatagoryListListener.notifyListeners();

  }

  @override
  Future<void> deleteCatagory(String CatagoryID) async{
    final _catagoryDB =await Hive.openBox<CatagoryModel>(CATAGORY_DB_NAME);
    await _catagoryDB.delete(CatagoryID);
    refreshUI();

    
  }
  
}