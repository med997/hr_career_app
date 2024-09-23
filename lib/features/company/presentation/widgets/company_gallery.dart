import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/documents_widget.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../domain/entities/company.dart';

CompanyGallery(Company company) {
  List<String> images = company.imagesPath.isNotEmpty
      ? List<String>.from(company.imagesPath)
      : [];
  final List<Document> documents = company.documentPaths.isNotEmpty
      ? List<Document>.from(
      company.documentPaths.map((path) =>
          Document(
            fileName: path
                .split('/')
                .last,
            size: '1.2 MB',
          ))
  )
      : [];
  return Column(
    children: [
      SubTitle(
        title: 'Images',
        titleType: SubTitleType.withShowMore,
      ),
      SizedBox(
        height: 140,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 15),
          scrollDirection: Axis.horizontal,
          itemCount: images.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: primaryTransparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.white,
                      shape: const CircleBorder(
                          side: BorderSide(color: Colors.white)),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: primaryColor,
                      ),
                    )),
              );
            } else {
              return Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        images[index - 1],
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 15,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      SubTitle(
        title: 'Videos',
        titleType: SubTitleType.withShowMore,
      ),
      SizedBox(
        height: 140,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 15),
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              margin:
              const EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      images[index],
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 15,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      SubTitle(
        title: tr("documents_msg"),
        titleType: SubTitleType.withShowMore,
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final document = documents[index];
          return Document(size: document.size, fileName:document.fileName);
        },
      ),
    ],
  );
}