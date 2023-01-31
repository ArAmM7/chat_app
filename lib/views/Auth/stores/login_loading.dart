import 'package:mobx/mobx.dart';

part 'login_loading.g.dart';

class LoginLoading = _LoginLoading with _$LoginLoading;

abstract class _LoginLoading with Store {
  @observable
  bool isLogin = false;
  @observable
  bool isLoading = false;

  @action
  void toggleLogin() => isLogin = !isLogin;

  @action
  void setLoading(bool val) => isLoading = val;
}
