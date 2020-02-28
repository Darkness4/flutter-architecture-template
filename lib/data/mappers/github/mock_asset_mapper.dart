import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'asset_mapper.dart';

@test
@injectable
@RegisterAs(GithubAssetMapper)
class MockGithubAssetMapper extends Mock implements GithubAssetMapper {}
