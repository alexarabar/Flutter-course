import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum sortCriteria {READY_FIRST, READY_LAST}

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _orders = [];
  Stream<List> get outOrders => _ordersController.stream;
  sortCriteria _criteria;

  OrdersBloc() {
     _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection("orders").snapshots().listen((snapshot) {
       snapshot.documentChanges.forEach((change) {
          String oid = change.document.documentID;
          switch (change.type) {
            case DocumentChangeType.added:
              _orders.add(change.document);
              break;
            case DocumentChangeType.modified:
              _orders.removeWhere((order) => order.documentID == oid);
              _orders.add(change.document);
              break;
            case DocumentChangeType.removed:
              _orders.removeWhere((order) => order.documentID == oid);
              break;
          }
       });
       _sort();
    });
  }

  void setOrderCriteria(sortCriteria criteria) {
    _criteria = criteria;
    _sort();
  }

  void _sort() {
     switch(_criteria) {
       case sortCriteria.READY_FIRST:
         _orders.sort((a,b) {
           int s1 = a.data["status"];
           int s2 = b.data["status"];
           if (s1 < s2) return 1;
           else if (s1 > s2) return -1;
           else return 0;
         });
         break;
       case sortCriteria.READY_LAST:
         _orders.sort((a,b) {
           int s1 = a.data["status"];
           int s2 = b.data["status"];
           if (s1 > s2) return 1;
           else if (s1 < s2) return -1;
           else return 0;
         });
         break;
     }
     _ordersController.add(_orders);
  }

  @override
  void dispose() {
     _ordersController.close();
  }

}