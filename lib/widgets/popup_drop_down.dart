import 'package:flutter/material.dart';
import 'index.dart';

/// 下拉弹出层/窗口
class _PopupDropdownController {
  late _PopupDropdownState state;

  _bindState(_PopupDropdownState state) {
    this.state = state;
  }

  dismiss() {
    state.dismiss();
  }
}

class PopupDropdown extends StatefulWidget with EasyPopupChild {
  PopupDropdown({Key? key, this.child}) : super(key: key);
  final _PopupDropdownController controller = _PopupDropdownController();
  final Widget? child;

  @override
  _PopupDropdownState createState() => _PopupDropdownState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _PopupDropdownState extends State<PopupDropdown>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widget.controller._bindState(this);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  dismiss() {
    _controller.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 55),
        child: ClipRect(
          child: SlideTransition(
            position: _animation,
            child: widget.child ??
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemExtent: 50,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          EasyPopup.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'test $index',
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
