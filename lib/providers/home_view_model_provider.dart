import 'package:adda/providers/home_repository_provider.dart';
import 'package:adda/view_model/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = Provider((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return HomeViewModel(homeRepository: homeRepository);
});
