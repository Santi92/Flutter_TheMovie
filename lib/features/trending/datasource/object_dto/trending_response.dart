import 'dart:convert';

import 'package:test_themoviedb/features/trending/datasource/object_dto/results.dart';

TrendingResponse trendingResponseFromJson(String str) => 
TrendingResponse.fromJson(json.decode(str));


class TrendingResponse {
    TrendingResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    factory TrendingResponse.fromJson(Map<String, dynamic> json) => TrendingResponse(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}
