import 'package:flutter_config/flutter_config.dart';
import 'package:gsheets/gsheets.dart';
import 'package:mozak/model/UserFormModel.dart';

class MozakSheetApi {
  static final _credentials = '''
  {
  "type": "${FlutterConfig.get('TYPE')}", 
  "project_id": "${FlutterConfig.get('PROJECT_ID')}", 
  "private_key_id": "${FlutterConfig.get('PRIVATE_KEY_ID')}", 
  "private_key": "${FlutterConfig.get('MY_PRIVATE_KEY')}", 
  "client_email": "${FlutterConfig.get('CLIENT_EMAIL')}", 
  "client_id": "${FlutterConfig.get('CLIENT_ID')}", 
  "auth_uri": "${FlutterConfig.get('AUTH_URI')}",
  "token_uri": "${FlutterConfig.get('TOKEN_URI')}",
  "auth_provider_x509_cert_url": "${FlutterConfig.get('AUTH_PROVIDER_x509_CERT_URL')}",
  "client_x509_cert_url": "${FlutterConfig.get('CLIENT_x509_CERT_URL')}"
}

  ''';

  static final _spreadSheetId = FlutterConfig.get('SPREAD_SHEET_ID');
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future insertUserData(UserFormModel model) async {
    try {
      final spreadSheet = await _gSheets.spreadsheet(_spreadSheetId!);
      _userSheet = spreadSheet.worksheetByTitle("Users");
      var lastRow = await _userSheet?.values.map.lastRow();
      int id = 1;
      if (null != lastRow) {
        id = int.parse(lastRow['id']!) + 1;
      }
      await _userSheet?.values.appendRow([
        id,
        model.getGender(),
        model.getFirstName(),
        model.getMiddleName(),
        model.getLastName(),
        model.getDOB(),
        model.getEmail(),
        model.getContactNo(),
        model.getStreetAddress(),
        model.getCity(),
        model.getState(),
        model.getBloodGroup(),
        model.getCareerType(),
        model.getCollegeName(),
        model.getCourseName(),
        model.getCompanyName(),
        model.getDesignation(),
        model.getReferenceName()
      ]);
    } catch (e) {
      print('Init Error $e');
    }
  }
}
