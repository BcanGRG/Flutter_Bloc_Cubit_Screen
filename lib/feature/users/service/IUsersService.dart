import 'package:bloc_demo_first/feature/users/model/reqres_model.dart';
import 'package:vexana/vexana.dart';

abstract class IUserService {
  final INetworkManager networkManager;
  //*https://reqres.in/api/users
  IUserService({required this.networkManager});

  Future<List<Data>> fetchUsersData({int page = 0});
}
