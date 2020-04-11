import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

abstract class TipRepository {
  Stream<List<Tip>> tips();

  void dispose();

  void refresh();
}

class TipRepositoryFirestore extends TipRepository {

  final _loadedData = StreamController<List<Tip>>();

  final _cache = List<Tip>();

  @override
  void dispose() {
    _loadedData.close();
  }

  @override
  void refresh() {
    if (Firestore.instance != null) {
      Firestore.instance
          .collection('tips')
          .snapshots()
          .listen((techniques) {
        _cache.clear();
        techniques.documents.forEach((tip) {
          final doc = tip.data;
          _cache.add(
              Tip(doc["tipName"], doc["shortTipText"], doc["fullTipText"]));
        });

        _loadedData.add(_cache);
      });
    }
  }

  @override
  Stream<List<Tip>> tips() => _loadedData.stream;

}

class TipRepositoryMemory extends TipRepository {
  StreamController<List<Tip>> _tips = StreamController();

  @override
  void refresh() {
    _tips.add(new List()
      ..add(Tip("First note", "This is the short description",
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")));
  }

  @override
  void dispose() {
    _tips.close();
  }

  @override
  Stream<List<Tip>> tips() => _tips.stream;
}
