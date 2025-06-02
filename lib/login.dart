import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;
  final String currentLang;
  final Function(String) onLangChanged;

  const LoginScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.currentLang,
    required this.onLangChanged,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Map<String, Map<String, String>> localizedStrings = {
    'en': {'greeting': 'Hello!', 'login': 'Login', 'mode': 'Dark Mode'},
    'fr': {'greeting': 'Salut!', 'login': 'Connexion', 'mode': 'Mode sombro'},
    'kh': {'greeting': 'សួស្តី!', 'login': 'ចូល', 'mode': 'ផ្ទាំងងងឹត'},
  };

  @override
  Widget build(BuildContext context) {
    final greeting =
        localizedStrings[widget.currentLang]!['greeting'] ?? 'Hello!';
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizedStrings[widget.currentLang]!['login'] ?? 'Login',
              style: const TextStyle(
                color: Color.fromRGBO(255, 122, 0, 1),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 3,
              color: const Color.fromRGBO(255, 122, 0, 1),
              width: 86,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: bottomInset + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logoImage2.png'),
              const SizedBox(height: 50),
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(255, 122, 0, 1),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 122, 0, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Logged in as ${_usernameController.text}',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    localizedStrings[widget.currentLang]!['login'] ?? 'Login',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- Language Buttons with Flags ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['en', 'fr', 'kh'].map((lang) {
                  final isSelected = widget.currentLang == lang;
                  final flagAsset = {
                    'en': 'assets/images/flag_en.png',
                    'fr': 'assets/images/flag_fr.png',
                    'kh': 'assets/images/flag_kh.png',
                  }[lang]!;

                  return GestureDetector(
                    onTap: () => widget.onLangChanged(lang),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromRGBO(255, 122, 0, 1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 122, 0, 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(flagAsset, width: 24, height: 24),
                          const SizedBox(width: 6),
                          Text(
                            lang.toUpperCase(),
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 122, 0, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              // --- Dark Mode Toggle Horizontal Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizedStrings[widget.currentLang]!['mode'] ??
                        'Dark mode',
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: widget.isDarkMode,
                    onChanged: widget.onThemeChanged,
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
