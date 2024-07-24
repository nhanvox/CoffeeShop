import 'dart:io';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../config/config.dart';
import '../../config/login_status.dart';
import '../login/view/loginscreen.dart';

class UpdateAccountPage extends StatefulWidget {
  const UpdateAccountPage({super.key});

  @override
  _UpdateAccountPageState createState() => _UpdateAccountPageState();
}

class _UpdateAccountPageState extends State<UpdateAccountPage> {
  bool _hasProfile = false;
  Map<String, dynamic>? _profile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
    _checkProfile();
  }

  void checkUserLoggedIn() async {
    String? userId = LoginStatus.instance.userID;

    if (userId == null) {
      // Người dùng chưa đăng nhập, điều hướng đến trang đăng nhập
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Loginscreen()));
      });
    } else {
      // Người dùng đã đăng nhập, lấy thông tin hồ sơ
      _getProfile(userId);
    }
  }

  void _getProfile(String userId) async {
    try {
      Uri getProfileUrl = Uri.parse(getProfileByUser + userId);
      var response = await http.get(getProfileUrl);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          var profile = jsonResponse['profile'];
          setState(() {
            _nameController.text = profile['name'] ?? '';
            _phoneController.text = profile['phoneNumber'] ?? '';
            _addressController.text = profile['address'] ?? '';
            _imagePath = profile['image'];
          });
        }
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _enterImageUrl() async {
    final url = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nhập URL hình ảnh'),
          content: TextField(
            controller: _imageUrlController,
            decoration: const InputDecoration(hintText: 'URL hình ảnh'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_imageUrlController.text);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    if (url != null && url.isNotEmpty) {
      setState(() {
        _imagePath = url;
      });
    }
  }

  Future<void> _checkProfile() async {
    String? userId = LoginStatus.instance.userID;

    if (userId == null) return;

    try {
      Uri getProfileUrl = Uri.parse(getProfileByUser + userId);
      var response = await http.get(getProfileUrl);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          var profile = jsonResponse['profile'];
          setState(() {
            _hasProfile = profile != null;
            _profile = profile;
          });
        }
      } else {
        print('Failed to get profile');
      }
    } catch (e) {
      print('Error checking profile: $e');
    }
  }

  void _addProfile() async {
    String? userId = LoginStatus.instance.userID;

    if (userId == null) return;

    final data = {
      'userid': userId,
      'name': _nameController.text,
      'phoneNumber': _phoneController.text,
      'address': _addressController.text,
      'image': _imagePath ?? '',
    };

    try {
      Uri addProfileUrl = Uri.parse(addProfile);
      var addProfileResponse = await http.post(
        addProfileUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (addProfileResponse.statusCode == 200) {
        var jsonResponse = jsonDecode(addProfileResponse.body);
        if (jsonResponse['success'] == true) {
          _showUpdateSuccessDialog(context);
        }
      } else {
        print('Failed to update profile');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> _updateProfile() async {
    String? userId = LoginStatus.instance.userID;

    if (userId == null || _profile == null) return;

    final data = {
      'userid': userId,
      'name': _nameController.text,
      'phoneNumber': _phoneController.text,
      'address': _addressController.text,
      'image': _imagePath ?? '',
    };

    String profileId = _profile!['_id'];

    try {
      Uri updateProfileUrl = Uri.parse(updateProfile + profileId);
      var updateProfileResponse = await http.put(
        updateProfileUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (updateProfileResponse.statusCode == 200) {
        var jsonResponse = jsonDecode(updateProfileResponse.body);
        if (jsonResponse['success'] == true) {
          _showUpdateSuccessDialog(context);
        }
      } else {
        print('Failed to update profile');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

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
                          child: const TextQuicksand(
                            'Hủy',
                            textAlign: TextAlign.center,
                            color: Color(0xFFB0B0B0),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextQuicksand(
                          _hasProfile ? 'CẬP NHẬT' : 'TẠO',
                          textAlign: TextAlign.center,
                          color: const Color(0xFFFF725E),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        TextButton(
                          onPressed: () {
                            if (_hasProfile) {
                              _updateProfile();
                            } else {
                              _addProfile();
                            }
                          },
                          child: TextQuicksand(
                            _hasProfile ? 'Lưu' : 'Thêm',
                            textAlign: TextAlign.center,
                            color: _hasProfile
                                ? const Color(0xFF9290FF)
                                : const Color(0xFF9290FF),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
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
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const TextQuicksand(
                                'Chọn ảnh từ thư viện',
                                fontSize: 17,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.link),
                              title: const TextQuicksand(
                                'Nhập URL hình ảnh',
                                fontSize: 17,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _enterImageUrl();
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: _imagePath != null
                            ? (_imagePath!.startsWith('http')
                                ? NetworkImage(_imagePath!)
                                : FileImage(File(_imagePath!)) as ImageProvider)
                            : const AssetImage(
                                'assets/images/avatar_default.png'),
                      ),
                      const Positioned(
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    _buildTextField('Họ tên', _nameController),
                    _buildTextField('Số điện thoại', _phoneController),
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
        style: GoogleFonts.getFont(
          'Quicksand',
          color: Colors.black,
          fontSize: 21,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.getFont(
            'Quicksand',
            color: const Color(0xFFB0B0B0),
            fontSize: 25,
            fontWeight: FontWeight.w600,
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
