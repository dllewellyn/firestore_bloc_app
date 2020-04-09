import 'package:firestoreblocapp/tip_events.dart';
import 'package:firestoreblocapp/tip_repository.dart';
import 'package:firestoreblocapp/tip_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipBloc extends Bloc<TipEvents, TipState> {
  final TipRepository repository;

  TipBloc(this.repository) {
    repository.tips().listen((data) => add(HasDataEvent(data)));
  }

  @override
  TipState get initialState => TipLoadingState();

  @override
  Stream<TipState> mapEventToState(TipEvents event) async* {
    if (event is HasDataEvent) {
      yield TipHasDataState(event.data);
    }
  }

  @override
  Future<Function> close() {
    repository.dispose();
    return super.close();
  }
}
