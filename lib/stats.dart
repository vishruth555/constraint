import 'package:constraint/state_management.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:constraint/dataModel.dart';
import 'utils.dart';

class Stats extends StatefulWidget {
  int groupId;
  Stats({super.key, required this.groupId});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    final dataMap = {
      'Red': 40.0,
      'Blue': 30.0,
      'Green': 20.0,
      'Yellow': 10.0,
    };
    final obj = context.read<Manager>();
    final members = obj.groups[widget.groupId].members;
    Map<String, double> budgetMap = {};
    members?.forEach((member) {
      budgetMap[member.name] = member.budget;
    });

    Map<String, double> expenditureMap = {};
    members?.forEach((member) {
      expenditureMap[member.name] = (member.totalBudget! - member.budget)!;
    });

    return Consumer<Manager>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: color1,
              appBar: AppBar(
                backgroundColor: color2,
                foregroundColor: basic1,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_outlined),
                ),
                title: Text('Stats for ${obj.groups[widget.groupId].name}'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Budget Analysis',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: PieChart(PieChartData(
                        sections: _generateSections(
                            budgetMap), // Define your data here
                        centerSpaceRadius: 80,
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 5,
                        pieTouchData: PieTouchData(enabled: true),
                      )),
                    ),
                    expenditureMap.isEmpty
                        ? Container()
                        : Text(
                            'Expenditure analysis',
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          ),
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: PieChart(PieChartData(
                        sections: _generateSections(
                            expenditureMap), // Define your data here
                        centerSpaceRadius: 80,
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 5,
                        pieTouchData: PieTouchData(enabled: true),
                      )),
                    ),
                  ],
                ),
              ),
            ));
  }
}

List<PieChartSectionData> _generateSections(Map<String, double> dataMap) {
  // Generate sections dynamically based on dataMap
  return dataMap.entries.map((entry) {
    final String title = entry.key;
    final double value = entry.value;
    final double fontSize = 16;

    return PieChartSectionData(
      color: randomColor(), // You can use a function to generate dynamic colors
      value: value,
      title: '$title', // Convert value to percentage if needed
      radius: 60,
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff),
      ),
    );
  }).toList();
}
