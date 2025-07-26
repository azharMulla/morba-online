import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_model.dart';
import '../utils/app_theme.dart';

class ContactDetailsScreen extends StatefulWidget {
  final Contact contact;

  const ContactDetailsScreen({
    super.key,
    required this.contact,
  });

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> with SingleTickerProviderStateMixin {
  bool _isPhotosExpanded = true;
  int _currentImageIndex = 0;
  PageController _pageController = PageController();
  Timer? _autoSlideTimer;
  bool _isAutoSliding = true;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    final Uri launchUri = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _openMaps(String location) async {
    final coordinates = location.split(',');
    if (coordinates.length != 2) return;
    
    final lat = coordinates[0].trim();
    final lng = coordinates[1].trim();
    final Uri launchUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  void initState() {
    super.initState();
    // Start auto-sliding when the screen opens
    _startAutoSlide();
  }

  @override
  void dispose() {
    _stopAutoSlide();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    // Auto-slide every 3 seconds
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_isAutoSliding && widget.contact.img != null && widget.contact.img!.length > 1) {
        final nextIndex = (_currentImageIndex + 1) % widget.contact.img!.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
  }

  void _toggleAutoSlide() {
    setState(() {
      _isAutoSliding = !_isAutoSliding;
      if (_isAutoSliding) {
        _startAutoSlide();
      } else {
        _stopAutoSlide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contact.name,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Button
                  if (widget.contact.location != null)
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _openMaps(widget.contact.location!),
                        icon: const Icon(Icons.location_on, color: AppColors.white),
                        label: const Text(
                          'Open in Maps',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 24.0),
                  
                  // Photos Accordion
                  if (widget.contact.img != null && widget.contact.img!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isPhotosExpanded = !_isPhotosExpanded;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Photos',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  _isPhotosExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_isPhotosExpanded) ...[
                          const SizedBox(height: 16.0),
                          Container(
                            height: 300,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Expanded(
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: widget.contact.img!.length,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentImageIndex = index;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(color: AppColors.tertiary),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network(
                                            widget.contact.img![index],
                                            fit: BoxFit.contain,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                  color: Colors.red,
                                                  size: 48,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Auto-slide toggle button
                                    IconButton(
                                      onPressed: _toggleAutoSlide,
                                      icon: Icon(
                                        _isAutoSliding ? Icons.pause_circle : Icons.play_circle,
                                        color: AppColors.primary,
                                      ),
                                      tooltip: _isAutoSliding ? 'Pause auto-slide' : 'Start auto-slide',
                                    ),
                                    // Previous button
                                    IconButton(
                                      onPressed: _currentImageIndex > 0
                                          ? () {
                                              _pageController.previousPage(
                                                duration: const Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          : null,
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: _currentImageIndex > 0 ? AppColors.primary : Colors.grey,
                                      ),
                                    ),
                                    // Dots indicator
                                    ...List.generate(
                                      widget.contact.img!.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          _pageController.animateToPage(
                                            index,
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentImageIndex == index
                                                ? AppColors.primary
                                                : AppColors.tertiary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Next button
                                    IconButton(
                                      onPressed: _currentImageIndex < widget.contact.img!.length - 1
                                          ? () {
                                              _pageController.nextPage(
                                                duration: const Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          : null,
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: _currentImageIndex < widget.contact.img!.length - 1
                                            ? AppColors.primary
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _makePhoneCall(widget.contact.phone),
                icon: const Icon(Icons.phone, color: AppColors.white),
                label: const Text(
                  'Call',
                  style: TextStyle(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            if (widget.contact.whatsapp != null)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _openWhatsApp(widget.contact.whatsapp!),
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, color: AppColors.white),
                  label: const Text(
                    'WhatsApp',
                    style: TextStyle(color: AppColors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whatsappGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.tertiary, width: 1.0),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          fontSize: 14.0,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
