import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inetagan/models/chat_model.dart';

class ChatSource {
  static Future<void> openChatRoom(String uid, String userName) async {
    final doc =
        await FirebaseFirestore.instance.collection('CS').doc(uid).get();
    if (doc.exists) {
      await FirebaseFirestore.instance.collection('CS').doc(uid).update({
        'newFromCS': false,
      });
      return;
    }
    //initial buka chat
    await FirebaseFirestore.instance.collection('CS').doc(uid).set({
      'roomId': uid,
      'name': userName,
      'lastMessage': 'Halo!, ada yang bisa saya bantu?',
      'newFromUser': false,
      'newFromCS': true,
    });
    await FirebaseFirestore.instance
        .collection('CS')
        .doc(uid)
        .collection('chats')
        .add({
      'roomId': uid,
      'message': 'Halo!, ada yang bisa saya bantu?',
      'receiverId': uid,
      'senderId': 'cs',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> send(Chat chat, String uid) async {
    await FirebaseFirestore.instance.collection('CS').doc(uid).update({
      'lastMessage': chat.message,
      'newFromUser': true,
      'newFromCS': false,
    });
    await FirebaseFirestore.instance
        .collection('CS')
        .doc(uid)
        .collection('chats')
        .add({
      'roomId': chat.roomId,
      'message': chat.message,
      'receiverId': chat.receiverId,
      'senderId': chat.senderId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
