import 'package:flutter_tube/api.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get insearch => _searchController.sink;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
       _videosController.sink.add([]);
       videos = await api.search(search);
    } else {
       videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
     _videosController.close();
     _searchController.close();
  }

}