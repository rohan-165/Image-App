import 'package:demoproject/core/bloc/internet_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomPullToRefreshWidget extends StatelessWidget {
  final Widget child;
  final Function() onRefresh;
  final Function() onLoading;
  CustomPullToRefreshWidget({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.onLoading,
  });
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetCubitState>(
      builder: (context, state) {
        return SmartRefresher(
          onRefresh: () {
            if (state.isOnline) {
              onRefresh();
              _refreshController.refreshCompleted();
            }
          },
          onLoading: () {
            if (state.isOnline) {
              onLoading();
              _refreshController.loadComplete();
            }
          },
          enablePullDown: true,
          enablePullUp: true,
          footer: CustomFooter(
            builder: (context, mode) {
              return const Center(child: CupertinoActivityIndicator());
            },
          ),
          header: const WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.white),
            waterDropColor: Colors.black,
            refresh: CircularProgressIndicator(),
          ),
          controller: _refreshController,
          child: child,
        );
      },
    );
  }
}
