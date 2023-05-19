import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../my_config.dart';
import '../shared/storage.dart';
import '/models/medication.dart';

class UserService {
  Storage storage = Storage();

  Future<Map<String, dynamic>> addMedicationProfile(Medication med) async {
    final url = Uri.parse(Config.userMedications);
    String? token;
    await storage.getToken().then((value) {
      token = value;
    });

    final response = await http.post(
      url,
      headers: {
        "content-type": "application/json",
        "Authorization": "JWT $token",
      },
      body: json.encode(
        {
          "title": med.title,
          "medicines": med.medicineIds,
        },
      ),
    );

    final responseData = json.decode(response.body);
    // log('$responseData');
    return responseData;
  }

  Future<Map<String, dynamic>> editMedicationProfile(
      Medication med, int id) async {
    final url = Uri.parse('${Config.userMedications}$id/');
    Map<String, dynamic>? body;
    if (med.title.isNotEmpty && med.medicineIds.isNotEmpty) {
      body = {"title": med.title, "medicines": med.medicineIds};
    } else if (med.title.isEmpty && med.medicineIds.isNotEmpty) {
      body = {"medicines": med.medicineIds};
    } else if (med.medicineIds.isEmpty && med.title.isNotEmpty) {
      body = {"title": med.title};
    }

    String? token;
    await storage.getToken().then((value) {
      token = value;
    });

    final response = await http.patch(
      url,
      headers: {
        "content-type": "application/json",
        "Authorization": "JWT $token",
      },
      body: json.encode(body),
    );

    final responseData = json.decode(response.body);
    // log('$responseData');
    if (responseData['details'] == null) {
      return responseData;
    }
    return responseData;
  }

  Future<Map<String, dynamic>> getMedications() async {
    final url = Uri.parse(Config.userMedications);
    String? token;
    await storage.getToken().then((value) {
      token = value;
    });

    final response = await http.get(
      url,
      headers: {
        "content-type": "application/json",
        "Authorization": "JWT $token",
      },
    );

    final responseData = json.decode(response.body);
    // log('$responseData');
    if (responseData['details'] == null) {
      return responseData;
    }
    return responseData;
  }

  Future<void> deleteMedication(int id) async {
    final url = Uri.parse('${Config.userMedications}$id/');
    String? token;
    await storage.getToken().then((value) {
      token = value;
    });

    final response = await http.delete(
      url,
      headers: {
        "content-type": "application/json",
        "Authorization": "JWT $token",
      },
    );
  }
}
