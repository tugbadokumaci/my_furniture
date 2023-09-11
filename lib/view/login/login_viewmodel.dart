import 'package:my_furniture/core/init/cache/cache.dart';
import 'package:my_furniture/product/model/basic_model.dart';

class LoginViewModel {
  LoginViewModel(this.cache);
  final BasicCacheInterface cache;

  Future<bool> controlToUserName(BasicModel model) async {
    // burada network işlemleri olacak
    await Future.delayed(const Duration(seconds: 1));

    // burada network işleminin sonuçları olacak BUSINESS
    return model.userName.length.isOdd ? true : false;
  }

  // USECASE: servisten gelen cevaba göre dialog gösterilecekse burada showDialog() yazma

  // servisten gelen username true -> cache

  void saveUserNameToCache(String userName) {
    cache.saveString(userName);
  }
}
