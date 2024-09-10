import 'package:get/get.dart';
import 'package:inetagan/models/paket_internet_model.dart';
import 'package:inetagan/sources/internet_source.dart';

class HomeHematController extends GetxController {
  final _list = <Internet>[].obs;
  List<Internet> get list => _list;
  set list(List<Internet> n) => _list.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  fetchPaketHemat() async {
    status = 'loading';

    final internet = await InternetSource.fetchPaketHemat();
    if (internet == null) {
      status = 'something wrong';
      return;
    }
    status = 'success';
    list = internet;
  }
}
