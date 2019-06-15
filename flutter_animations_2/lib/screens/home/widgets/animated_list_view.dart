import 'package:flutter/material.dart';
import 'package:flutter_animations_2/screens/home/widgets/list_data.dart';

class AnimatedListView extends StatelessWidget {

  final Animation<EdgeInsets> listSlidePosition;

  AnimatedListView({@required this.listSlidePosition});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListData(
          title: "Flutter",
          subtitle: "Curso da Udemy",
          image: AssetImage("images/perfil.jpg"),
          margin: listSlidePosition.value * 2,
        ),
        ListData(
          title: "Música",
          subtitle: "Harmonia Funcional",
          image: AssetImage("images/perfil.jpg"),
          margin: listSlidePosition.value * 1,
        ),
        ListData(
          title: "Teatro",
          subtitle: "Casa de Cultura Rio",
          image: AssetImage("images/perfil.jpg"),
          margin: listSlidePosition.value * 0,
        ),
      ],
    );
  }
}
