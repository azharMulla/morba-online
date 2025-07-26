import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_model.dart';
import '../utils/app_theme.dart';
import '../screens/contact_details_screen.dart';
import 'tag_widget.dart';

class ContactProviderCard extends StatefulWidget {
  final Contact provider;

  const ContactProviderCard({
    super.key,
    required this.provider,
  });

  @override
  State<ContactProviderCard> createState() => _ContactProviderCardState();
}

class _ContactProviderCardState extends State<ContactProviderCard> {
  bool _isHovered = false;

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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        elevation: _isHovered ? 2.0 : 0,
        color: _isHovered ? AppColors.tertiary.withOpacity(0.8) : AppColors.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: AppColors.tertiary,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.provider.location != null || (widget.provider.img != null && widget.provider.img!.isNotEmpty)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactDetailsScreen(contact: widget.provider),
                          ),
                        );
                      } else {
                        _makePhoneCall(widget.provider.phone);
                      }
                    },
                    child: Text(
                      widget.provider.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                // Show info icon if contact has location or images
                if (widget.provider.location != null || (widget.provider.img != null && widget.provider.img!.isNotEmpty)) 
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailsScreen(contact: widget.provider),
                        ),
                      );
                    },
                  ),
                if (widget.provider.whatsapp != null) ...[
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.whatsappGreen,
                    ),
                    onPressed: () => _openWhatsApp(widget.provider.whatsapp!),
                  ),
                ],
                IconButton(
                  icon: const Icon(
                    Icons.phone,
                    color: AppColors.primary,
                  ),
                  onPressed: () => _makePhoneCall(widget.provider.phone),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Display displayTags instead of tags (tags are used only for search)
            if (widget.provider.displayTags != null && widget.provider.displayTags!.isNotEmpty)
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: widget.provider.displayTags!.map((tag) => TagWidget(tag: tag)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
