import 'dart:async';
import '../models/contact_model.dart';

class ContactService {
  // Simulate an API call with a delay
  Future<List<ContactCategory>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    final List<Map<String, dynamic>> data = _dummyData;
    return data.map((cat) => ContactCategory.fromJson(cat)).toList();
  }
}

// Dummy data in the same structure as your example
const List<Map<String, dynamic>> _dummyData = [
  {
    "category": "Doctor",
    "contacts": [
      {
        "name": "Dr. Aasiya Kaldane",
        "number": "+919881418476",
        "whatsapp": "+919881418476",
        "id": "001001",
        "displayTags": ["General Physician"],
        "tags": ["doctor", "general physician"],
        "location": "18.21226089774279, 73.24732872236157"
      },
      {
        "name": "Dr. Afsha A Mulla",
        "number": "+919326175202",
        "id": "001002",
        "displayTags": ["Physiotherapy", "FitMe Physiotherapy"],
        "tags": ["doctor", "physiotherapy", "fitme", "fit me", "exercise"]
      },
      {
        "name": "Dr. Farasat Khan (Mahad)",
        "number": "+919373437863",
        "whatsapp": "+919373437863",
        "id": "001003",
        "displayTags": ["Child Specialist", "Mahad"],
        "tags": ["doctor", "child specialist", "Pediatrician"]
      },
      {
        "name": "Dr. Mohammed Rawoot",
        "number": "+917775994328",
        "displayTags": ["Hasina Clinic", "BHMS"],
        "location": "18.211900908297352, 73.2478328228273",
        "whatsapp": "+917775994328",
        "id": "001004",
        "tags": ["doctor", "bhms", "emergency", "ems", "hasina clinic"]
      },
      {
        "name": "Dr. Mubeen Gazge",
        "number": "+917709214543",
        "id": "001005",
        "displayTags": ["Physiotherapy Clinic", "Physiotherapy"],
        "whatsapp": "+918087688830",
        "tags": ["doctor", "Physiotherapy Clinic", "exercise", "mubin gazge"]
      },
      {
        "name": "Dr. Mudassir Khatib (Goregaon)",
        "number": "+919158652656",
        "id": "001006",
        "displayTags": ["Dentist", "Goregaon"],
        "whatsapp": "+919823775941",
        "location": "18.154245008822684, 73.29289454436878",
        "tags": ["doctor", "dentist", "goregaon"]
      },
      {
        "name": "Dr. Nadiya Ali Banderkar (Mulla)",
        "id": "001007",
        "number": "+918975601030",
        "displayTags": ["Dentist", "Dr Nadiya Azhar Mulla"],
        "whatsapp": "+918975601030",
        "tags": ["doctor", "dentist", "dental", "careodent", "nadiya mulla"],
        "location": "18.211975008013084, 73.2478413034047",
        "img": [
          "https://i.ibb.co/KyJZ7VB/IMG-20171120-125655.jpg",
          "https://i.ibb.co/rbNq0xS/IMG-20171120-130829.jpg",
          "https://i.ibb.co/hcdPSHV/IMG-20171120-145002-Bokeh.jpg"
        ]
      },
      {
        "name": "Dr. Nizam Chougale",
        "number": "+919373624645",
        "id": "001008",
        "location": "18.210646091131046, 73.24832011201293",
        "displayTags": ["BHMS"],
        "whatsapp": "+919373624645",
        "tags": ["doctor", "bhms"]
      },
      {
        "name": "Dr. Prakash R. Mehta",
        "number": "+919403320031",
        "id": "001009",
        "whatsapp": "+919403320031",
        "location": "18.211603915679106, 73.2482832158908",
        "tags": ["doctor"]
      },
      {
        "id": "001010",
        "name": "Dr. Rubina Antule",
        "number": "+917385636559",
        "location": "18.208466553492524, 73.24787456085396",
        "displayTags": ["Ruby Clinic", "BHMS"],
        "whatsapp": "+917385636559",
        "tags": ["doctor", "bhms", "ruby clinic"]
      },
      {
        "id": "001011",
        "name": "Dr. Safana Jameel Rawoot",
        "number": "+919370389133",
        "whatsapp": "+919370389133",
        "displayTags": ["BHMS", "Homeopathic Medicine"],
        "tags": ["doctor", "emergency", "bhms", "homeopathy", "homeopathic clinic"]
      },
      {
        "id": "001012",
        "name": "Dr. Sameer Aamdani",
        "number": "+917038904066",
        "displayTags": ["Arfan Health Care"],
        "tags": ["doctor", "arfan health care"]
      },
      {
        "id": "001013",
        "name": "Dr. Shagufa Dhansay",
        "number": "+919765613501",
        "whatsapp": "+919765613501",
        "location": "18.211821556129166, 73.24816804127914",
        "displayTags": ["Physiotherapy", "Active Fit Physiotherapy"],
        "tags": ["doctor", "physiotherapy", "activefit", "active fit", "exercise"]
      },
      {
        "id": "001014",
        "name": "Dt. Tahoor Mulla",
        "number": "+918149499298",
        "whatsapp": "+918149499298",
        "displayTags": ["Dietitian", "Nutritionist"],
        "tags": ["dietitian", "nutritionist"]
      }
    ]
  },
  {
    "category": "Hospital",
    "contacts": [
      {
        "id": "005001",
        "name": "Konkan Hospital, Morba",
        "number": "+919699220031",
        "whatsapp": "+918446446858",
        "location": "18.205651253133595, 73.25638684962817",
        "tags": ["doctor", "hospital"]
      }
    ]
  }
];
