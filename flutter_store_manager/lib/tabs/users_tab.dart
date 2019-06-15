import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/blocs/user_bloc.dart';
import 'package:flutter_store_manager/widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of <UserBloc>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Pesquisar",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search, color: Colors.white),
              border: InputBorder.none,
            ),
            onChanged: _userBloc.onChangedSearch,
          ),
        ),
        Expanded(
          child: StreamBuilder<List>(
            stream: _userBloc.outUsers,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.deepOrangeAccent),
                ),
                );
              } else if (snapshot.data.length == 0) {
                return Center(
                  child: Text("Nenhum usuário encontrado.",
                    style: TextStyle(
                        color: Colors.orangeAccent
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(snapshot.data[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: snapshot.data.length
                );
              }
            }
          ),
        )
      ],
    );
  }
}
