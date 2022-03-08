import 'package:bloc_demo_first/feature/users/service/users_service.dart';
import 'package:bloc_demo_first/feature/users/view/sub_view/states_widget.dart';
import 'package:bloc_demo_first/feature/users/viewmodel/users_cubit.dart';
import 'package:bloc_demo_first/product/constants/project_constants.dart';
import 'package:bloc_demo_first/product/exception/widget_not_found_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UsersCubit(
              UsersService(
                  networkManager: ProjectConstants.instance.networkManager),
            ),
        child: BlocConsumer<UsersCubit, UsersState>(
          listener: (context, state) {
            if (state is UsersItemsErrorState) {}
            if (state is UsersInitial) {
              state.navigate();
            }
          },
          builder: (context, state) {
            return buildScaffold(state, context);
          },
        ));
  }

  Scaffold buildScaffold(UsersState state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: context.watch<UsersCubit>().isPagingLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).scaffoldBackgroundColor))
              : Text("data"),
        ),
      ),
      body: buildScaffoldBody(state),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }

  Widget buildScaffoldBody(UsersState state) {
    if (state is UsersInitial) {
      return state.buildWidget();
    } else if (state is UsersLoadingState) {
      return Center(child: CircularProgressIndicator());
    } else if (state is UsersListItemState) {
      return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              final _context = notification.context;
              if (_context != null) {
                _context.read<UsersCubit>().fetcUsersItemPaging();
              }
            }
            return true;
          },
          child: state.buildWidget());
    }
    throw WidgetNotFoundException<UsersView, UsersState>(state);
  }
}
