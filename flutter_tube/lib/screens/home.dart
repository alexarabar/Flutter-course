import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favorites_bloc.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';
import 'package:flutter_tube/delegates/data_search.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:flutter_tube/screens/favorites.dart';
import 'package:flutter_tube/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.of<FavoritesBloc>(context).outFav,
                //initialData: {},
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                      return Text("${snapshot.data.length}");
                  } else {
                      return Container();
                  }
                }
            ),
          ),
          IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>Favorites())
                );
              },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                 bloc.insearch.add(result);
              }
            }
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
          stream: bloc.outVideos,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               return ListView.builder(
                 itemBuilder: (context, index) {
                   if (index < snapshot.data.length) {
                     return VideoTile(snapshot.data[index]);
                   } else if (index > 1){
                     bloc.insearch.add(null);
                     return Container(
                       height: 40,
                       width:  40,
                       alignment: Alignment.center,
                       child: CircularProgressIndicator(
                         valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                       ),
                     );
                   } else {
                     return Container();
                   }
                 },
                 itemCount: snapshot.data.length + 1,
               );
            } else {
               return Container();
            }
          }
      ),
    );
  }
}
