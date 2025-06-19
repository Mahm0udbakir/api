import 'package:api/core/utils/custom_shrimmer.dart';
import 'package:api/functions/custom_snackbar.dart';
import 'package:api/global_states/global_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomListView<M, C extends Cubit<S>, S> extends StatelessWidget {
  const CustomListView(
      {super.key,
      required this.itemBuilder,
      required this.height,
      required this.separatorItem,
      required this.shimmerContainer,
      required this.cubit,
      required this.getData});

  final double height;
  final C cubit;
  final List<M> Function(S) getData;
  final Widget Function(BuildContext, int, M) itemBuilder;
  final Widget shimmerContainer;
  final Widget separatorItem;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, S>(
      bloc: cubit,
      listener: (context, state) {
        if (state is GlobalErrorState) {
          errorSnackBar(context, state);
        }
      },
      builder: (context, state) {
        final data = getData(state);
        return state is GlobalLoadingState
            ? CustomShrimmer(
                height: height,
                shimmerContainer: shimmerContainer,
                separatorItem: separatorItem,
              )
            : SizedBox(
                height: height,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return itemBuilder(context, index, data[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return separatorItem;
                  },
                  itemCount: data.length,
                ),
              );
      },
    );
  }
}
