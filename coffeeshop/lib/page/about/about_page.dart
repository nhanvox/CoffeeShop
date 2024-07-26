import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        title: const Text(
          'Về chúng tôi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFEF2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 30),
            width: 40,
            height: 40,
            decoration: const ShapeDecoration(
              color: Color(0xFFFF725E),
              shape: OvalBorder(),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildStaticCarousel(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Ngọt Cà Phê sẽ là nơi mọi người xích lại gần nhau, sẻ chia thân tình bên những tách cà phê.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _buildApproachSection(),
            _buildContactSection(), // New contact section
            // Add more content here as needed
          ],
        ),
      ),
    );
  }

  Widget _buildStaticCarousel() {
    final List<String> imageUrls = [
      'https://marketplace.canva.com/EAGIBdu-HGc/1/0/1600w/canva-brown-and-white-geometric-we-are-open-banner-7lCFIM8VuLE.jpg',
      'https://minio.thecoffeehouse.com/image/admin/baner-home-web_510005.jpg',
      'https://www.shutterstock.com/image-vector/happy-world-coffee-day-banner-260nw-2206772269.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: imageUrls.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildApproachSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color(0xffFF725E),
        elevation: 5,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Giới thiệu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3),
              Divider(
                color: Colors.yellow,
                thickness: 3,
                endIndent: 270, 
              ),
              SizedBox(height: 3),
              Text(
                'Ngọt Cà Phê không chỉ nổi tiếng với các loại cà phê tuyệt hảo mà còn với thực đơn bánh ngọt phong phú, hấp dẫn.\n\n'
                'Khách hàng có thể thưởng thức các loại bánh ngọt được chế biến tỉ mỉ kết hợp hoàn hảo với tách cà phê nóng hổi. Với phong cách phục vụ tận tình, chuyên nghiệp, cam kết mang đến cho khách hàng những trải nghiệm tuyệt vời nhất, từ chất lượng đồ uống đến không gian và dịch vụ.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color(0xff88d9fe),
        elevation: 5,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Liên hệ chúng tôi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '828 Sư Vạn Hạnh, P.13, Q.10',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
