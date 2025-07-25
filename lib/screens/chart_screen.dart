import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/transaction_service.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        title: const Text('Gráficos'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Map<DateTime, Map<String, double>>>(
          future: TransactionService.getGroupedDataByDate(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;
            final fechas = data.keys.toList()..sort();
            final ingresos = fechas.map((f) => data[f]!['ingresos'] ?? 0.0).toList();
            final gastos = fechas.map((f) => data[f]!['gastos'] ?? 0.0).toList();

            final ingresosSpots = List.generate(fechas.length, (index) => FlSpot(index.toDouble(), ingresos[index]));
            final gastosSpots = List.generate(fechas.length, (index) => FlSpot(index.toDouble(), gastos[index]));

            final maxY = (ingresos + gastos).fold(0.0, (prev, next) => next > prev ? next : prev) + 50;

            return Column(
              children: [
                const Text('Resumen de Ingresos y Gastos por Fecha',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      maxY: maxY,
                      minY: 0,
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 && index < fechas.length) {
                                final date = fechas[index];
                                return Text('${date.day}/${date.month}', style: const TextStyle(fontSize: 10));
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(value.toInt().toString(),
                                  style: const TextStyle(fontSize: 12, color: Colors.black));
                            },
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: ingresosSpots,
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                        ),
                        LineChartBarData(
                          spots: gastosSpots,
                          isCurved: true,
                          color: Colors.red,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}