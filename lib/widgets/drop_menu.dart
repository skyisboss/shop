import 'package:flutter/material.dart';
import 'package:shopkeeper/widgets/index.dart';

/// 访微信 点击+号弹窗菜单
class MenuItem extends StatelessWidget {
  final String title;
  final TextAlign? textAlign;
  final Function()? onTap;

  MenuItem({Key? key, required this.title, this.onTap, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(title, textAlign: textAlign ?? TextAlign.center),
      onTap: onTap,
    );
  }
}

class DropPopupMenu extends StatefulWidget with EasyPopupChild {
  final _PopController controller = _PopController();
  final List<MenuItem> actions;
  DropPopupMenu({Key? key, required this.actions}) : super(key: key);

  @override
  _DropPopupMenuState createState() => _DropPopupMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropPopupMenuState extends State<DropPopupMenu>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widget.controller._bindState(this);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 180),
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
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 50,
          right: 5,
        ),
        child: ClipRect(
          child: SlideTransition(
            position: _animation,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// 三角形
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          border: Border(
                            // 四个值 top right bottom left
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 6,
                                style: BorderStyle.solid),
                            right: BorderSide(
                                color: Colors.transparent,
                                width: 6,
                                style: BorderStyle.solid),
                            left: BorderSide(
                                color: Colors.transparent,
                                width: 6,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),

                    /// 操作菜单
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: widget.actions.map((widget) => widget),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PopController {
  late _DropPopupMenuState state;

  _bindState(_DropPopupMenuState state) {
    this.state = state;
  }

  dismiss() {
    state.dismiss();
  }
}
