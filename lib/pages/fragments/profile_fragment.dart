import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/models/account_model.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  logout() {
    DSession.removeUser().then(
      (remove) {
        if (!remove) return;

        Navigator.pushReplacementNamed(context, '/signin');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Gap(30 + MediaQuery.of(context).padding.top),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'My Profile',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff50C2C9),
            ),
          ),
        ),
        const Gap(41),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              buildProfile(),
              const Gap(36),
              buildItemProfile(
                'assets/ic_edit.png',
                'Edit Profile',
                null,
              ),
              const Gap(20),
              buildItemProfile(
                'assets/ic_key.png',
                'Ganti Password',
                null,
              ),
              const Gap(20),
              buildItemProfile(
                'assets/ic_logout.png',
                'Logout',
                logout,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildProfile() {
    return FutureBuilder(
        future: DSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Account account = Account.fromJson(Map.from(snapshot.data!));
          return Row(
            children: [
              Image.asset(
                'assets/ic_account.png',
                width: 50,
                height: 50,
              ),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff50C2C9),
                    ),
                  ),
                  Text(
                    account.email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff838384),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget buildItemProfile(
    String icon,
    String name,
    VoidCallback? ontap,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 52,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: const Color(0xffEFEEF7),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 24,
              height: 24,
            ),
            const Gap(14),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6D6C6C),
                ),
              ),
            ),
            Image.asset(
              'assets/ic_arrow_right.png',
              height: 24,
              width: 24,
            )
          ],
        ),
      ),
    );
  }
}
