import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_model.dart';
import '../utils/app_theme.dart';
import 'tag_widget.dart';

class ContactProviderCard extends StatelessWidget {
  final Contact provider;

  const ContactProviderCard({
    super.key,
    required this.provider,
  });

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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: AppColors.background,
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
                    onTap: () => _makePhoneCall(provider.phone),
                    child: Text(
                      provider.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                if (provider.whatsapp != null) ...[
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.whatsappGreen,
                    ),
                    onPressed: () => _openWhatsApp(provider.whatsapp!),
                  ),
                ],
                IconButton(
                  icon: const Icon(
                    Icons.phone,
                    color: AppColors.primary,
                  ),
                  onPressed: () => _makePhoneCall(provider.phone),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: provider.tags.map((tag) => TagWidget(tag: tag)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
