import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1102/src/models/entry.dart';

class FirestoreService {
  // ignore: deprecated_member_use
  FirebaseFirestore _db = FirebaseFirestore.instance;
//Get entries
  Stream<List<Entry>> getEntries() {
    return _db
        .collection('entries')
       // .where('date',isGreaterThan: DateTime.now().add(Duration(days: -30)))
        .snapshots()
        .map((event) => event.docs
        .map((e) => Entry
        .fromjson(e.data()))
        .toList());
  }
//Upsert
  Future<void> setEntry(Entry entry){
    var options = SetOptions(merge:true);
  return _db
  .collection('entries')
  .doc(entry.entryId)
  .set(entry.toMap());

}
//delete
 Future<void> removeEntry(String entryId){
    var options = SetOptions(merge:true);
  return _db
  .collection('entries')
  .doc(entryId.toString())
  .delete();
}
}
