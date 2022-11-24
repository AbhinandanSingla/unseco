import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider extends ChangeNotifier {
  var data = {};
  Map moistures = {};
  var soilType = 'Red Soil';

  setSoilType(v) {
    soilType = v;
    notifyListeners();
  }

  getMoisture(key, val) {
    moistures[key] = val;
  }

  upload(String file) async {
    print(file);
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
        queryParameters: {'soil_type': soilType.split(' ')[0].toLowerCase()});

    print(response);
    return response;
  }

  addPicture(XFile file, percentage) {
    data[percentage] = file.path;
    if (kDebugMode) {
      print(data.toString());
    }
  }

  calculateAverage() {
    int sum = 0;
    moistures.forEach((key, value) {
      sum += int.parse(value.data['moisture']);
    });
    return sum / moistures.length;
  }
}
