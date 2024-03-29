import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/blocs/orders_bloc.dart';
import 'package:flutter_store_manager/blocs/user_bloc.dart';
import 'package:flutter_store_manager/tabs/orders_tab.dart';
import 'package:flutter_store_manager/tabs/users_tab.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;
  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
     super.initState();
     _pageController = PageController();
     _userBloc = UserBloc();
     _ordersBloc = OrdersBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.deepOrangeAccent,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white54)
          )
        ),
        child: BottomNavigationBar(
            currentIndex: _page,
            onTap: (p) {
              _pageController.animateToPage(
                  p,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease
              );
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: Text("Clientes")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text("Pedidos")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_list),
                  title: Text("Produtos")
              ),
            ]
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc> (
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc> (
            bloc: _ordersBloc,
            child: PageView(
              controller: _pageController,
              onPageChanged: (p) {
                setState(() {
                  _page = p;
                });
              },
              children: <Widget>[
                //Container(color: Colors.red),
                UsersTab(),
                OrdersTab(),
                Container(color: Colors.blue),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _floatingButton() {
    switch(_page) {
      case 0:
        return null;
      case 1:
        return SpeedDial(
           child: Icon(Icons.sort),
          backgroundColor: Colors.deepOrangeAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children:  [
            SpeedDialChild(
               child: Icon(Icons.arrow_downward,
                 color: Colors.deepOrange
               ),
               backgroundColor: Colors.white54,
               label: "Entregues abaixo.",
               labelStyle: TextStyle(
                 fontSize: 14
               ),
               onTap: () {
                 _ordersBloc.setOrderCriteria(sortCriteria.READY_LAST);
               }
            ),
            SpeedDialChild(
                child: Icon(Icons.arrow_upward,
                    color: Colors.deepOrange
                ),
                backgroundColor: Colors.white54,
                label: "Entregues acima.",
                labelStyle: TextStyle(
                    fontSize: 14
                ),
                onTap: () {
                   _ordersBloc.setOrderCriteria(sortCriteria.READY_FIRST);
                }
            ),
          ],
        );
    }
  }
}
