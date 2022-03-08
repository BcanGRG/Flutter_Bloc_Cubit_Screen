import 'package:bloc_demo_first/feature/users/model/reqres_model.dart';
import 'package:bloc_demo_first/feature/users/service/IUsersService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  final IUserService userService;

  late List<Data> dataItems;

  bool isPagingLoading = false;
  UsersCubit(
    this.userService,
  ) : super(UsersInitial()) {
    pageNumber = 1;
    fetcUsersItem();
  }

  late int pageNumber;
  Future<void> fetcUsersItem() async {
    emit(UsersLoadingState(true));
    final items = await userService.fetchUsersData(page: pageNumber);
    if (items.isEmpty) {
      emit(UsersItemsErrorState());
    } else {
      emit(UsersListItemState(items));
    }
    dataItems = items;
  }

  Future<void> fetcUsersItemPaging() async {
    _changeLoadingPaging();
    emit(UsersListItemState(dataItems));
    if (isPagingLoading) {
      return;
    }
    pageNumber += 1;
    final items = await userService.fetchUsersData(page: pageNumber);
    _changeLoadingPaging();
    dataItems.addAll(items);
    emit(UsersListItemState(dataItems));
  }

  void _changeLoadingPaging() {
    isPagingLoading = !isPagingLoading;
  }
}

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoadingState extends UsersState {
  final bool isLoading;
  UsersLoadingState(this.isLoading);
}

class UsersListItemState extends UsersState {
  final List<Data> items;

  UsersListItemState(this.items);
}

class UsersItemsErrorState extends UsersState {}
