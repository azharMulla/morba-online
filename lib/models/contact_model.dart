class Contact {
  final String name;
  final List<String> tags;
  final List<String>? displayTags;
  final String phone;
  final String? whatsapp;
  final String? id;
  final String? location;
  final List<String>? img;

  Contact({
    required this.name,
    required this.tags,
    required this.phone,
    this.displayTags,
    this.whatsapp,
    this.id,
    this.location,
    this.img,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'] ?? '',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      displayTags: (json['displayTags'] as List?)?.map((e) => e.toString()).toList(),
      phone: json['number'] ?? json['phone'] ?? '',
      whatsapp: json['whatsapp'],
      id: json['id'],
      location: json['location'],
      img: (json['img'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

class ContactCategory {
  final String category;
  final List<Contact> providers;

  ContactCategory({
    required this.category,
    required this.providers,
  });

  factory ContactCategory.fromJson(Map<String, dynamic> json) {
    return ContactCategory(
      category: json['category'] ?? '',
      providers: (json['contacts'] as List?)?.map((e) => Contact.fromJson(e)).toList() ?? [],
    );
  }
}

// Sample data
List<ContactCategory> sampleContactCategories = [
  ContactCategory(
    category: 'Doctor',
    providers: [
      Contact(
        name: 'Dr. Aasiya Kaldane',
        tags: ['General Physician'],
        phone: '1234567890',
        whatsapp: '1234567890',
      ),
      Contact(
        name: 'Dr. Afsha A Mulla',
        tags: ['Physiotherapy', 'FitMe Physiotherapy'],
        phone: '2345678901',
        whatsapp: '2345678901',
      ),
      Contact(
        name: 'Dr. Ahmed Khan',
        tags: ['Cardiologist', 'Heart Specialist'],
        phone: '3456789012',
      ),
    ],
  ),
  ContactCategory(
    category: 'Plumber',
    providers: [
      Contact(
        name: 'Rahul Patil',
        tags: ['Emergency Plumbing', '24/7 Service'],
        phone: '4567890123',
        whatsapp: '4567890123',
      ),
      Contact(
        name: 'Suresh Kumar',
        tags: ['Residential Plumbing'],
        phone: '5678901234',
      ),
    ],
  ),
  ContactCategory(
    category: 'Electrician',
    providers: [
      Contact(
        name: 'Prakash Sharma',
        tags: ['Residential', 'Commercial'],
        phone: '6789012345',
        whatsapp: '6789012345',
      ),
      Contact(
        name: 'Vinod Mehta',
        tags: ['Emergency Service', 'Wiring Specialist'],
        phone: '7890123456',
      ),
    ],
  ),
  ContactCategory(
    category: 'Hotel',
    providers: [
      Contact(
        name: 'Grand Hyatt',
        tags: ['5-Star', 'Luxury'],
        phone: '8901234567',
        whatsapp: '8901234567',
      ),
      Contact(
        name: 'Hotel Taj',
        tags: ['Premium', 'Business Hotel'],
        phone: '9012345678',
      ),
    ],
  ),
];
