import 'package:bloc_demo_first/feature/users/viewmodel/users_cubit.dart';
import 'package:bloc_demo_first/product/constants/application_constants.dart';
import 'package:flutter/material.dart';

extension UsersInitialWidget on UsersInitial {
  void navigate() {}
  Widget buildWidget() {
    return Text("Okey");
  }
}

extension UsersListItemWidget on UsersListItemState {
  void navigate() {}
  Widget buildWidget() {
    return Scrollbar(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            print(items[index].firstName);
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(items[index].avatar ??
                      ApplicationConstants.DEFAULT_IMAGE_URL),
                ),
                title: Text(items[index].email ?? ""),
              ),
            );
          }),
    );
  }
}
