import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ApplicationsScreen extends StatelessWidget {
  List<BarChartGroupData> _createSampleData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [BarChartRodData(toY: 10, color: Colors.blue)],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [BarChartRodData(toY: 14, color: Colors.blue)],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [BarChartRodData(toY: 12, color: Colors.blue)],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [BarChartRodData(toY: 8, color: Colors.blue)],
      ),
    ];
  }

  final List<Map<String, dynamic>> appData = [
    {
      'name': 'Clickup',
      'time': '1:15 hrs/day',
      'icon': Icons.cloud_upload_outlined, // Placeholder icon
      'color': Colors.purple[100],
      'iconColor': Colors.purple,
      'isExpanded': false,
    },
    {
      'name': 'Whatsapp',
      'time': '1:08 hrs/day',
      'icon': Icons.message_outlined, // Placeholder icon
      'color': Colors.green[100],
      'iconColor': Colors.green,
      'isExpanded': false,
    },
    {
      'name': 'Instagram',
      'time': '52 mins/day',
      'icon': Icons.camera_alt_outlined, // Placeholder icon
      'color': Colors.pink[100],
      'iconColor': Colors.pink,
      'isExpanded': false,
    },
    {
      'name': 'Dribbble',
      'time': '32 mins/day',
      'icon': Icons.sports_basketball_outlined, // Placeholder icon
      'color': Colors.orange[100],
      'iconColor': Colors.orange,
      'isExpanded': true, // Example for expanded view
      'focusImpact': 'Moderate focus impact',
      'lastActive': 'Last active 34 mins ago',
      'todayUsage': '42 minutes today',
      'pickups': '5 pickups',
      'avgSession': '4 min 14 sec',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Applications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black, size: 28),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15.0),
        itemCount: appData.length,
        itemBuilder: (context, index) {
          final app = appData[index];
          return Card(
            margin: EdgeInsets.only(bottom: 15),
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: app['color'] ?? Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            app['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            app['time'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          app['icon'],
                          color: app['iconColor'] ?? Colors.black,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  if (app['isExpanded'] == true) ...[
                    SizedBox(height: 15),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            app['focusImpact'],
                            style: TextStyle(fontSize: 12),
                          ),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        Text(
                          app['lastActive'],
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    // Placeholder for Bar Chart
                    SizedBox(
                      height: 80,
                      child: BarChart(
                        BarChartData(
                          barGroups: _createSampleData(),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(show: false),
                          gridData: FlGridData(show: false),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildUsageStat(app['todayUsage'], ''),
                        _buildUsageStat(app['pickups'], ''),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '7:45',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ), // Placeholder for specific times
                        Text(
                          app['avgSession'],
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUsageStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (label.isNotEmpty)
          Text(label, style: TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}
