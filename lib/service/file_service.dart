import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/service/storage.dart';
import 'package:share_plus/share_plus.dart';

class FileService {
  final Dio dio = Dio();

  Future<void> downloadAndShareFile(int? id, ) async {
    try {
      final url = "${Endpoints.baseUrl}/app/graph/$id";

       String? token = StorageService().read(StorageService.token);

      // 1️⃣ Faylni yuklab olish
      final response = await dio.get<ResponseBody>(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      // 2️⃣ Headerdan filename olish
      String filename = "downloaded_file";
      final contentDisposition = response.headers.value("content-disposition");
      if (contentDisposition != null) {
        final regExp = RegExp(r'filename="?([^"]+)"?');
        final match = regExp.firstMatch(contentDisposition);
        if (match != null) {
          filename = match.group(1)!;
        }
      }

      // 3️⃣ Temporary papkaga saqlash
      final dir = await getDownloadsDirectory();
      final filePath = "${dir?.path}/$filename";

      final file = File(filePath);
      final raf = file.openSync(mode: FileMode.write);
      if (kDebugMode) {
        print(file.path);
      }
     
      await response.data?.stream.listen(
        (chunk) {
          raf.writeFromSync(chunk);
        },
        onDone: () {
          raf.closeSync();
        },
        onError: (e) {
          throw Exception("Download error: $e");
        },
        cancelOnError: true,
      ).asFuture();

     
      await Share.shareXFiles([XFile(filePath)], text: "PremiumPay : $filename");

    } catch (e) {
      print("❌ DownloadAndShareFile: $e");
    }
  }
 Future<void> download(int? id, ) async {
    try {
      final url = "${Endpoints.baseUrl}/app/graph/$id";

       String? token = StorageService().read(StorageService.token);

      // 1️⃣ Faylni yuklab olish
      final response = await dio.get<ResponseBody>(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      // 2️⃣ Headerdan filename olish
      String filename = "downloaded_file";
      final contentDisposition = response.headers.value("content-disposition");
      if (contentDisposition != null) {
        final regExp = RegExp(r'filename="?([^"]+)"?');
        final match = regExp.firstMatch(contentDisposition);
        if (match != null) {
          filename = match.group(1)!;
        }
      }

      // 3️⃣ Temporary papkaga saqlash
      final dir = await getDownloadsDirectory();
      final filePath = "${dir?.path}/$filename";

      final file = File(filePath);
      final raf = file.openSync(mode: FileMode.write);
      if (kDebugMode) {
        print(file.path);
      }
     
      await response.data?.stream.listen(
        (chunk) {
          raf.writeFromSync(chunk);
        },
        onDone: () {
          raf.closeSync();
        },
        onError: (e) {
          throw Exception("Download error: $e");
        },
        cancelOnError: true,
      ).asFuture();

    } catch (e) {
      print("❌ Downloading Error: $e");
    }
  }

}