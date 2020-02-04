import 'package:flutter_architecture_template/domain/usecases/github/get_user.dart';
import 'package:flutter_architecture_template/presentation/blocs/main/main_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  MainPageBloc bloc;

  setUp(() {
    bloc = MainPageBloc();
  });

  test('initialState should be GithubUserStateInitial', () {
    // assert
    expect(bloc.initialState, equals(MainPageState(0)));
  });

  group('GoToSecondPageEvent then GoToFirstPageEvent', () {
    test(
      'should emit [FirstPageState, SecondPageState, FirstPageState]',
      () async {
        // assert later
        final expected = [
          MainPageState(0),
          MainPageState(1),
          MainPageState(0),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GoToPageEvent(1));
        bloc.add(GoToPageEvent(0));
        await future;
      },
    );
  });

  group('GoToSecondPageEvent', () {
    test(
      'should emit [FirstPageState, SecondPageState]',
      () async {
        // assert later
        final expected = [MainPageState(0), MainPageState(1)];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GoToPageEvent(1));
        await future;
      },
    );
  });
}

class MockGetGithubUser extends Mock implements GetGithubUser {}
