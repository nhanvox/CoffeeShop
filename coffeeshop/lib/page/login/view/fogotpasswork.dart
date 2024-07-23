import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Bo góc khung hộp thoại
      ),
      insetPadding: const EdgeInsets.all(10), // Giảm đệm xung quanh hộp thoại
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width *
            0.9, // Điều khiển chiều rộng của hộp thoại
        decoration: BoxDecoration(
          color: const Color(0xFFFFFEF2), // Thiết lập màu nền cho hộp thoại
          borderRadius: BorderRadius.circular(16.0), // Bo góc khung hộp thoại
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pop(context), // Điều hướng quay lại khi nhấn
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Quên mật khẩu',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Nhập email của bạn để nhận liên kết đặt lại mật khẩu.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Quicksand',
                    height: 1.5,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Color(0xFFFF725E)),
                  hintText: 'Nhập email',
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    backgroundColor: const Color(0xFF2A4261),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'GỬI YÊU CẦU',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
