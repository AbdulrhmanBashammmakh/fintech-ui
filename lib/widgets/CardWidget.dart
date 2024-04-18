import 'package:flutter/material.dart';

import 'button_main.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  final CardData data;
  final BuildContext context;
  const CardWidget({Key? key, required this.data, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ... معالجة ضغط المستخدم على البطاقة
        show_Dialog(desc: data.title, dialogType: 'S', context: context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                data.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardData {
  final String title;
  final String description;

  CardData(this.title, this.description);
}

final List<CardData> cardsData = [
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  CardData('عنوان البطاقة الأولى', 'وصف البطاقة الأولى'),
  CardData('عنوان البطاقة الثانية', 'وصف البطاقة الثانية'),
  // ... المزيد من البيانات
];
