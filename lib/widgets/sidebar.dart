import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../theme/color.dart';
import 'sidebar_icon.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sideNav,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text(
            "Chatbot Using Gemini",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child:
                        SidebarIcon(icon: Icons.home_outlined, text: "Home")),
                SidebarIcon(icon: Icons.settings, text: "Setting"),
                SidebarIcon(icon: Icons.info_outline, text: "Information"),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
