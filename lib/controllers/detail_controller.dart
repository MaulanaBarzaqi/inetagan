import 'package:get/get.dart';
import 'package:inetagan/models/paket_internet_model.dart';
import 'package:inetagan/sources/internet_source.dart';

class DetailController extends GetxController {
  final _internet = Internet.empty.obs;
  Internet get internet => _internet.value;
  set internet(Internet n) => _internet.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  fetchInternet(String paketId) async {
    status = 'loading';

    final internetDetail = await InternetSource.fetchInternet(paketId);
    if (internetDetail == null) {
      status = 'something wrong';
      return;
    }
    status = 'success';
    internet = internetDetail;
  }
}
