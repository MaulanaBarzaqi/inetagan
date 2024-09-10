import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:inetagan/controllers/home_spesial_controller.dart';
import 'package:inetagan/controllers/paket_hemat_controller.dart';
import 'package:inetagan/models/account_model.dart';
import 'package:inetagan/models/paket_internet_model.dart';
import 'package:inetagan/widgets/failed_ui.dart';
import 'package:intl/intl.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final homeSpesialController = Get.put(HomeSpesialController());
  final homeHematController = Get.put(HomeHematController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        homeSpesialController.fetchSpesial();
        homeHematController.fetchPaketHemat();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomeSpesialController>(force: true);
    Get.delete<HomeHematController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Gap(20 + MediaQuery.of(context).padding.top),
        buildHeader(),
        const Gap(18),
        buildBanner(),
        const Gap(22),
        buildMenuTambahan(),
        const Gap(30),
        buildPaketHemat(),
        const Gap(30),
        buildSpesial(),
        const Gap(100),
      ],
    );
  }

  Widget buildHeader() {
    return FutureBuilder(
        future: DSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Account account = Account.fromJson(Map.from(snapshot.data!));
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Row(
              children: [
                Image.asset(
                  'assets/ic_account.png',
                  width: 40,
                  height: 40,
                ),
                const Gap(7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.nama,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff50C2C9),
                        ),
                      ),
                      Text(
                        account.email,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff838384),
                        ),
                      ),
                    ],
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
                    'assets/ic_notification.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildMenuTambahan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Menu Tambahan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff50C2C9),
            ),
          ),
        ),
        const Gap(10),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: [
                buildItemMenu(
                  'assets/ic_upgrade.png',
                  'Upgrade',
                  () {
                    Navigator.pushNamed(context, '/upgrade-page');
                  },
                ),
                buildItemMenu(
                  'assets/ic_downgrade.png',
                  'Downgrade',
                  () {
                    Navigator.pushNamed(context, '/downgrade-page');
                  },
                ),
                buildItemMenu(
                  'assets/ic_wifi_off.png',
                  'Berhenti',
                  () {},
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildItemMenu(
    String icon,
    String nama,
    VoidCallback ontap,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 52,
        margin: const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.fromLTRB(16, 14, 39, 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 24,
              width: 27,
            ),
            const Gap(10),
            Text(
              nama,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff8C8C8C),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaketHemat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Paket Hemat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff50C2C9),
            ),
          ),
        ),
        const Gap(10),
        Obx(
          () {
            String status = homeHematController.status;
            if (status == '') return const SizedBox();
            if (status == 'loading') {
              return const Center(child: CircularProgressIndicator());
            }
            if (status != 'success') {
              return Center(child: FailedUI(message: status));
            }
            List<Internet> list = homeHematController.list;
            return SizedBox(
              height: 295,
              child: ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Internet internet = list[index];
                  final margin = EdgeInsets.only(
                    left: index == 0 ? 24 : 12,
                    right: index == list.length - 1 ? 24 : 12,
                  );
                  return buildItemHemat(internet, margin);
                },
              ),
            );
          },
        )
      ],
    );
  }

  Widget buildItemHemat(
    Internet internet,
    EdgeInsetsGeometry margin,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail-page',
            arguments: internet.paketId);
      },
      child: Container(
        width: 252,
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExtendedImage.network(
              internet.image,
              width: 220,
              height: 170,
            ),
            const Gap(10),
            Text(
              internet.nama,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff504D4D)),
            ),
            const Gap(2),
            Text(
              internet.idealDevices,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff838384)),
            ),
            const Gap(2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  NumberFormat.currency(
                    decimalDigits: 0,
                    locale: 'id_ID',
                    symbol: 'Rp',
                  ).format(internet.bulanan),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff50C2C9),
                  ),
                ),
                const Text(
                  '/Bulan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff838384),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      margin: const EdgeInsets.symmetric(horizontal: 17),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/img_banner.png',
            width: 139,
            fit: BoxFit.fitHeight,
          ),
          const Gap(20),
          const Text(
            'Akses Internet Super\ncepat dan Canggih!',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xff50C2C9),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSpesial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Spesial untuk Anda",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff50C2C9),
            ),
          ),
        ),
        const Gap(10),
        Obx(
          () {
            String status = homeSpesialController.status;
            if (status == '') return const SizedBox();
            if (status == 'loading') {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (status != 'success') {
              return Center(child: FailedUI(message: status));
            }
            List<Internet> list = homeSpesialController.list;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              itemCount: list.length,
              itemBuilder: (context, index) {
                Internet internet = list[index];
                final margin = EdgeInsets.only(
                  top: index == 0 ? 10 : 9,
                  bottom: index == list.length - 1 ? 20 : 9,
                );
                return buildItemSpesial(
                  internet,
                  margin,
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget buildItemSpesial(
    Internet internet,
    EdgeInsetsGeometry margin,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail-page',
            arguments: internet.paketId);
      },
      child: Container(
        height: 98,
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ExtendedImage.network(
              internet.image,
              width: 90,
              height: 70,
              fit: BoxFit.contain,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    internet.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff070623),
                    ),
                  ),
                  const Gap(4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        NumberFormat.currency(
                          decimalDigits: 0,
                          locale: 'id_ID',
                          symbol: 'Rp',
                        ).format(internet.bulanan),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff50C2C9),
                        ),
                      ),
                      const Text(
                        '/Bulan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff838384),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
