import 'package:adda/providers/api_provider.dart';
import 'package:adda/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider((ref) {
  final apiProviderTemp = ref.read(apiProvider);
  return HomeRepository(apiService: apiProviderTemp);
});
