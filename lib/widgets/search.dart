import 'package:flutter/material.dart';
import '../screens/query_answer.dart';
import '../services/chat_service.dart';
import '../theme/color.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final queryController = TextEditingController();
  final _chatService = ChatAppService();

  @override
  void initState() {
    super.initState();
    _chatService.connect();
  }

  void _handleSearch() {
    if (queryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a query")),
      );
      return;
    }

    _chatService.resetStream(); // Reset stream before new search
    _chatService.chat(queryController.text.trim());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            QueryAnswer(question: queryController.text.trim()),
      ),
    );
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Search Anything...',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: 750,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.searchBarBorder,
              width: 1.25,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: queryController,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _handleSearch,
                child: Icon(
                  Icons.arrow_right_rounded,
                  size: 64,
                  color: AppColors.iconGrey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
