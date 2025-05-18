import 'package:premium_pay_seller/export_files.dart';


class MyIdService {
  Future<MyIdResult?> scan({required String passport, required String birthdate}) async {
    var result = await MyIdClient.start(
      config: MyIdConfig(
        clientId: Environment.myIdClientId,
        clientHash: Environment.myIdClientHash,
        clientHashId: Environment.myIdClientHashId,
        cameraResolution : MyIdCameraResolution.HIGH,
        imageFormat: MyIdImageFormat.PNG,

        residency: MyIdResidency.RESIDENT,
        locale : MyIdLocale.UZBEK,
        cameraSelector: MyIdCameraSelector.FRONT,
        entryType  : MyIdEntryType.FACE_DETECTION,
        passportData: passport, // 'AB1234567',
        dateOfBirth: birthdate, // '01.09.1991',
        minAge: 18,
        

        // MyIdBuildMode.PRODUCTION
      ),
      iosAppearance: const MyIdIOSAppearance(),
    );

    return result;
  }
}
