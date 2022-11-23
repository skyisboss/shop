import 'package:flutter/material.dart';
import 'package:shopkeeper/widgets/index.dart';

/// 删除搜索筛选页面
class PopupSearchView extends StatelessWidget {
  const PopupSearchView({Key? key}) : super(key: key);

  Widget buildDatePickup() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade500),
        ),
        child: Text(
          '2020/02/02',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        height: 260,
        width: double.maxFinite,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDatePickup(),
                Text('至'),
                buildDatePickup(),
              ],
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Text('资金钱包'),
                SizedBox(width: 26),
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: DropdownButton(
                    isDense: true,
                    hint: Text('请选择'),
                    items: ['A', 'B', 'B', 'B', 'B'].map((value) {
                      return DropdownMenuItem(
                        value: 'A',
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Text('查看类型'),
                SizedBox(width: 26),
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: DropdownButton(
                    isDense: true,
                    hint: Text('请选择'),
                    items: ['全部', '支出', '收入', '其他'].map((value) {
                      return DropdownMenuItem(
                        value: '全部',
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () => EasyPopup.pop(context),
                child: Text('确定'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
