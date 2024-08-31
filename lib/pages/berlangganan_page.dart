import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:inetagan/models/paket_internet_model.dart';
import 'package:inetagan/widgets/button_primary_widget.dart';
import 'package:inetagan/widgets/input_widget.dart';
import 'package:intl/intl.dart';

class BerlanggananPage extends StatefulWidget {
  const BerlanggananPage({
    super.key,
    required this.internet,
  });
  final Internet internet;

  @override
  State<BerlanggananPage> createState() => _BerlanggananPageState();
}

class _BerlanggananPageState extends State<BerlanggananPage> {
  final edtNama = TextEditingController();
  final edtWhatsApp = TextEditingController();
  final edtNIK = TextEditingController();
  final edtAlamat = TextEditingController();
  final edtWaktu = TextEditingController();

  pickDate(TextEditingController editingController) {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            initialDate: DateTime.now())
        .then(
      (pickedDate) {
        if (pickedDate == null) return;
        editingController.text = DateFormat('dd MMM yyyy').format(pickedDate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(29),
          buildSnippetInternet(),
          const Gap(31),
          buildInput(),
          const Gap(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(
              text: 'Ajukan Pemasangan',
              ontap: () {
                Navigator.pushNamed(context, '/detail-berlangganan-page',
                    arguments: {
                      'internet': widget.internet,
                      'nama': edtNama.text,
                      'noWhatsapp': edtWhatsApp.text,
                      'nik': edtNIK.text,
                      'alamat': edtAlamat.text,
                      'date': edtWaktu.text,
                    });
              },
            ),
          ),
          const Gap(50)
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
          //NAMA
          const Text(
            'Nama',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_account.png',
            hint: 'tulis nama',
            editingController: edtNama,
          ),
          const Gap(16),
          //WHATSAPP
          const Text(
            'No WhatsApp',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_phone.png',
            hint: 'tulis nomor WhatsApp',
            editingController: edtWhatsApp,
          ),
          const Gap(16),
          //NIK
          const Text(
            'NIK',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_card.png',
            hint: 'tulis nomor NIK',
            editingController: edtNIK,
          ),
          const Gap(16),
          //ALAMAT
          const Text(
            'Alamat',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_location.png',
            hint: 'tulis alamat',
            editingController: edtAlamat,
          ),
          const Gap(16),
          //WAKTU
          const Text(
            'Waktu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff50C2C9),
            ),
          ),
          const Gap(12),
          InputWidget(
            icon: 'assets/ic_calendar.png',
            hint: 'pilih waktu',
            editingController: edtWaktu,
            enable: false,
            ontapBox: () => pickDate(edtWaktu),
          ),
          const Gap(16),
        ],
      ),
    );
  }

  Widget buildSnippetInternet() {
    return Container(
      height: 98,
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 21),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ExtendedImage.network(
            widget.internet.image,
            height: 60,
            width: 60,
            fit: BoxFit.contain,
          ),
          const Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.internet.nama,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff50C2C9),
                ),
              ),
              const Gap(2),
              Text(
                widget.internet.idealDevices,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff838384),
                ),
              ),
            ],
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
              "Berlangganan",
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
}
