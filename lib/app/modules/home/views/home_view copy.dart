// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:shopkeeper/app/routes/app_pages.dart';
// import 'package:shopkeeper/common/style/colors.dart';
// import 'package:shopkeeper/common/values/index.dart';
// // import 'package:shopkeeper/common/widgets/index.dart';
// import 'package:shopkeeper/common/widgets/bottom_navigation_bar.dart' as FUCK;
// import 'package:shopkeeper/widgets/index.dart';

// import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     /// 边框阴影
//     final _boxShadow = [
//       BoxShadow(
//         offset: const Offset(0, 1),
//         color: Colors.blue.withOpacity(0.2),
//         blurRadius: 10,
//       )
//     ];

//     /// 信息概览
//     Widget buildOverview() {
//       final __background = Container(
//         height: 120,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/report/bg1.png'),
//             fit: BoxFit.fill,
//           ),
//         ),
//       );

//       final __infoData = Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           ...controller.overviewList.map(
//             (item) => TotalItem(
//               title: item['title'],
//               image: item['image'],
//               content: item['content'],
//             ),
//           )
//         ],
//       );

//       final __infoCard = Container(
//         width: double.infinity,
//         margin: EdgeInsets.all(16),
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(35),
//             bottomRight: Radius.circular(35),
//             topRight: Radius.circular(3),
//             bottomLeft: Radius.circular(3),
//           ),
//           boxShadow: _boxShadow,
//         ),
//         child: __infoData,
//       );

//       return SliverToBoxAdapter(
//         child: Stack(
//           children: [
//             __background,
//             __infoCard,
//           ],
//         ),
//       );
//     }

//     /// 教程提示
//     Widget buildTutorialBar() {
//       return SliverToBoxAdapter(
//         child: Container(
//           margin: EdgeInsets.all(16),
//           padding: EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: _boxShadow,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.volume_up, size: 18),
//               SizedBox(width: 8),
//               Expanded(child: Text(controller.tutorialText)),
//               Icon(Icons.keyboard_arrow_right, size: 18, color: Colors.grey),
//             ],
//           ),
//         ),
//       );
//     }

//     // 功能导航点击按钮
//     Widget __buildButton(int index) {
//       var action = controller.actionList[index];
//       return InkWell(
//         onTap: () => Get.toNamed(action['link']),
//         child: Container(
//           // color: Colors.grey.shade300,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 action['icon'],
//                 size: 36,
//                 color:
//                     MyColors.primaryColor.withOpacity(.6), //Color(0xFF8080FF),
//               ),
//               SizedBox(height: 6),
//               Text(action['label']),
//             ],
//           ),
//         ),
//       );
//     }

//     /// 操作导航区
//     Widget buildActionNav() {
//       final __navsCard = GridView.builder(
//         shrinkWrap: true,
//         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           childAspectRatio: 1.2, //1.953,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//         ),
//         itemCount: controller.actionList.length,
//         itemBuilder: (_, index) => __buildButton(index),
//       );
//       return SliverToBoxAdapter(
//         child: Container(
//           margin: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: _boxShadow,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: __navsCard,
//         ),
//       );
//     }

//     // app名称
//     Widget buildAppVersion() {
//       return SliverToBoxAdapter(
//         child: Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Shopkeeper',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade100,
//                 ),
//               ),
//               /*
//               SizedBox(width: 5),
//               Text(
//                 '1.0.1',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.grey.shade200,
//                 ),
//               )*/
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       // backgroundColor: Color(0xFFF8F8F8),
//       bottomNavigationBar: FUCK.buildBottomNavigationBar(),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             pinned: true,
//             elevation: 0.0,
//             expandedHeight: 100.0,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16),
//                     child: Text(
//                       'app_name'.tr,
//                       textAlign: TextAlign.left,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//               centerTitle: true,
//               background: Image.asset(
//                 'assets/images/report/bg.png',
//                 width: double.infinity,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           buildOverview(),
//           SliverToBoxAdapter(
//             child: SizedBox(height: 8),
//           ),
//           buildTutorialBar(),
//           SliverToBoxAdapter(
//             child: SizedBox(height: 8),
//           ),
//           buildActionNav(),
//           buildAppVersion(),
//         ],
//       ),
//     );
//   }
// }
