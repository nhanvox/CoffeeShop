import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportDetailPage extends StatefulWidget {
  const SupportDetailPage({super.key});

  @override
  State<SupportDetailPage> createState() => SupportDetailPageState();
}

class SupportDetailPageState extends State<SupportDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        title: const TextQuicksand(
          'NGỌT CÀ PHÊ',
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFEF2),
        elevation: 0,
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 22,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                DateSeparator(date: '8 THG 4 2024'),
                ChatMessage(
                  message: 'Chào bạn! Tôi có thể giúp gì cho bạn?',
                  time: '10:30 AM',
                  isSentByMe: false,
                ),
                ChatMessage(
                  message: 'Tôi muốn đặt mua 1kg cà phê Arabica.',
                  time: '9:31 AM',
                  isSentByMe: true,
                ),
                ChatMessage(
                  message:
                      'Vâng, bạn hãy vào ứng dụng, tìm "Cà phê Arabica", chọn 1kg, và nhấn "Thanh toán". Cần hỗ trợ thêm gì không ạ?',
                  time: '10:30 AM',
                  isSentByMe: false,
                ),
                ChatMessage(
                  message: 'Cảm ơn bạn, tôi làm được rồi.',
                  time: '10:30 AM',
                  isSentByMe: true,
                ),
                ChatMessage(
                  message: 'Rất vui được giúp bạn. Chúc bạn một ngày vui vẻ!',
                  time: '10:30 AM',
                  isSentByMe: false,
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70.0, // Adjust the height as needed
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Gửi yêu cầu hỗ trợ',
                                hintStyle: GoogleFonts.getFont('Quicksand',
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.send,
                                  color: Color(0xFF006C4B)),
                              onPressed: () {
                                // Add functionality to send message
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DateSeparator extends StatelessWidget {
  final String date;

  const DateSeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.center,
      child: Text(
        date,
        style: GoogleFonts.getFont('Quicksand',
            color: Colors.grey, fontSize: 16.0),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final String time;
  final bool isSentByMe;

  const ChatMessage({
    super.key,
    required this.message,
    required this.time,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSentByMe ? const Color(0xffdee2e6) : const Color(0xFFFF725E),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextQuicksand(
              message,
              color: isSentByMe ? Colors.black : Colors.white,
              fontSize: 18.0,
            ),
            const SizedBox(height: 4.0),
            TextQuicksand(
              time,
              color: isSentByMe ? Colors.black54 : Colors.white70,
              fontSize: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
