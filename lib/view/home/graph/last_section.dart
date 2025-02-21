import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  final int steps;
  final int goalSteps;
  final double water;
  final String calories;
  final int pulse;
  final double weight;

  const DashboardWidget({
    super.key,
    required this.steps,
    required this.goalSteps,
    required this.water,
    required this.calories,
    required this.pulse,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepsWidget(),
              _buildActionsWidget(),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWaterWidget(),
              _buildCaloriesWidget(),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPulseWidget(),
              _buildWeightWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$steps Steps',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Out of $goalSteps',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsWidget() {
    return Row(
      children: [
        _buildCircleIcon(Icons.download),
        const SizedBox(width: 8.0),
        _buildCircleIcon(Icons.more_horiz),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple.withOpacity(0.1),
      ),
      child: Icon(
        icon,
        color: Colors.purple,
        size: 20.0,
      ),
    );
  }

  Widget _buildWaterWidget() {
    return _buildStatCard(
        'Water', '${water.toStringAsFixed(1)} Liters', Icons.water_drop);
  }

  Widget _buildCaloriesWidget() {
    return _buildStatCard('Calories', calories, Icons.local_fire_department);
  }

  Widget _buildPulseWidget() {
    return _buildStatCard('Pulse', '$pulse BPM', Icons.favorite);
  }

  Widget _buildWeightWidget() {
    return _buildStatCard(
        'Weight', '${weight.toStringAsFixed(1)} KG', Icons.monitor_weight);
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.purple,
              size: 28.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
