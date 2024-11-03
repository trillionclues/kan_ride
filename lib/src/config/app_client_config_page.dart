import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_client_config_provider.dart';
import '../common/widgets/async_value_widget.dart';

class AppClientConfigPage extends ConsumerStatefulWidget{
  const AppClientConfigPage({super.key});

  @override
  ConsumerState<AppClientConfigPage> createState() => _SplashPageState();
}


class _SplashPageState extends ConsumerState<AppClientConfigPage> {

  @override
  Widget build(BuildContext context) {
    final appClientValueAsync = ref.watch(appClientConfigProvider);
    return Scaffold(
      body: AsyncValueWidget(
        value: appClientValueAsync,
        data: (_){
          return const SizedBox();
        }
      ),
    );
  }
}