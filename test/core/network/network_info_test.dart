import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('networkInfo.result', () {
    test(
      'is connected to Wifi',
      () async {
        // arrange
        final mockedResult = Future.value(ConnectivityResult.wifi);

        when(mockDataConnectionChecker.checkConnectivity())
            .thenAnswer((_) => mockedResult);
        // act
        final result = networkInfo.result;
        // assert
        verify(mockDataConnectionChecker.checkConnectivity());
        expect(result, mockedResult);
      },
    );

    test(
      'is connected to Mobile',
      () async {
        // arrange
        final mockedResult = Future.value(ConnectivityResult.mobile);

        when(mockDataConnectionChecker.checkConnectivity())
            .thenAnswer((_) => mockedResult);
        // act
        final result = networkInfo.result;
        // assert
        verify(mockDataConnectionChecker.checkConnectivity());
        expect(result, mockedResult);
      },
    );

    test(
      'is connected to None',
      () async {
        // arrange
        final mockedResult = Future.value(ConnectivityResult.none);

        when(mockDataConnectionChecker.checkConnectivity())
            .thenAnswer((_) => mockedResult);
        // act
        final result = networkInfo.result;
        // assert
        verify(mockDataConnectionChecker.checkConnectivity());
        expect(result, mockedResult);
      },
    );
  });
}

class MockDataConnectionChecker extends Mock implements Connectivity {}
