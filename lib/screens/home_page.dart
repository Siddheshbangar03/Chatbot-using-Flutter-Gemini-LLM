import 'package:chatbot_using_gemini/widgets/search.dart';
import 'package:chatbot_using_gemini/widgets/sidebar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          kIsWeb ? Sidebar() : SizedBox(),
          Expanded(
            child: Search(),
          ),
        ],
      ),
    );
  }
}
