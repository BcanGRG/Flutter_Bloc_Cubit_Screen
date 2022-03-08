import 'package:bloc_demo_first/feature/users/model/reqres_model.dart';
import 'package:bloc_demo_first/feature/users/service/IUsersService.dart';
import 'package:bloc_demo_first/product/utility/network_query.dart';
import 'package:bloc_demo_first/product/utility/network_route.dart';
import 'package:vexana/vexana.dart';

class UsersService extends IUserService {
  UsersService({required INetworkManager networkManager})
      : super(networkManager: networkManager);

  @override
  Future<List<Data>> fetchUsersData({int page = 0}) async {
    final response = await networkManager.send<ReqresModel, ReqresModel>(
      NetworkRoute.USERS.rawValue,
      parseModel: ReqresModel(),
      method: RequestType.GET,
      queryParameters: Map.fromEntries([NetworkQuery.PAGE.pageQuery(page)]),
    );
    final reqresData = response.data;
    if (reqresData != null) {
      final dataList = reqresData.data;
      if (dataList != null) {
        return dataList;
      }
    }
    return [];
  }
}
