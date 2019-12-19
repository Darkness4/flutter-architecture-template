import 'package:flutter_architecture_template/domain/usecases/get_github_user.dart';
import 'package:flutter_architecture_template/presentation/blocs/main/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  MainPageBloc bloc;

  setUp(() {
    bloc = MainPageBloc();
  });

  test('initialState should be GithubUserStateInitial', () {
    // assert
    expect(bloc.initialState, equals(const FirstPageState()));
  });

  group('GoToSecondPageEvent then GoToFirstPageEvent', () {
    test(
      'should emit [FirstPageState, SecondPageState, FirstPageState]',
      () async {
        // assert later
        final expected = [
          FirstPageState(),
          SecondPageState(),
          FirstPageState(),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GoToSecondPageEvent());
        bloc.add(const GoToFirstPageEvent());
        await future;
      },
    );
  });

  group('GoToSecondPageEvent', () {
    test(
      'should emit [FirstPageState, SecondPageState]',
      () async {
        // assert later
        final expected = [FirstPageState(), SecondPageState()];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GoToSecondPageEvent());
        await future;
      },
    );
  });
}

class MockGetGithubUser extends Mock implements GetGithubUser {}
