import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  final states = [
    "",
    "Em preparação",
    "Em transporte",
    "Aguardando entrega",
    "Entregue"
  ];
  final DocumentSnapshot order;
  OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Card(
        child: ExpansionTile(
            key: Key(order.documentID),
            initiallyExpanded: order.data["status"] != 4,
            title: Text (
              "#${order.documentID.substring(order.documentID.length -7, order.documentID.length)} - "
              "${states[order.data["status"]]}",
              style: TextStyle(color: order.data["status"] != 4 ? Colors.grey[850] : Colors.green),
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8,  top: 0, right: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OrderHeader(order),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: order.data["products"].map<Widget>((p) {
                         return ListTile(
                           title: Text(p["product"]["title"] + " " + p["size"]),
                           subtitle: Text(p["category"] + "/" + p["pid"]),
                           trailing: Text (
                             p["quantity"].toString(),
                             style: TextStyle(fontSize: 20),
                           ),
                           contentPadding: EdgeInsets.zero,
                         );
                      }).toList(),


                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Firestore.instance.collection("users").document(order["clientId"])
                              .collection("orders").document(order.documentID).delete();
                            order.reference.delete();
                          },
                          textColor: Colors.red,
                          child: Text("Excluir"),
                        ),
                        FlatButton(
                          onPressed: order.data["status"] > 1 ? () {
                            order.reference.updateData({"status" : order.data["status"] - 1});
                          } : null,
                          textColor: Colors.grey[850],
                          child: Text("Voltar"),
                        ),
                        FlatButton(
                          onPressed: order.data["status"] < 4 ? () {
                            order.reference.updateData({"status" : order.data["status"] + 1});
                          } : null,
                          textColor: Colors.green,
                          child: Text("Avançar"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
}
