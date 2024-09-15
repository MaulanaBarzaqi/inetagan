import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/models/chat_model.dart';
import 'package:inetagan/sources/chat_source.dart';

class BantuanPage extends StatefulWidget {
  const BantuanPage({
    super.key,
    required this.uid,
    required this.userName,
  });
  final String uid;
  final String userName;

  @override
  State<BantuanPage> createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  final edtInputChat = TextEditingController();
  late final Stream<QuerySnapshot<Map<String, dynamic>>> streamChats;

  @override
  void initState() {
    streamChats = FirebaseFirestore.instance
        .collection('CS')
        .doc(widget.uid)
        .collection('chats')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Expanded(
            child: buildChats(),
          ),
          buildInputChat(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/ic_arrow_back.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              "Bantuan Pelanggan",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff50C2C9),
              ),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/ic_more.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChats() {
    return StreamBuilder(
      stream: streamChats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final list = snapshot.data!.docs;
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Chats"),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 30),
          itemCount: list.length,
          itemBuilder: (context, index) {
            Chat chat = Chat.fromJson(list[index].data());
            if (chat.senderId == 'cs') {
              return chatCS(chat);
            }
            return chatUser(chat);
          },
        );
      },
    );
  }

  Widget chatCS(Chat chat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Gap(24),
            Image.asset(
              'assets/ic_service_on.png',
              height: 24,
              width: 24,
            ),
            const Gap(8),
            const Text(
              'CS Inetagan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff50C2C9),
              ),
            )
          ],
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(
            right: 49,
            left: 24,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff50C2C9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            chat.message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  Widget chatUser(Chat chat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff50C2C9),
              ),
            ),
            const Gap(8),
            Image.asset(
              'assets/ic_chat_user.png',
              height: 24,
              width: 24,
            ),
            const Gap(24),
          ],
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(
            right: 24,
            left: 49,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            chat.message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  Widget buildInputChat() {
    return Container(
      height: 52,
      padding: const EdgeInsets.only(left: 25),
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: edtInputChat,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              isDense: true,
              border: InputBorder.none,
              hintText: 'tulis pesan....',
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff838384)),
            ),
          )),
          IconButton(
              onPressed: () {
                Chat chat = Chat(
                  roomId: widget.uid,
                  message: edtInputChat.text,
                  receiverId: 'cs',
                  senderId: widget.uid,
                );
                ChatSource.send(chat, widget.uid).then(
                  (value) {
                    edtInputChat.clear();
                  },
                );
              },
              icon: Image.asset(
                'assets/ic_send.png',
                height: 24,
                width: 24,
              ))
        ],
      ),
    );
  }
}
