import 'package:flutter/material.dart';
import 'package:sample/add_transaction/screen_add_transaction.dart';
import 'package:sample/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample/models/catagory/catagory_model.dart';
import 'package:sample/models/transaction/transaction_model.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CatagoryTypeAdapter().typeId)){
    Hive.registerAdapter(CatagoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CatagoryModelAdapter().typeId)){
    Hive.registerAdapter(CatagoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:  ScreenHome(),
      routes: {
        ScreenAddTransaction.routeName:(ctx)=>const ScreenAddTransaction(),
      },
    );
  }
}

