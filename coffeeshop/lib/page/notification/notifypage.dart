import 'package:coffeeshop/page/notification/view/card_notify.dart';
import 'package:flutter/material.dart';

import '../../model/notify.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  final List<Notify> todayNotifications = [
    Notify(
        notifyId: 1,
        role: 1,
        content: 'Bạn có đơn hàng mới.',
        datetime: '10:30 AM'),
    Notify(
        notifyId: 2,
        role: 2,
        content: 'Hệ thống sẽ bảo trì vào tối nay.',
        datetime: '09:00 AM'),
    Notify(
        notifyId: 3,
        role: 1,
        content: 'Cập nhật phiên bản mới.',
        datetime: '08:00 AM'),
  ];

  final List<Notify> weekNotifications = [
    Notify(
        notifyId: 4,
        role: 1,
        content: 'Sản phẩm mới đã có mặt.',
        datetime: 'Thứ Hai, 10:00 AM'),
    Notify(
        notifyId: 5,
        role: 2,
        content: 'Hệ thống sẽ bảo trì vào tối mai.',
        datetime: 'Thứ Ba, 09:00 AM'),
    Notify(
        notifyId: 6,
        role: 1,
        content: 'Đừng bỏ lỡ khuyến mãi.',
        datetime: 'Thứ Tư, 08:00 AM'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFFFFEF2),
            surfaceTintColor: const Color(0xFFFFFEF2),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 33,
                    ),
                    onPressed: () {}),
              ),
            ],
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
            centerTitle: true,
            title: const Text(
              'Thông báo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            floating: true, // Giữ AppBar hiển thị khi cuộn
            pinned: true, // Giữ AppBar cố định
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (todayNotifications.isNotEmpty) ...[
                    const Text(
                      'Hôm nay',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todayNotifications.length,
                      itemBuilder: (context, index) {
                        return CardNotify(notify: todayNotifications[index]);
                      },
                    ),
                    const SizedBox(
                        height: 20), // Thêm khoảng cách giữa các phần
                  ],
                  const Text(
                    'Trong tuần',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: weekNotifications.length,
                    itemBuilder: (context, index) {
                      return CardNotify(notify: weekNotifications[index]);
                    },
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
