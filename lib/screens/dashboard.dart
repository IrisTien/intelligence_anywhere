import 'package:flutter/material.dart';
import 'package:intelligence_anywhere/data/chart_data.dart';
import 'package:intelligence_anywhere/data/http_helper.dart';
import 'package:intelligence_anywhere/data/trend_result.dart';
import 'package:intelligence_anywhere/shared/simple_bar_chart.dart';
import '../shared/menu_drawer.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  SimpleBarChart sessionChart = SimpleBarChart.withSampleData();
  @override
  void initState() {
    HttpHelper helper = HttpHelper();
    // helper.getDashboardData().then((trendData) {
    //   List<TrendResult> sessionDataByPoolType = trendData.trend_results;
    //   // List<ChartData> chartData = [];
    //   List<ChartData> chartData =
    //       sessionDataByPoolType.map<ChartData>((sessionDataItem) {
    //     return ChartData(sessionDataItem.bucketing_attributes[0]['value'],
    //         sessionDataItem.counters[0]['result']['value']);
    //   }).toList();
    //   // for (final TrendResult item in sessionDataByPoolType) {
    //   //   chartData.add(ChartData(item.bucketing_attributes[0]['value'],
    //   //       item.counters[0]['result']['value']));
    //   // }
    //   print(chartData);
    //   // List<ChartData> chartData = (sessionDataByPoolType.map((item) {
    //   //   print(item);
    //   //   return item.convertToChartData();
    //   // })).cast<ChartData>().toList();
    //   createSimpleBarChart(chartData);
    // });
    helper.getSessionData().then((dynamic trendData) {
      List<ChartData> data = [];
      trendData['trend_results'].forEach((sessionDataItem) {
        data.add(ChartData(sessionDataItem['bucketing_attributes'][0]['value'],
            sessionDataItem['counters'][0]['result']['value']));
      });
      print(data);
      setState(() {
        sessionChart = createSimpleBarChart(data);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
          child: Container(
        height: 200,
        child: sessionChart,
      )),
    );
  }

  List<charts.Series<ChartData, String>> _createData(List<ChartData> data) {
    return [
      new charts.Series<ChartData, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartData data, _) => data.series,
        measureFn: (ChartData data, _) => data.value,
        data: data,
      )
    ];
  }

  createSimpleBarChart(List<ChartData> data) {
    return new SimpleBarChart(
      _createData(data),
      // Disable animations for image tests.
      animate: true,
    );
  }
}
