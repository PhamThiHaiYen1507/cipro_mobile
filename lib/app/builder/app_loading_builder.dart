import 'package:base_project/app/builder/app_loading_builder_controller.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppLoadingBuilder
    extends MobxLongLifeWidget<AppLoadingBuilderController> {
  final Widget child;

  const AppLoadingBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return PopScope(
        canPop: !controller.isLoading,
        child: Stack(
          children: [
            child,
            if (controller.isLoading)
              Container(
                color: Colors.black26,
                child: const Center(
                  child: SizedBox.square(
                      dimension: 32, child: CircularProgressIndicator()),
                ),
              )
          ],
        ),
      );
    });
  }
}
