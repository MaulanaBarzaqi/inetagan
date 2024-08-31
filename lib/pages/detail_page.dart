import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:inetagan/controllers/detail_controller.dart';
import 'package:inetagan/models/paket_internet_model.dart';
import 'package:inetagan/widgets/failed_ui.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.paketId});
  final String paketId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailController = Get.put(DetailController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        detailController.fetchInternet(widget.paketId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(57),
          Obx(
            () {
              String status = detailController.status;
              if (status == '') return const SizedBox();
              if (status == 'loading') {
                return const Center(child: CircularProgressIndicator());
              }
              if (status != 'success') {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: FailedUI(message: status),
                );
              }
              Internet internet = detailController.internet;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 27,
                      vertical: 22,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          internet.nama,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff50C2C9),
                          ),
                        ),
                        const Gap(34),
                        detailItem(internet.idealDevices),
                        const Gap(11),
                        detailItem(internet.kecepatan),
                        const Gap(11),
                        detailItem1(internet),
                        const Gap(11),
                        detailItem2(internet),
                        const Gap(45),
                      ],
                    ),
                  ),
                  const Gap(50),
                  buildPrice(
                    internet,
                    () {
                      Navigator.pushNamed(context, '/berlangganan-page',
                          arguments: internet);
                    },
                  ),
                ],
              );
            },
          )
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
              "Detail Paket Internet",
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

  Widget detailItem(
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
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
            'assets/ic_check_list.png',
            width: 24,
            height: 24,
          ),
          const Gap(15),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailItem1(
    Internet internet,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
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
            'assets/ic_check_list.png',
            width: 24,
            height: 24,
          ),
          const Gap(15),
          const Text(
            'Biaya Pemasangan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
          ),
          const Gap(5),
          Text(
            NumberFormat.currency(
              decimalDigits: 0,
              locale: 'id_ID',
              symbol: 'Rp',
            ).format(internet.pemasangan),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailItem2(
    Internet internet,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
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
            'assets/ic_check_list.png',
            width: 24,
            height: 24,
          ),
          const Gap(15),
          const Text(
            'Biaya Bulanan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
          ),
          const Gap(5),
          Text(
            NumberFormat.currency(
              decimalDigits: 0,
              locale: 'id_ID',
              symbol: 'Rp',
            ).format(internet.bulanan),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
          ),
          const Text(
            '/Bulan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff838384),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPrice(
    Internet internet,
    VoidCallback ontap,
  ) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xff50C2C9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            NumberFormat.currency(
              decimalDigits: 0,
              locale: 'id_ID',
              symbol: 'Rp. ',
            ).format(internet.price),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: ontap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                  child: Text(
                'Berlangganan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff50C2C9),
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
