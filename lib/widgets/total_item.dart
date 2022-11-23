import 'package:flutter/material.dart';

class TotalItem extends StatelessWidget {
  final String title;
  final String image;
  final String? content;
  final Function()? onTap;
  const TotalItem({
    Key? key,
    required this.title,
    required this.image,
    this.content,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/report/$image.png',
              width: 40.0, height: 40.0),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
          SizedBox(height: 2),
          content != null
              ? Text(content!, style: TextStyle(fontSize: 16))
              : SizedBox(),
        ],
      ),
    );
  }
}
