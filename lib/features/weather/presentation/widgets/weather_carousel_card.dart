 import 'package:flutter/material.dart';

class WeatherCarouselCard extends StatelessWidget {

  final String title;
  final String description;
  final String temperature;
  final IconData icon;

  final Color color;


  const WeatherCarouselCard({super.key,
    required this.title,
    required this.description,
    required this.temperature,
    required  this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
        child: Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: color,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
            size: 20,),
          ),
          const SizedBox(width: 10,),
          Text(
            '$temperature°C',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),

        ],
      ),
          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ]
      ),
      ),
    ),
    );
  }
}