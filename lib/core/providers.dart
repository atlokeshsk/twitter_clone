import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/constants.dart';

final appwriteClientProvider = Provider(
  (ref) {
    final client = Client();
    return client
        .setEndpoint(AppwriteConstant.endpoint)
        .setProject(AppwriteConstant.projectID)
        .setSelfSigned(status: true);
  },
);

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});
