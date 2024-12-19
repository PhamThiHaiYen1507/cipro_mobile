import 'dart:developer';

import 'package:base_project/core/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

const _debugName = 'MOBX';

class MobxManager {
  static final Map<Type, Map<String, dynamic>> mobxInstanceManager = {};

  static final Map<Type, Map<String, int>> _countInstance = {};

  static void _increateCount(Type type, String tag) {
    _countInstance[type] ??= {};

    int count = _countInstance[type]![tag] ?? 0;

    count++;

    _countInstance[type]![tag] = count;
  }

  static void _decreateCount<C extends Store>(String tag) {
    if (_countInstance[C]?[tag] == null) return;

    int count = _countInstance[C]![tag]!;

    if (count == 0) return;

    count--;

    _countInstance[C]![tag] = count;

    if (count <= 0) {
      removeController<C>(tag: tag);
    }
  }

  static void removeController<T extends Store>({String? tag}) {
    final tagName = tag ?? T.toString();

    if (mobxInstanceManager.containsKey(T) &&
        mobxInstanceManager[T]!.containsKey(tagName)) {
      log('$T closed with tag "$tagName"', name: _debugName);

      final instance = get<T>(tag: tagName);

      if (instance is MobxLifeCircle) {
        (instance as MobxLifeCircle).onClose();
      }
      mobxInstanceManager[T]!.remove(tagName);
    }
  }

  static C createController<C extends Store>({String? tag}) {
    final tagName = tag ?? C.toString();

    if (mobxInstanceManager[C]?[tagName] != null) {
      return mobxInstanceManager[C]![tagName];
    }

    C instance = injector<C>();

    mobxInstanceManager[C] ??= {};
    mobxInstanceManager[C]![tagName] = instance;

    log('${instance.runtimeType} created with tag "$tagName"',
        name: _debugName);

    if (instance is MobxLifeCircle) {
      (instance as MobxLifeCircle).onInit();
    }

    return instance;
  }

  static void createControllers<C extends Store>(List<C> controllers) {
    for (var controller in controllers) {
      final Type type = controller.runtimeType;
      final tagName = type.toString();

      if (mobxInstanceManager[type]?[tagName] != null) {
        continue;
      }

      createControllerInstance(controller);
    }
  }

  static C createControllerInstance<C extends Store>(C instance,
      {String? tag}) {
    final type = instance.runtimeType;
    final tagName = tag ?? type.toString();

    if (mobxInstanceManager[type]?[tagName] != null) {
      return mobxInstanceManager[type]![tagName];
    }

    mobxInstanceManager[type] ??= {};
    mobxInstanceManager[type]![tagName] = instance;

    log('${instance.runtimeType} created with tag "$tagName"',
        name: _debugName);

    if (instance is MobxLifeCircle) {
      (instance as MobxLifeCircle).onInit();
    }

    return instance;
  }

  static C get<C extends Store>({String? tag}) {
    final tagName = tag ?? C.toString();

    return mobxInstanceManager[C]![tagName];
  }

  static bool hasRegister<C extends Store>({String? tag}) {
    return mobxInstanceManager[C]?.containsKey(tag ?? C.toString()) ?? false;
  }

  static void removeAll<C extends Store>() {
    final List<String> tags =
        mobxInstanceManager[C]?.entries.map((e) => e.key).toList() ?? [];

    for (var tag in tags) {
      _decreateCount<C>(tag);
    }
  }
}

class MobxBuilder<T extends Store> extends StatelessWidget {
  final Widget Function(T controller) builder;

  final String? tag;

  const MobxBuilder({super.key, required this.builder, this.tag});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return builder(MobxManager.get<T>(tag: tag));
      },
    );
  }
}

abstract class MobxStatefulWidget<C extends Store> extends StatefulWidget {
  final String? tag;

  final bool autoDispose;

  final bool lazy;

  const MobxStatefulWidget(
      {super.key, this.tag, this.autoDispose = true, this.lazy = true});

  C? createController() => null;

  @override
  MobxState<MobxStatefulWidget<C>, C> createState();
}

abstract class MobxState<T extends MobxStatefulWidget<C>, C extends Store>
    extends State<T> {
  late C controller = _initController();

  C _initController() {
    final bool hasRegister = MobxManager.hasRegister<C>(tag: widget.tag);

    MobxManager._increateCount(C, widget.tag ?? C.toString());

    if (hasRegister) {
      return MobxManager.get<C>(tag: widget.tag);
    }

    final instance = widget.createController();
    if (instance != null) {
      return MobxManager.createControllerInstance(instance, tag: widget.tag);
    }

    return MobxManager.createController<C>(tag: widget.tag);
  }

  @override
  @mustCallSuper
  void initState() {
    if (!widget.lazy) controller;
    super.initState();
  }

  @override
  @mustCallSuper
  void dispose() {
    if (widget.autoDispose) {
      MobxManager._decreateCount<C>(widget.tag ?? C.toString());
    }
    super.dispose();
  }
}

abstract class MobxLongLifeWidget<C extends Store> extends StatelessWidget {
  C get controller => _initController();

  final String? tag;

  C? createController() => null;

  C _initController() {
    final bool hasRegister = MobxManager.hasRegister<C>(tag: tag);

    if (hasRegister) {
      return MobxManager.get<C>(tag: tag);
    }

    final instance = createController();
    if (instance != null) {
      return MobxManager.createControllerInstance(instance, tag: tag);
    }

    return MobxManager.createController<C>(tag: tag);
  }

  const MobxLongLifeWidget({
    super.key,
    this.tag,
  });
}

mixin MobxLifeCircle {
  void onClose() {}

  void onInit() {}
}
