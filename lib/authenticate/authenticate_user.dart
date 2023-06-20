import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learning/cache/cache_manager.dart';

final cacheManager = Provider<CacheManager>((ref) {
  return CacheManager();
});

final authenticateUser = FutureProvider<bool>(
  (ref) async {
    final manager = ref.watch(cacheManager);
    final token = await manager.getToken();
    if (token != null) {
      return true;
    } else {
      return false;
    }
  },
);
