import 'package:premium_pay_seller/export_files.dart';

class MyIdService {
  FutureOr<MyIdResult?> scan(
      {required String passport, required String birthdate}) async {
   
 





  try {
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
  } catch (e) {
    print(e); 
  }
  }
}
