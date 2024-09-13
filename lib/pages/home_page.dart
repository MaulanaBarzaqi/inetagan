import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:inetagan/cummons/info.dart';
import 'package:inetagan/models/account_model.dart';
import 'package:inetagan/pages/fragments/home_fragment.dart';
import 'package:inetagan/pages/fragments/profile_fragment.dart';
import 'package:inetagan/pages/fragments/riwayat_fragment.dart';
import 'package:inetagan/sources/chat_source.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fragmentIndex = 0.obs;
  final fragments = [
    const HomeFragment(),
    const RiwayatFragment(),
    const ProfileFragment(),
  ];

  late final Account account;

  @override
  void initState() {
    DSession.getUser().then(
      (value) {
        account = Account.fromJson(value!);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(
        () => fragments[fragmentIndex.value],
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          height: 78,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              buildItemNav(
                label: 'Home',
                icon: 'assets/ic_home.png',
                iconOn: 'assets/ic_home_on.png',
                isActive: fragmentIndex.value == 0,
                ontap: () {
                  fragmentIndex.value = 0;
                },
              ),
              buildItemNav(
                label: 'Riwayat',
                icon: 'assets/ic_history.png',
                iconOn: 'assets/ic_history_on.png',
                isActive: fragmentIndex.value == 1,
                ontap: () {
                  fragmentIndex.value = 1;
                },
              ),
              buildItemNav(
                label: 'Internet',
                icon: 'assets/ic_router.png',
                iconOn: 'assets/ic_router_on.png',
                ontap: () {
                  Navigator.pushNamed(context, '/paket-internet');
                },
              ),
              buildItemNav(
                label: 'Bantuan',
                icon: 'assets/ic_service.png',
                iconOn: 'assets/ic_service_on.png',
                ontap: () {
                  Info.netral('loading...');
                  ChatSource.openChatRoom(account.uid, account.nama).then(
                    (value) {
                      Navigator.pushNamed(context, '/bantuan-page', arguments: {
                        'uid': account.uid,
                        'username': account.nama,
                      });
                    },
                  );
                },
              ),
              buildItemNav(
                label: 'Profile',
                icon: 'assets/ic_profile.png',
                iconOn: 'assets/ic_profile_on.png',
                isActive: fragmentIndex.value == 2,
                ontap: () {
                  fragmentIndex.value = 2;
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildItemNav({
    required String label,
    required String icon,
    required String iconOn,
    bool isActive = false,
    required VoidCallback ontap,
    bool hasDot = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          color: Colors.transparent,
          height: 46,
          child: Column(
            children: [
              Image.asset(
                isActive ? iconOn : icon,
                height: 24,
                width: 24,
              ),
              const Gap(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(isActive ? 0xff50C2C9 : 0xff8C8C8C),
                    ),
                  ),
                  if (hasDot)
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      height: 6,
                      width: 6,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildItemCircle() {
  //   return Container(
  //     height: 60,
  //     width: 60,
  //     decoration: const BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Color(0xff50C2C9),
  //     ),
  //     child: UnconstrainedBox(
  //       child: Image.asset(
  //         'assets/ic_router.png',
  //         height: 24,
  //         width: 24,
  //       ),
  //     ),
  //   );
  // }
}
