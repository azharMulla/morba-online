import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../utils/app_theme.dart';
import '../widgets/contact_category_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<ContactCategory> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = sampleContactCategories;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterContacts();
    });
  }

  void _filterContacts() {
    if (_searchQuery.isEmpty) {
      _filteredCategories = sampleContactCategories;
      return;
    }

    _filteredCategories = [];
    
    for (var category in sampleContactCategories) {
      final List<Contact> filteredProviders = category.providers.where((provider) {
        // Search in name
        if (provider.name.toLowerCase().contains(_searchQuery)) {
          return true;
        }
        
        // Search in tags
        for (var tag in provider.tags) {
          if (tag.toLowerCase().contains(_searchQuery)) {
            return true;
          }
        }
        
        return false;
      }).toList();
      
      if (filteredProviders.isNotEmpty) {
        _filteredCategories.add(
          ContactCategory(
            category: category.category,
            providers: filteredProviders,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morba Online'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: AppColors.secondary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: AppColors.secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: AppColors.white,
                hintStyle: const TextStyle(color: AppColors.secondary),
              ),
              cursorColor: AppColors.primary,
            ),
          ),
          Expanded(
            child: _filteredCategories.isEmpty
                ? const Center(
                    child: Text(
                      'No contacts found',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredCategories.length,
                    itemBuilder: (context, index) {
                      return ContactCategoryWidget(
                        category: _filteredCategories[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
