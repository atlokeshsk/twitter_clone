import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/models.dart';

final userAPIProvider = Provider((ref) {
  final database = ref.watch(appwriteDatabaseProvider);
  return AppwriteUserAPI(database: database);
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class AppwriteUserAPI implements IUserAPI {
  AppwriteUserAPI({required Databases database}) : _database = database;

  final Databases _database;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      var document = await _database.createDocument(
        databaseId: AppwriteConstant.databaseID,
        collectionId: AppwriteConstant.usersCollectionID,
        documentId: ID.unique(),
        data: userModel.toMap(),
      );
      print(document);
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
