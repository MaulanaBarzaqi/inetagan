import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:inetagan/pages/tabs/pelajar_tab.dart';
import 'package:inetagan/pages/tabs/corporate_tab.dart';
import 'package:inetagan/pages/tabs/keluarga_tab.dart';

class InternetPage extends StatefulWidget {
  const InternetPage({super.key});

  @override
  State<InternetPage> createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage> {
  final tabCategoryIndex = 0.obs;
  final tabcategory = [
    const KeluargaTab(),
    const PelajarTab(),
    const CorporateTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF2F2F2),
            ),
            child: Center(
              child: Image.asset(
                'assets/ic_arrow_back.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        title: const Text(
          'Paket Internet',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff50C2C9),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  builditemTabs(
                    name: 'Keluarga',
                    isActive: tabCategoryIndex.value == 0,
                    ontap: () {
                      tabCategoryIndex.value = 0;
                    },
                  ),
                  builditemTabs(
                    name: 'Pelajar',
                    isActive: tabCategoryIndex.value == 1,
                    ontap: () {
                      tabCategoryIndex.value = 1;
                    },
                  ),
                  builditemTabs(
                    name: 'Corporate',
                    isActive: tabCategoryIndex.value == 2,
                    ontap: () {
                      tabCategoryIndex.value = 2;
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
      extendBody: true,
      body: Obx(
        () => tabcategory[tabCategoryIndex.value],
      ),
    );
  }

  Widget builditemTabs({
    required String name,
    bool isActive = false,
    required VoidCallback ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 90,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(isActive ? 0xff50C2C9 : 0xff8C8C8C),
              ),
            ),
            const Gap(15),
            Container(
              height: 5,
              decoration: BoxDecoration(
                color: Color(isActive ? 0xff50C2C9 : 0xffFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
