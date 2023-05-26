import 'package:gsheets/gsheets.dart';
import 'package:mozak/model/UserFormModel.dart';

class MozakSheetApi {
  static final _credentials = '''
  {
  "type": "service_account", 
  "project_id": "mozak-345313", 
  "private_key_id": "dc391555a9657b7dd8f2045b44eff9ed930b82a6", 
  "private_key": "-----BEGIN PRIVATE KEY-----\\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDF9owSmyubbSbA\\nbh+Kg7BX03WPQ+LtW6BtX8nLyaVUZkRAptOChL0jIlu5DRAe1PckL3gHz+hV8QmR\\nk7wGJo4cOQz66zTcmrQ84kK65lgUkSnbWt9nWP/y9fIs+gKJlR7HIkm8pDjjkUsn\\nCCyaDHlW47Mgw6YTvkrbn1N/ucWtY8YQgL1Np5PztJ9/+UFBgSg8DWVixMZMU+UG\\nQle6QHmJkGTewCI11TTieE94BLLDf7/rjToCAc8Nsxr/y1cu07s2AlurYcW2j5rX\\ns4MMjy2FJ3qwgTFN/3g053cQw2NS26P2zxzQem6xlCMqn7lw3zsxce4YqrUSkXkj\\n7javooodAgMBAAECggEAAWH4Nv4N9yszQNdUEZHbZrWjpdFF0b4Y2AK6BFofdUA0\\nnFX99rSqJIduKBP7B5gZtM8/EaDmYMlK9ZEYWFunFPPiDxOa/ip3dVBoQmlu9o/Q\\nAMf49P4WZZJJs344i9D2ktH+vVpRSmeepIJmW1oYc96pxuIO9CbZW4DYorT/uDcN\\nyAlR1+gsZp2PHSFkwti6beJDZ8IkeF1jSKjNAAY6SRkqVE8Ws1UKAXkd3MK0UMph\\nvMVEIx+gg8FV2B43FULKGGMV0felHRuOmzfQot5hmI4RYufSz31iImVr1MmJCUgP\\nIukNClHqcLHVYFBrZqb+x4zehOYpZAVs09KnODXq2QKBgQD2SGVVkpWokk6FlHg1\\nOkeIGh7W5NMgwi3ZgNH6gacJlCl1GqW11bT6W0F2b++b5H9y9NxITBwbTJ1xZurS\\nEJoMtwKWgloB3EHHsyW9F3sadjMxekfvHzYSO+y/QIbDvkz3GJvrfb3PZd/ohrhd\\n1/hZAsVe9+AkJsCxliNYjFqNiQKBgQDNxhfWVkEk9lLRh6wrobnSH5ZP19FcjXGZ\\n9zNQ4Bv9jEoJFjhWm9UZYqd9hZkr2JlhtfSGrKldajQ56WB6OdcNnGYjXZ64G1yq\\nTZA7THPd9vRRnZGj4KlzhJ9uku7Ycodza93u+8v/Abqe8cE1P3qQyPIl1nLhWhec\\nNmtZz1Dm9QKBgHg4OLb/2ewylv/fzJn2++n1Di7J/kGUZ/svRdCpr1cequoN+uv7\\nCN/Y4eillWocrRX5bvofpOyyhnxPx7qI/hnM0AeWU8dqs/V+fqKCLsZpAm5ZiXmx\\nW5ylAdkN73rnjvxjV+EpPRlbWmRQNvkgLouMrbnA9/nNrOxDJLfZs245AoGBAIdx\\nKQWClrR+kfqqo6/AbrAY7HY3Zu3Vh/3A0X0dVi8opR6gCosvXS+tWPNs+Wn70tGW\\n05HFmmELY77ulvs8kQm7dRs4Jx2lnPPXw+TUKLvkLeJ+pXtJiB+qHsrIWgAMOo3F\\nZTpFcHu0JqMyG2syEjm0mnY/VjRweXPv+e8OX4D1AoGBAOK2oSD59xS9e4jMED5R\\njeO8qiD9QbJUGhq2a0cScG8vPo3kQuJ++WN00XTyskX2x+NWUH6rpoNNlYmd3w/6\\nQGIwVv1+qcRcJGi7NEBsETVofebEUKkVngkipVV967b5CH/9GshpR/uhoRFInsYR\\neDEF98Y5bbjPd3V5dd5cBuMD\\n-----END PRIVATE KEY-----\\n", 
  "client_email": "mozak-180@mozak-345313.iam.gserviceaccount.com", 
  "client_id": "101017947240862102128", 
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/mozak-180%40mozak-345313.iam.gserviceaccount.com"
}

  ''';

  // "auth_uri": "${FlutterConfig.get('AUTH_URI')}"
  // "type": "${FlutterConfig.get('TYPE')}",
  // "token_uri": "${FlutterConfig.get('TOKEN_URI')}",
  // "auth_provider_x509_cert_url": "${FlutterConfig.get('AUTH_PROVIDER_x509_CERT_URL')}",
  // "client_x509_cert_url": "${FlutterConfig.get('CLIENT_x509_CERT_URL')}"

  static final _spreadSheetId = "1cMNuUIHbaC0kpykIj-Jt524WUK7R9qigoxcKpnoSEg0";
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  getUserData() {}

  static Future insertUserData(UserFormModel model) async {
    try {
      final spreadSheet = await _gSheets.spreadsheet(_spreadSheetId);
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
        model.getRefGrp(),
        model.getReferenceName(),
        model.getInTeamRef(),
        DateTime.now().toString()
      ]);
    } catch (e) {
      print('Init Error $e');
    }
  }
}
