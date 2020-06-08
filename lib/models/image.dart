class ImageClass {
  String name, url;
  ImageClass({this.name, this.url});
}

class ImageModel {
  List<ImageClass> images;
  ImageModel();
  List<ImageClass> getAllImages(Map<String, dynamic> data) {
    images = List<ImageClass>();

    data.forEach((name, url) {
      ImageClass image = ImageClass(name: name, url: url);
      this.images.add(image);
    });
    return this.images;
  }

  List<ImageClass> searchImages(String name) {
    List<ImageClass> imagesFound = List<ImageClass>();
    for (var image in this.images) {
      if (image.name == name) {
        imagesFound.add(image);
      }
    }
    return imagesFound;
  }
}
