import '../data/chart_data.dart';

import '../shared/simple_bar_chart.dart';

class TrendData {
  dynamic trend_definition;
  List<TrendResult> trend_results = [];
  TrendData(this.trend_definition, this.trend_results);

  TrendData.fromJson(Map<String, dynamic> item) {
    this.trend_definition = item['trend_definition'] ?? {};
    this.trend_results = (item['trend_results']).cast<TrendResult>() ?? [];
  }
}

class TrendResult {
  int start_millis = 0;
  int end_millis = 0;
  String date_attribute_name = '';
  List<Map<String, dynamic>> bucketing_attributes = [];
  List<Map<String, dynamic>> counters = [];

  TrendResult(this.bucketing_attributes, this.counters, this.start_millis,
      this.end_millis, this.date_attribute_name);

  TrendResult.fromJson(Map<String, dynamic> item) {
    this.bucketing_attributes = item['bucketing_attributes'] ?? [];
    this.counters = item['counters'] ?? [];
    this.start_millis = item['start_millis'] ?? 0;
    this.end_millis = item['end_millis'] ?? 0;
    this.date_attribute_name = item['date_attribute_name'] ?? '';
  }

  convertToChartData() {
    return ChartData(this.bucketing_attributes[0]['value'],
        this.counters[0]['result']['value']);
  }
}
