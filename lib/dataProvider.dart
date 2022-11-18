import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider extends ChangeNotifier {
  var data = {};
  addPicture(XFile file, percentage) {
    data[percentage] = file.path;
    print(data.toString());
  }
}
