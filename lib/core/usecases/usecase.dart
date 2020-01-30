import 'package:equatable/equatable.dart';

abstract class Usecase<Type, Params> {
  const Usecase();

  Type call(Params params);
}

abstract class UsecaseAsync<Type, Params> {
  const UsecaseAsync();

  Future<Type> call(Params params);
}

abstract class UsecaseStream<Type, Params> {
  const UsecaseStream();

  Stream<Type> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
