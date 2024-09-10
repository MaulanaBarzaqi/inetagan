import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inetagan/widgets/input_widget.dart';

class UpgradePage extends StatefulWidget {
  const UpgradePage({super.key});

  @override
  State<UpgradePage> createState() => _UpgradePageState();
}

class _UpgradePageState extends State<UpgradePage> {
  final edtNama = TextEditingController();
  final edtPaketNow = TextEditingController();
  final edtPaketOld = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(34),
          buildInput(),
          const Gap(24),
          buildPaket(),
          const Gap(24),
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
              "Upgrade Kecepatan",
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

  Widget buildInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nama Lengkap',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_account.png',
            hint: 'nama anda',
            editingController: edtNama,
          )
        ],
      ),
    );
  }

  Widget buildPaket() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Paket saat ini',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          buildItemDropdown(),
          const Gap(24),
          const Text(
            'Pilih Paket Upgrade',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          buildItemDropdown(),
        ],
      ),
    );
  }

  Widget buildItemDropdown() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButtonFormField(
        value: 'Pilih paket Internet',
        icon: Image.asset(
          'assets/ic_arrow_down.png',
          width: 24,
          height: 24,
        ),
        items: [
          'Pilih paket Internet',
          'Paket 3 Mbps',
          'Paket 5 Mbps',
          'Paket 10 Mbps',
          'Paket 15 Mbps',
          'Paket 20 Mbps',
          'Paket 30 Mbps',
          'Paket 50 Mbps',
        ].map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff50C2C9),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {},
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(right: 12),
          prefixIcon: UnconstrainedBox(
            alignment: const Alignment(0.2, 0),
            child: Image.asset(
              'assets/ic_wifi.png',
              width: 24,
              height: 24,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xff50C2C9),
            ),
          ),
        ),
      ),
    );
  }
}
