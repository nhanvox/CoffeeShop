import 'package:flutter/material.dart';

class UpdateAccountPage extends StatefulWidget {
  const UpdateAccountPage({super.key});

  @override
  State<UpdateAccountPage> createState() => _UpdateAccountPageState();
}

class _UpdateAccountPageState extends State<UpdateAccountPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFFFEDED),
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlexibleSpaceBar(
                    titlePadding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    centerTitle: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Hủy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFB0B0B0),
                              fontSize: 22,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Text(
                          'Cập nhật',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFF725E),
                            fontSize: 25,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _showUpdateSuccessDialog(context);
                          },
                          child: const Text(
                            'Lưu',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF9290FF),
                              fontSize: 22,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD5D5D5),
                    thickness: 1,
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: const Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundImage:
                          AssetImage('assets/images/avatar_default.png'),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFFF725E),
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    _buildTextField('Họ tên', _nameController),
                    _buildTextField('Email', _emailController),
                    _buildTextField('Số điện thoại', _phoneController),
                    _buildTextField('Mật khẩu', _passwordController,
                        obscureText: true),
                    _buildTextField('Địa chỉ', _addressController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 21,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFFB0B0B0),
            fontSize: 21,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD5D5D5)),
          ),
        ),
      ),
    );
  }

  void _showUpdateSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 300,
                height: 180,
                margin: const EdgeInsets.only(top: 38),
                padding: const EdgeInsets.only(right: 30, left: 30, top: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Cập nhật thành công!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF725E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: const Text(
                          'Tiếp tục',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 10,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/check_mark.png'),
                      ),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
