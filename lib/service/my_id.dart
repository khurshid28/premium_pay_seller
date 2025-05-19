import 'package:premium_pay_seller/export_files.dart';

class MyIdService {
  Future<MyIdResult?> scan(
      {required String passport, required String birthdate}) async {
    for (var i = 0; i < 100; i++) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
    print(Environment.myIdClientId);
    print(passport);
    print(birthdate);











    var result = await MyIdClient.start(
      config: MyIdConfig(
        clientId: Environment.myIdClientId,
        clientHash: Environment.myIdClientHash,
        clientHashId: Environment.myIdClientHashId,
        environment: MyIdEnvironment.DEBUG,

        // cameraResolution : MyIdCameraResolution.LOW,
        // imageFormat: MyIdImageFormat.PNG,

        residency: MyIdResidency.RESIDENT,
        locale: MyIdLocale.UZBEK,
        // cameraSelector: MyIdCameraSelector.FRONT,
        entryType: MyIdEntryType.IDENTIFICATION,
        passportData: passport,
        dateOfBirth: birthdate, 
        minAge: 18,
      ),
      // iosAppearance: const MyIdIOSAppearance(),
    );

    return result;
  }
}
