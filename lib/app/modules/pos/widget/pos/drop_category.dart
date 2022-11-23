import 'package:flutter/material.dart';
import 'package:shopkeeper/widgets/easy_popup/easy_popup.dart';

class DropCategory extends StatefulWidget with EasyPopupChild {
  final _PopController controller = _PopController();
  DropCategory({Key? key}) : super(key: key);

  @override
  _DropCategoryState createState() => _DropCategoryState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _PopController {
  late _DropCategoryState state;

  _bindState(_DropCategoryState state) {
    this.state = state;
  }

  dismiss() {
    state.dismiss();
  }
}

class _DropCategoryState extends State<DropCategory>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widget.controller._bindState(this);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  dismiss() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
