import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/support/support_detail.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => SupportPageState();
}

class SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        title: const TextQuicksand(
          'HỖ TRỢ',
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFEF2),
        leading: IconButton(
          icon: const Icon(
            size: 36,
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SupportDetailPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-vector/chatbot-chat-message-vectorart_78370-4104.jpg'), // Replace with the image URL or asset path
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextQuicksand(
                          'Ngọt Cà Phê',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 8.0),
                        TextQuicksand(
                          'Rất vui được giúp bạn. Chúc bạn một ngày mới tốt lành.',
                          maxLine: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4.0),
                            TextQuicksand(
                              '15 phút trước',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
