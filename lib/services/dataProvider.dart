import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider extends ChangeNotifier {
  var data = {};
  Map moistures = {};
  var soilType = 'Red Soil';
  Map coordinates = {" lat": '', "long": ""};
  int selectedIndex = -1;

  setIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }

  setSoilType(v) {
    soilType = v;
    notifyListeners();
  }

  setCoordinate(lat, long) {
    coordinates["lat"] = lat;
    coordinates['long'] = long;
    notifyListeners();
  }

  getMoisture(key, val) {
    moistures[key] = val;
  }

  upload(String file) async {
    if (kDebugMode) {
      print(file);
    }
    String fileName = file.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file,
        filename: fileName,
      ),
    });

    Dio dio = Dio();
    var response = await dio.post("http://20.204.143.35:5000/predict",
        data: data,
        queryParameters: {'soil_type': soilType.split(' ')[0].toLowerCase()});

    if (kDebugMode) {
      print(response);
    }
    return response;
  }

  uploadDisease(String file, plantType) async {
    if (kDebugMode) {
      print(file);
    }
    String fileName = file.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file,
        filename: fileName,
      ),
    });

    Dio dio = Dio();
    var response = await dio.post("http://20.204.143.35:5000/predictPlantDisease",
        data: data, queryParameters: {'plant_type': plantType});

    if (kDebugMode) {
      print(response);
    }
    return response.data;
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
