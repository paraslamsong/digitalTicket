import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class GalleryPage extends StatelessWidget {
  List<String> images;
  int index;

  PageController _controller;
  GalleryPage({@required List<String> images, @required int index}) {
    this.images = images;
    this.index = index;
    _controller = PageController(initialPage: index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(this.images[index]),
              initialScale: PhotoViewComputedScale.contained * 1,
              minScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: PhotoViewHeroAttributes(
                  tag: images[index] + index.toString()),
            );
          },
          itemCount: images.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
          pageController: _controller,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          if (i == 0) if (_controller.page != 0)
            _controller.previousPage(
                duration: Duration(milliseconds: 100), curve: Curves.ease);
          if (i == 1) if (_controller.page != (images.length - 1))
            _controller.nextPage(
                duration: Duration(milliseconds: 100), curve: Curves.ease);
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back_ios_new), label: "Previous"),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_forward_ios), label: "Next"),
        ],
      ),
    );
  }
}
