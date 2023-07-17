import 'package:image_picker/image_picker.dart';
class function{
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

   selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    return imageFileList;
    // print("Image List Length:" + imageFileList![0].path);
  }
}