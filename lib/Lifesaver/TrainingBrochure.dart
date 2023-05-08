import 'dart:async';
import 'package:google_maps/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar("PLSP Brochure"),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  heroTag: '-',
                  child: const Icon(Icons.chevron_left_rounded),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  heroTag: '+',
                  child: const Icon(Icons.chevron_right_rounded),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

// class PdfViewerScreen extends StatefulWidget {
//   final String url;

//   const PdfViewerScreen({required this.url});

//   @override
//   _PdfViewerScreenState createState() => _PdfViewerScreenState();
// }

// class _PdfViewerScreenState extends State<PdfViewerScreen> {
//   late Future<Uint8List> _pdfFuture;

//   @override
//   void initState() {
//     super.initState();
//     _pdfFuture = loadPdf(widget.url);
//   }

//   Future<Uint8List> loadPdf(String url) async {
//     final cache = await PdfCache.fromUrl(url);
//     final file = await cache.getFile();
//     return file.readAsBytesSync();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: FutureBuilder<Uint8List>(
//         future: _pdfFuture,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return PDF(
//               document: PdfDocument.openData(snapshot.data!),
//               onPageError: (page, error) {
//                 print('$page: ${error.toString()}');
//               },
//               onViewCreated: (PDFViewController controller) {
//                 controller.setPage(0);
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('${snapshot.error}'),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }