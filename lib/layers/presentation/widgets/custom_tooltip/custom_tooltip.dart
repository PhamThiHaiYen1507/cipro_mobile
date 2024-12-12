import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum TooltipDirection { left, right, top, bottom }

enum TooltipBottomStart { left, right, center }

enum TooltipTopStart { left, right, center }

const Map<TooltipBottomStart, Alignment> _tooltipBottomAlignment = {
  TooltipBottomStart.left: Alignment.topLeft,
  TooltipBottomStart.center: Alignment.topCenter,
  TooltipBottomStart.right: Alignment.topRight,
};

const Map<TooltipTopStart, Alignment> _tooltipTopAlignment = {
  TooltipTopStart.left: Alignment.bottomLeft,
  TooltipTopStart.center: Alignment.bottomCenter,
  TooltipTopStart.right: Alignment.bottomRight,
};

class CustomToolTipController {
  CustomToolTipState? _state;

  void close() {
    _state?._close();
  }

  void open() {
    _state?._open();
  }

  void toggle() {
    if (_state?.show == true) {
      _state?._close();
    } else {
      _state?._open();
    }
  }

  bool get isOpen => _state?.show ?? false;
}

class CustomToolTip extends StatefulWidget {
  final Widget child;
  final TooltipDirection direction;
  final Color? toolTipBackgroundColor, barrierColor;
  final Widget tooltip;
  final VoidCallback? onTapTooltip, onTapChild;
  final bool initShow, disabled, fitSize, barrierDismissible;
  final num tooltipSpace;
  final double? width;
  final TooltipBottomStart tooltipBottomStart;
  final TooltipTopStart tooltipTopStart;
  final CustomToolTipController? controller;
  final bool useSafeArea;
  final bool fitScreen;

  const CustomToolTip({
    super.key,
    required this.child,
    this.direction = TooltipDirection.right,
    this.toolTipBackgroundColor = Colors.transparent,
    required this.tooltip,
    this.onTapTooltip,
    this.width,
    this.initShow = false,
    this.disabled = false,
    this.barrierDismissible = false,
    this.onTapChild,
    this.tooltipSpace = 4,
    this.tooltipBottomStart = TooltipBottomStart.center,
    this.tooltipTopStart = TooltipTopStart.center,
    this.controller,
    this.fitSize = false,
    this.barrierColor,
    this.useSafeArea = false,
    this.fitScreen = false,
  });

  @override
  State<CustomToolTip> createState() => CustomToolTipState();
}

class CustomToolTipState extends State<CustomToolTip> {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  late final ValueNotifier<TooltipDirection> _directionSafe =
      ValueNotifier(widget.direction);
  bool show = false;

  @override
  void initState() {
    _initController();
    if (widget.initShow) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _onChanged(false);
      });
    }

    super.initState();
  }

  void _initController() {
    if (widget.controller != null) {
      widget.controller!._state = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.disabled ? null : _onChanged,
        child: widget.child,
      ),
    );
  }

  void _close([bool needUpdate = true]) {
    if (show) {
      _overlayEntry.remove();
      show = false;

      if (mounted && needUpdate) {
        setState(() {});
        _directionSafe.value = widget.direction;
      }
    }
  }

  void _open() {
    if (mounted) {
      if (!show) {
        _overlayEntry = _getOverlay();
        Overlay.of(context).insert(_overlayEntry);
        show = true;
      }
    }
  }

  void _onChanged([bool hasCallback = true]) {
    if (mounted) {
      if (!show) {
        _overlayEntry = _getOverlay();
        Overlay.of(context).insert(_overlayEntry);
        show = true;
      } else {
        _overlayEntry.remove();
        show = false;
      }

      setState(() {});

      if (hasCallback) {
        widget.onTapChild?.call();
      }
    }
  }

  OverlayEntry _getOverlay() {
    Size? size;
    Offset? currentLocation;
    if (mounted) {
      size = context.size;
      final RenderBox? box = context.findRenderObject() as RenderBox?;
      currentLocation = box?.localToGlobal(Offset.zero);
    }
    return OverlayEntry(
      maintainState: true,
      builder: (ctx) => Stack(
        children: [
          if (widget.barrierDismissible)
            GestureDetector(
              onTap: _close,
              child:
                  Container(color: widget.barrierColor ?? Colors.transparent),
            ),
          if (widget.direction == TooltipDirection.bottom && widget.useSafeArea)
            Positioned(
                child: ValueListenableBuilder(
              valueListenable: _directionSafe,
              builder: (context, value, child) {
                final Widget item;

                if (value == TooltipDirection.top) {
                  Offset offset = Offset.zero;
                  Alignment followerAnchor = Alignment.bottomCenter;

                  switch (widget.tooltipBottomStart) {
                    case TooltipBottomStart.left:
                      offset = Offset(0, -widget.tooltipSpace.toDouble());
                      followerAnchor = Alignment.bottomLeft;
                      break;
                    case TooltipBottomStart.center:
                      offset = Offset((size?.width ?? 0) / 2,
                          -widget.tooltipSpace.toDouble());
                      followerAnchor = Alignment.bottomCenter;
                      break;
                    case TooltipBottomStart.right:
                      offset = Offset(
                          size?.width ?? 0, -widget.tooltipSpace.toDouble());
                      followerAnchor = Alignment.bottomRight;

                      break;
                  }

                  item = _getToolTipInview(
                    offset: offset,
                    followerAnchor: followerAnchor,
                    onVisibilityChanged: (visibilityInfo) {
                      if (visibilityInfo.visibleFraction < 1 && show) {
                        _directionSafe.value = TooltipDirection.bottom;
                      }
                    },
                  );
                } else {
                  Offset offset = Offset.zero;
                  switch (widget.tooltipBottomStart) {
                    case TooltipBottomStart.left:
                      offset = Offset(0,
                          (size?.height ?? 0) + widget.tooltipSpace.toDouble());
                      break;
                    case TooltipBottomStart.center:
                      offset = Offset((size?.width ?? 0) / 2,
                          (size?.height ?? 0) + widget.tooltipSpace.toDouble());
                      break;
                    case TooltipBottomStart.right:
                      offset = Offset(size?.width ?? 0,
                          (size?.height ?? 0) + widget.tooltipSpace.toDouble());
                      break;
                  }

                  item = _getToolTipInview(
                    offset: offset,
                    followerAnchor:
                        _tooltipBottomAlignment[widget.tooltipBottomStart]!,
                    onVisibilityChanged: (visibilityInfo) {
                      if (visibilityInfo.visibleFraction < 1 && show) {
                        _directionSafe.value = TooltipDirection.top;
                      }
                    },
                  );
                }

                return item;
              },
            ))
          else
            Positioned(child: _getToolTipBody(size, currentLocation))
        ],
      ),
    );
  }

  Widget _getToolTipBody(Size? size, Offset? currentLocation) {
    switch (widget.direction) {
      case TooltipDirection.right:
        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: Alignment.centerLeft,
            offset: Offset((size?.width ?? 0) + widget.tooltipSpace.toDouble(),
                (size?.height ?? 0) / 2),
            child: SizedBox(
              height: widget.fitSize ? size?.height ?? 0 : null,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
      case TooltipDirection.left:
        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: Alignment.centerRight,
            offset: Offset(
                -widget.tooltipSpace.toDouble(), (size?.height ?? 0) / 2),
            child: SizedBox(
              height: widget.fitSize ? size?.height ?? 0 : null,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
      case TooltipDirection.bottom:
        Offset offset = Offset.zero;
        switch (widget.tooltipBottomStart) {
          case TooltipBottomStart.left:
            offset =
                Offset(0, (size?.height ?? 0) + widget.tooltipSpace.toDouble());
            break;
          case TooltipBottomStart.center:
            offset = Offset((size?.width ?? 0) / 2,
                (size?.height ?? 0) + widget.tooltipSpace.toDouble());
            break;
          case TooltipBottomStart.right:
            offset = Offset(size?.width ?? 0,
                (size?.height ?? 0) + widget.tooltipSpace.toDouble());
            break;
        }

        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: _tooltipBottomAlignment[widget.tooltipBottomStart]!,
            offset: offset,
            child: SizedBox(
              width: widget.fitSize ? size?.width ?? 0 : widget.width,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
      case TooltipDirection.top:
        Offset offset = Offset.zero;
        if (!widget.fitScreen) {
          switch (widget.tooltipTopStart) {
            case TooltipTopStart.left:
              offset = Offset(0, -widget.tooltipSpace.toDouble());
              break;
            case TooltipTopStart.center:
              offset = Offset(
                  (size?.width ?? 0) / 2, -widget.tooltipSpace.toDouble());
              break;
            case TooltipTopStart.right:
              offset =
                  Offset(size?.width ?? 0, -widget.tooltipSpace.toDouble());
              break;
          }
        } else {
          offset = Offset(
              -(currentLocation?.dx ?? 0), -widget.tooltipSpace.toDouble());
        }

        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: widget.fitScreen
                ? Alignment.bottomLeft
                : _tooltipTopAlignment[widget.tooltipTopStart]!,
            offset: offset,
            child: SizedBox(
              width: widget.fitSize ? size?.width ?? 0 : null,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
    }
  }

  Widget _getToolTipInview({
    required Offset offset,
    Size? size,
    required Alignment followerAnchor,
    required void Function(VisibilityInfo)? onVisibilityChanged,
  }) {
    return CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        followerAnchor: followerAnchor,
        offset: offset,
        child: SizedBox(
          width: widget.fitSize ? size?.width ?? 0 : null,
          child: Material(
            color: widget.toolTipBackgroundColor,
            child: GestureDetector(
              onTap: () {
                widget.onTapTooltip?.call();
                _onChanged(false);
              },
              child: VisibilityDetector(
                key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                onVisibilityChanged: onVisibilityChanged,
                child: widget.tooltip,
              ),
            ),
          ),
        ));
  }

  @override
  void deactivate() {
    _close(false);
    super.deactivate();
  }

  @override
  void dispose() {
    _directionSafe.dispose();
    super.dispose();
  }
}
