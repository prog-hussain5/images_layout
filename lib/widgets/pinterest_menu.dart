// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButtom {
  final Function onPressed;
  final IconData icon;

  PinterestButtom({
    required this.onPressed,
    required this.icon});

}

class PinterestMenu extends StatelessWidget {

  final bool mostrar;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  final List<PinterestButtom> items;

  const PinterestMenu({super.key, 
    this.mostrar = true,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.blueGrey,
    required this.items
  });


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: (mostrar) ? 1 : 0,
                          child: Builder(
                            builder: (BuildContext context){
                              Provider.of<_MenuModel>(context).backgroundColor = backgroundColor;
                              Provider.of<_MenuModel>(context).activeColor = activeColor;
                              Provider.of<_MenuModel>(context).inactiveColor = inactiveColor;

                              return _PinterestMenuBackground(
                                child: _MenuItems(items)
                                );
                            },
                                                      
                            ),
                          ),
            );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  
  final Widget child;

  const _PinterestMenuBackground({required this.child,});

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(

      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5
          )
        ]
      ),

      child: child,
    );
  }
}

class  _MenuItems extends StatelessWidget {

  final List<PinterestButtom> menuItems;

  const _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (i) => _PinterestMenuBottom(i, menuItems[i]))
    );
  }
}

class _PinterestMenuBottom extends StatelessWidget {

  final int index;
  final PinterestButtom item;

  const _PinterestMenuBottom(this.index, this.item);

  @override
  Widget build(BuildContext context) {

    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;

                        
    final menuModel = Provider.of<_MenuModel>(context);

    return GestureDetector(
      onTap: (){
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: (itemSeleccionado == index) ? 35 : 25,
          color: (itemSeleccionado == index) ? menuModel.activeColor: menuModel.inactiveColor
          ),
          ),
      );
  }
}

class _MenuModel with ChangeNotifier {

  int _itemSeleccionado = 0;

  Color backgroundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;

  int get itemSeleccionado => _itemSeleccionado;

  set itemSeleccionado (int index){
    _itemSeleccionado = index;
    notifyListeners();
  }

}