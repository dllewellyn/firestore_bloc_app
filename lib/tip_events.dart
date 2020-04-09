import 'package:firestoreblocapp/model.dart';

abstract class TipEvents {}

class HasDataEvent extends TipEvents {
  final List<Tip> data;

  HasDataEvent(this.data);
}
