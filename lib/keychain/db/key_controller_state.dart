import 'key_entity.dart';

abstract class IKeyControllerState {
  removeKey(KeyEntity key);
  deleteAll();

  insertKey(KeyEntity key);
  insertAll(List<KeyEntity> keys);

  Future<int> count();

  Future<List<KeyEntity>> keys();
}
