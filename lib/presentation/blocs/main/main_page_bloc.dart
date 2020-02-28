import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

@prod
@injectable
class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  @override
  MainPageState get initialState => MainPageState(0);

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {
    if (event is GoToPageEvent) {
      yield MainPageState(event.index);
    }
  }
}
