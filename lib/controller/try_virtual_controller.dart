import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
class CameraController extends GetxController {
  var selectedImage = Rx<File?>(null);
  var selectedImage2 = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  onInit()async{
    super.onInit();
    // var status = await Permission.storage.request();
    // if (!status.isGranted) {
    //   throw Exception('Storage permission is not granted');
    // }

  }
  Future<void> pickImageFromCamera(selectedImage) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage(File(image.path));
    }
  }
  Future<void> pickImageFromGallery(selectedImage) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage(File(image.path));
    }
  }

  Future<void> downloadImageToGallery(String url) async {
    try {
      // Fetch the image from the URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the temporary directory
        final directory = await getTemporaryDirectory();

        // Define the image's full path
        final filePath = path.join(directory.path, "image.png");

        // Create a file on the device
        final file = File(filePath);

        // Write the image data to the file
        await file.writeAsBytes(response.bodyBytes);

        // Save the image to the gallery
        final result = await ImageGallerySaver.saveFile(file.path);

        if (result['isSuccess']) {
          Get.snackbar(
            'Success',
            'Image saved to gallery successfully!',
            snackPosition: SnackPosition.TOP,
          );
        } else {
          throw Exception('Failed to save image to gallery');
        }
      } else {
        throw Exception('Failed to download image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}
