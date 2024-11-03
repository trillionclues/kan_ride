import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../res/app_color.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data,
    this.loadingWidget, this.errorWidget, this.onRetry});
  final AsyncValue<T> value;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget Function(T) data;
  final FutureOr Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st){
        debugPrint('ERROR ------- $e');
        debugPrint('ERROR STACKTRACE ------- $st');
        return const Center(
          child: Text("Retry"
            // onRetry: onRetry,
          )
          // child: ErrorMessageWidget(
          //   onRetry: onRetry,
          // ),
        );
      },
      loading: () => loadingWidget??Center(child: CircularProgressIndicator(color: AppColor.primaryColor,
        backgroundColor: AppColor.disabledColor.withOpacity(0.4),)),
    );
  }
}

/// Sliver equivalent of [AsyncValueWidget]
class AsyncValueSliverWidget<T> extends StatelessWidget {
  const AsyncValueSliverWidget({super.key, required this.value,
    required this.data, this.loadingWidget, this.onRetry});
  final AsyncValue<T> value;
  final Widget? loadingWidget;
  final Widget Function(T) data;
  final FutureOr Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => SliverToBoxAdapter(
          child: loadingWidget ?? const Center(child: CircularProgressIndicator())),
      error: (e, st){
        debugPrint('ERROR ------- $e');
        debugPrint('ERROR STACKTRACE ------- $st');
        return const SliverToBoxAdapter(
          child: Center(
            child: Text("Retry"),
            // child: ErrorMessageWidget(
            //   onRetry: onRetry,
            // ),
          ),
        );
      },
    );
  }
}
