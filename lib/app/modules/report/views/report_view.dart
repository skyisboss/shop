import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  Widget buildTotalCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
    );
  }

  Widget buildCard(
      {required Widget child,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin}) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget buildReportItem(String title, String image) {
    return MyCard(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            ],
          ),
          SizedBox(height: 4),
          Image.asset(
            'assets/images/report/$image.png',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0.0,
          expandedHeight: 120.0,
          // backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.white),
          flexibleSpace: FlexibleSpaceBar(
            // centerTitle: true,
            title: Text('??????', style: TextStyle(color: Colors.white)),
            background: Image.asset(
              'assets/images/report/bg.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          // flexibleSpace
        ),
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/report/bg1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              MyCard(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TotalItem(title: '?????????', image: '1605350', content: '80'),
                    TotalItem(title: '?????????', image: 'xdd', content: '80'),
                    TotalItem(title: '?????????', image: 'jrjye', content: '11.04 M'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26),
                Text(
                  '????????????',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                buildReportItem('????????????', 'sjzs'),
                SizedBox(height: 26),
                buildReportItem('???????????????', 'jyetj'),
                SizedBox(height: 26),
                buildReportItem('????????????', 'sptj'),
                SizedBox(height: 26),
                buildReportItem('????????????', 'sptj'),
                SizedBox(height: 26),
                Center(child: Text('?????????????????????????????????')),
                SizedBox(height: 26),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// Text('??????????????????/??????/?????????'),
