import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/widgets/index.dart';
import 'package:shopkeeper/widgets/popup_drop_down.dart';

import '../controllers/customer_controller.dart';
import 'add_view.dart';
import 'detail_view.dart';
// import 'widgets/appbar_search.dart';

class CustomerView extends GetView<CustomerController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: BackButton(color: Colors.white),
          title: AppBarSearch(
            onFoucs: (e) => controller.searchInputFoucs = e,
          ),
          actions: [
            IconButton(
              onPressed: () => Get.to(() => AddView()),
              icon: Icon(Icons.person_add, color: Colors.white),
            ),
          ],
        ),
        body: GetX<CustomerController>(
          init: CustomerController(),
          initState: (_) {
            controller.listState.initData();
          },
          builder: (_) {
            return Stack(
              children: [
                Column(
                  children: [
                    //信息预览
                    buildOverview(),
                    //列表
                    Expanded(child: buildListInfo()),
                  ],
                ),
                // 遮罩层，当顶部搜索框获取焦点时遮罩层启用，避免点击空白处取消焦点时跳转详情页
                controller.searchInputFoucs
                    ? Container(
                        color: Colors.black.withOpacity(0),
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 列表页
  Widget buildListInfo() {
    Widget child = ListView.separated(
      padding: EdgeInsets.only(top: 16),
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemCount: controller.listState.customerList.length,
      itemBuilder: (BuildContext context, int index) {
        var element = controller.listState.customerList[index];
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            onTap: () => Get.to(() => DetailView(id: element.id!)),
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(element.username!),
            subtitle: DefaultTextStyle(
              style: TextStyle(fontSize: 12, color: Colors.grey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('消费总金额：${element.spendCount}'),
                  Text('消费总次数：${element.timesCount}'),
                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      element.groupName ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        );
      },
    );

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        complete: Column(
          children: [
            SizedBox(height: 16),
            Icon(Icons.check_circle, color: Colors.green),
            Text('刷新完成', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget child;
          switch (mode) {
            case LoadStatus.idle:
              child = Text("上拉加载");
              break;
            case LoadStatus.loading:
              child = CupertinoActivityIndicator();
              break;
            case LoadStatus.failed:
              child = Text("加载失败！点击重试！");
              break;
            case LoadStatus.canLoading:
              child = Text("松手,加载更多!");
              break;
            default:
              child = Text(
                "没有更多数据了",
                style: TextStyle(color: Colors.grey),
              );
          }
          return Container(
            height: 55.0,
            child: Center(child: child),
          );
        },
      ),
      onRefresh: () {
        controller.listState.onRefresh();
      },
      onLoading: () {
        controller.listState.onLoading();
      },
      controller: controller.listState.refreshController,
      child: child,
    );
  }

  /// 头部概览
  Widget buildOverview() {
    return Container(
      height: 56,
      width: double.maxFinite,
      color: MyColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '会员数量: ${controller.listState.customerTotal}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '最新: ${controller.listState.customerLast}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
            ],
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                EasyPopup.show(
                  Get.context!,
                  PopupDropdown(
                    child: FilterPopup(),
                  ),
                  offsetLT:
                      Offset(0, MediaQuery.of(Get.context!).padding.top + 57),
                );
              },
              child: Text('筛选'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    controller.isFilterValue() ? Colors.orange : Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterPopup extends GetView<CustomerController> {
  const FilterPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CustomerController>(
      init: CustomerController(),
      initState: (_) {},
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          height: double.infinity,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _filterGroup(title: '会员', children: [
                _groupItem(title: 'VIP-1', value: '1', key: 'group'),
                _groupItem(title: 'VIP-2', value: '2', key: 'group'),
                _groupItem(title: 'VIP-3', value: '3', key: 'group'),
              ]),
              _filterGroup(title: '生日', children: [
                _groupItem(title: '今日', value: '1', key: 'birthday'),
                _groupItem(title: '明日', value: '2', key: 'birthday'),
                _groupItem(title: '近7天', value: '3', key: 'birthday'),
                _groupItem(title: '近30天', value: '4', key: 'birthday'),
              ]),
              _filterGroup(title: '消费', children: [
                _groupItem(title: 'TOP10', value: '1', key: 'spend'),
                _groupItem(title: 'TOP50', value: '2', key: 'spend'),
                _groupItem(title: 'TOP100', value: '3', key: 'spend'),
                _groupItem(title: '有消费', value: '4', key: 'spend'),
              ]),
              _filterGroup(title: '其他', children: [
                _groupItem(title: '欠款用户', value: '1', key: 'other'),
                _groupItem(title: '从未消费', value: '2', key: 'other'),
              ]),
              Padding(
                padding: const EdgeInsets.all(32),
                child: MyButton(
                  onPressed: () {
                    EasyPopup.pop(context);
                  },
                  text: '确定',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _groupItem({
    required String title,
    required String key,
    required String value,
  }) {
    final selected = controller.filterValue[key] == value;
    final style = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(selected ? Colors.orange : Colors.white),
      foregroundColor:
          MaterialStateProperty.all(selected ? Colors.white : Colors.blue),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
    return Container(
      child: OutlinedButton(
        // 设置选中高亮，如果已经是选择则取消，否则设置高亮
        onPressed: () => controller.filterValue[key] = selected ? '' : value,
        child: Text(title),
        style: style,
      ),
    );
  }

  _filterGroup({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 8),
        Wrap(
          children: children,
          spacing: 16,
        ),
        Divider(),
      ],
    );
  }
}
