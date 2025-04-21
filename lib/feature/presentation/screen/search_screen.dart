import 'package:demoproject/core/constants/app_enum.dart';
import 'package:demoproject/core/extension/build_context_extension.dart';
import 'package:demoproject/core/extension/widget_extensions.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/core/utils/decore_utils.dart';
import 'package:demoproject/feature/presentation/bloc/image_search_cubit/image_search_cubit.dart';
import 'package:demoproject/feature/presentation/widget/grid_view_widget.dart';
import 'package:demoproject/widget/custom_pull_to_refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtr = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  @override
  void initState() {
    _searchFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageSearchCubit, ImageSearchState>(
      builder: (context, state) {
        if (state.query.isNotEmpty) {
          _searchCtr.text = state.query;
        }
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: _searchCtr,
              enabled: true,
              focusNode: _searchFocus,
              decoration: inputDecoration(
                context: context,
                hintText: 'Search',
                suffixIcon: Icon(
                  state.images.isNotEmpty ? Icons.cancel : Icons.search,
                ).onTap(() {
                  _searchFocus.unfocus();
                  if (state.images.isNotEmpty) {
                    _searchCtr.clear();
                    getIt<ImageSearchCubit>().reset();
                  } else {
                    if (_searchCtr.text.isNotEmpty) {
                      getIt<ImageSearchCubit>().searchImage(
                        isToRefresh: true,
                        query: _searchCtr.text.trim(),
                      );
                    }
                  }
                }),
              ),
              onFieldSubmitted: (value) {
                if (_searchCtr.text.isNotEmpty) {
                  getIt<ImageSearchCubit>().searchImage(
                    isToRefresh: true,
                    query: value.trim(),
                  );
                }
              },
            ),
            automaticallyImplyLeading: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.status == APIStatus.initial) ...{
                const Center(child: Text('Search Image')),
              } else if (state.status == APIStatus.loading) ...{
                const Center(child: CircularProgressIndicator()),
              } else if (state.status == APIStatus.error) ...{
                const Center(child: Text('Error loading images')),
              } else if ((state.status == APIStatus.success) &&
                  state.images.isNotEmpty) ...{
                Expanded(
                  child: CustomPullToRefreshWidget(
                    onRefresh: () {
                      getIt<ImageSearchCubit>().searchImage(
                        isToRefresh: true,
                        query: _searchCtr.text.trim(),
                      );
                    },
                    onLoading: () {
                      getIt<ImageSearchCubit>().searchImage(
                        isToRefresh: false,
                        query: _searchCtr.text.trim(),
                      );
                    },

                    child: GridViewWidget(imageList: state.images),
                  ),
                ),
              } else ...{
                Center(
                  child: Text(
                    'No images available',
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              },
            ],
          ).padHorizontal(horizontal: 10.w).padVertical(vertical: 10.h),
        );
      },
    );
  }
}
