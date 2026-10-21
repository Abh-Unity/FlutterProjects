import 'package:flutter/foundation.dart';

class FetchedData {
  final totalresult;
  final description;
  final citations;
  final type;
  final title;
  final publication;

  FetchedData({
    this.totalresult,
    this.description,
    this.citations,
    this.type,
    this.title,
    this.publication,
  });

  factory FetchedData.fromJson(Map<String, dynamic> json) {
    return FetchedData(
      totalresult: json["meta"]["count"],
      description: json["results"]["title"],
      citations: json["results"]["cited_by_count"],
      title: json["results"]["concepts"]["display_name"],
    );
  }
}
