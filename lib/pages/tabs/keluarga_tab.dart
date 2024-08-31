import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:inetagan/controllers/tab_keluarga_controller.dart';
import 'package:inetagan/models/paket_internet_model.dart';
import 'package:inetagan/widgets/failed_ui.dart';

class KeluargaTab extends StatefulWidget {
  const KeluargaTab({super.key});

  @override
  State<KeluargaTab> createState() => _KeluargaTabState();
}

class _KeluargaTabState extends State<KeluargaTab> {
  final tabKeluargaController = Get.put(TabKeluargaController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        tabKeluargaController.fetchKeluaga();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<TabKeluargaController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Gap(20 + MediaQuery.of(context).padding.top),
        Column(
          children: [
            buildKeluarga(),
          ],
        )
      ],
    );
  }

  Widget buildKeluarga() {
    return Obx(
      () {
        String status = tabKeluargaController.status;
        if (status == '') return const SizedBox();
        if (status == 'loading') {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (status != 'success') {
          return Center(child: FailedUI(message: status));
        }
        List<Internet> list = tabKeluargaController.list;
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
            return buildItemKeluarga(
              internet,
              margin,
            );
          },
        );
      },
    );
  }

  Widget buildItemKeluarga(
    Internet internet,
    EdgeInsetsGeometry margin,
  ) {
    return Container(
      height: 124,
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
                const Gap(15),
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
                Text(
                  internet.idealDevices,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff838384),
                  ),
                ),
                const Gap(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail-page',
                            arguments: internet.paketId);
                      },
                      child: Container(
                        height: 40,
                        width: 126,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff50C2C9),
                        ),
                        child: const Center(
                          child: Text(
                            "Detail",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
