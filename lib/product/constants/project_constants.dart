import 'package:bloc_demo_first/product/utility/network_route.dart';
import 'package:vexana/vexana.dart';

class ProjectConstants {
  static ProjectConstants? _instance;
  static ProjectConstants get instance {
    _instance = ProjectConstants._init();
    return _instance!;
  }

  INetworkManager networkManager = NetworkManager(
      isEnableLogger: true,
      options: BaseOptions(baseUrl: NetworkRoute.BASE_URL.rawValue));

  ProjectConstants._init();
}
