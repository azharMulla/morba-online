import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../utils/app_theme.dart';
import 'contact_provider_card.dart';

class ContactCategoryWidget extends StatefulWidget {
  final ContactCategory category;

  const ContactCategoryWidget({
    super.key,
    required this.category,
  });

  @override
  State<ContactCategoryWidget> createState() => _ContactCategoryWidgetState();
}

class _ContactCategoryWidgetState extends State<ContactCategoryWidget> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppColors.white,
      child: Column(
        children: [
          // Custom header without arrow
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: Radius.circular(_isExpanded ? 0.0 : 10.0),
                  bottomRight: Radius.circular(_isExpanded ? 0.0 : 10.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.category.category,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Body content with animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  heightFactor: _heightFactor.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Opacity(
                      opacity: _heightFactor.value,
                      child: Column(
                        children: widget.category.providers.map((provider) {
                          return ContactProviderCard(provider: provider);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
