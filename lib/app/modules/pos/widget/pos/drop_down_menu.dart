import 'package:flutter/material.dart';
import 'package:shopkeeper/widgets/easy_popup/easy_popup.dart';

class DropDownMenu extends StatefulWidget with EasyPopupChild {
  final _PopController controller = _PopController();

  @override
  _DropDownMenuState createState() => _DropDownMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownMenuState extends State<DropDownMenu>
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: 300,
        child: Expanded(
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height),
            child: ClipRect(
              child: SlideTransition(
                position: _animation,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemExtent: 50,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          // Fluttertoast.showToast(msg: 'item$index');
                          EasyPopup.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'item$index',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PopController {
  late _DropDownMenuState state;

  _bindState(_DropDownMenuState state) {
    this.state = state;
  }

  dismiss() {
    state.dismiss();
  }
}
