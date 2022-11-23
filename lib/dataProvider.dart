import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider extends ChangeNotifier {
  var data = {};
  Map moistures = {};
  var soilType = '';

  getMoisture(key, val) {
    moistures[key] = val;
    print(moistures);
  }

  upload(String file) async {
    String fileName = file.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file,
        filename: fileName,
      ),
    });

    Dio dio = Dio();
    var response = await dio.post(
        "https://technocratss.eastus.cloudapp.azure.com/predict",
        data: data,
        queryParameters: {'soil_type': "black"});
    return response;
  }

  addPicture(XFile file, percentage) {
    data[percentage] = file.path;
    if (kDebugMode) {
      print(data.toString());
    }
  }

  calculateAverage() {
    List a = [];
    moistures.forEach((key, value) => a.add(value));
    print(a);
    var sum = a.reduce((a, b) => a + b);
    print(sum);
    return sum / a.length;
  }
}
