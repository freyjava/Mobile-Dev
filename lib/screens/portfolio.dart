import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            //   height: 500,
            //   width: 500,
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(width: 10),
            const Text(
              'My Portfolio',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Menu button pressed');
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 50),
            const Center(
              child: SizedBox(
                height: 350,
                width: 350,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Me.jpg'),
                  radius: 100,
                ),
              ),
            ),
            SizedBox(height: 50),
            Column(
              children: [
                const Text(
                  'Welcome to my Portfolio',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                  'Hi I\'m',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Visa Jeffrey',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  'Cyber',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Security',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'I\'m an aspiring Cyber Security,',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'learning about security system.',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'I\’m start from network',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'to improve my network security skills.',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: SocialMediaButton(
                    url:
                        'https://www.instagram.com/_jeffrayy_?igsh=NGtoeWxzcGVjb2pw&utm_source=qr',
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: CVButton(
                    url:
                        'https://www.facebook.com/share/1A82qsf8R3/?mibextid=wwXIfr',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String url;

  const SocialMediaButton({required this.url});

  Future<void> _launchURL() async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: _launchURL,
        child: Text("Hire Me!"),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}

class CVButton extends StatelessWidget {
  final String url;

  const CVButton({required this.url});

  Future<void> _launchURL() async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: OutlinedButton(
        onPressed: _launchURL,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Download CV", style: TextStyle(color: Colors.blue)),
            SizedBox(width: 8),
            Icon(Icons.download, color: Colors.blue),
          ],
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
