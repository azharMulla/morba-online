import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/contact_model.dart';
import '../utils/app_theme.dart';
import '../widgets/contact_category_widget.dart';
import '../services/contact_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<ContactCategory> _filteredCategories = [];
  List<ContactCategory> _allCategories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _searchController.addListener(_onSearchChanged);
  }

  void _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });
    final service = ContactService();
    final categories = await service.fetchCategories();
    setState(() {
      _allCategories = categories;
      _filteredCategories = categories;
      _isLoading = false;
    });
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
      _filteredCategories = _allCategories;
      return;
    }

    _filteredCategories = [];
    
    for (var category in _allCategories) {
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/newLogo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'Morba Online',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search contacts... ',
                      prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.tertiary,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: AppColors.tertiary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
                      ),
                    ),
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
