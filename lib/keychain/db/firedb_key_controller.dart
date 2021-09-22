import 'package:key_chain/keychain/db/key_controller_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'key_entity.dart';

class FireDBKeyController implements IKeyControllerState {
  static const TABLE_NAME = 'keys';
  String _userId;

  FireDBKeyController(this._userId) {
    _userId = _userId.replaceAll(".", "").replaceAll("@", "");
  }

  DatabaseReference getRef() {
    return FirebaseDatabase(
            databaseURL: "https://burnapp-fca75.firebaseio.com/")
        .reference()
        .child("keys/$_userId");
  }

  @override
  insertKey(KeyEntity key) async {
    getRef().child("list/${key.receptionDateTime}").set(key.content);

    int counter = await count() + 1;
    getRef().child("count").set(counter);
  }

  @override
  Future<int> count() async {
    DataSnapshot snapshot = await getRef().child("count").get();
    if (!snapshot.exists) {
      getRef().child("count").set(0);
      return 0;
    }
    return snapshot.value;
  }

  @override
  removeKey(KeyEntity key) async {
    getRef().child("list/${key.receptionDateTime}").remove();

    int counter = await count() - 1;
    getRef().child("count").set(counter);
  }

  @override
  Future<List<KeyEntity>> keys() async {
    var snapshot = await getRef().child("list").get();
    List<KeyEntity> keyList = [];
    if (snapshot.exists) {
      snapshot.value.keys.forEach((key) {
        keyList.add(
            KeyEntity(content: snapshot.value[key], receptionDateTime: key));
      });
    }
    return keyList;
  }

  @override
  deleteAll() {
    getRef().child("list").remove();
    getRef().child("count").set(0);
  }

//todo this is lazy, let's do it better at some point
  @override
  insertAll(List<KeyEntity> keys) {
    keys.forEach((element) => insertKey(element));
  }
}
