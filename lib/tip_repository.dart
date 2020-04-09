import 'dart:async';

import 'model.dart';

abstract class TipRepository {
  Stream<List<Tip>> tips();

  void dispose();

  void refresh();
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
