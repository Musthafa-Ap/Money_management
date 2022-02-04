import 'package:flutter/material.dart';
import 'package:sample/home_screen.dart';
class  BottomNavigation extends StatelessWidget {
  const BottomNavigation ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.SelectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          currentIndex: updatedIndex,
          onTap: (index){
            ScreenHome.SelectedIndexNotifier.value = index;
          },
            items: const[
                BottomNavigationBarItem (
                  icon: Icon( Icons.home),
                  label : "Transactions"
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: "Catagory")
          ],
          );
      }
    );
    
  }
}