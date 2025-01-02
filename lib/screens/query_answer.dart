import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/answer.dart';
import '../widgets/sidebar.dart';

class QueryAnswer extends StatelessWidget {
  final String question;

  const QueryAnswer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          kIsWeb ? Sidebar() : SizedBox(),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Answer for Your Question',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    question,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Answer(),
                ],
              ),
            ),
          ),
          // Placeholder(
          //   strokeWidth: 0,
          //   color: AppColors.background,
          // ),
        ],
      ),
    );
  }
}
