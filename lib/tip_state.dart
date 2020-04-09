import 'package:firestoreblocapp/model.dart';

abstract class TipState {}

class TipLoadingState extends TipState {}

class TipHasDataState extends TipState {
  final List<Tip> data;

  TipHasDataState(this.data);
}
