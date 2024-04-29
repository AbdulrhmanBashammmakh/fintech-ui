import 'package:fintech/utils/AColors.dart';
import 'package:flutter/material.dart';

class sectionCard extends StatelessWidget {
  const sectionCard({
    required this.ic,
    required this.tit,
    Key? key,
  }) : super(key: key);
  final String tit;
  final IconData ic;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Icon(
                ic,
                color: primaryColor,
                size: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 8, left: 8),
              child: Text(tit, style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
