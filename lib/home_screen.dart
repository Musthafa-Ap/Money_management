import 'package:flutter/material.dart';
import 'package:sample/add_transaction/screen_add_transaction.dart';
import 'package:sample/bottom_nav.dart';
import 'package:sample/catagory_add_popup.dart';
import 'package:sample/screen_catagory.dart';
import 'package:sample/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> SelectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTransaction(), ScreenCatagory()];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("MONEY MANAGER"),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: SelectedIndexNotifier,
              builder: (BuildContext ctx, int updatedIndex, Widget? _) {
                return _pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            if (SelectedIndexNotifier.value == 0) {
              Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
              print("Transaction page added");
            } else {
              showCatagoryAddPopup(context);
              print("Catagory page added");

              // final _sample = CatagoryModel(name: 'Travel', type: CatagoryType.expense, id: DateTime.now().microsecondsSinceEpoch.toString());
              // CatagoryDb().insertCatagory(_sample);
            }
          }),
    );
  }
}
