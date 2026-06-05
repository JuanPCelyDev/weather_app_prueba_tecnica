import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String temperature;

  final String rangetemp;
  final String timeInfo;
  final Icon icon;
  final VoidCallback? onTap;

  const WeatherInfoCard({
    super.key,
    required this.title,
    required this.temperature,
    required this.rangetemp,
    required this.timeInfo,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.lightBlueAccent.withValues(alpha: 0.7),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: icon,
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          temperature,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900, // Resalte máximo
                            color: Colors.black,       // Negro puro
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(rangetemp,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight:  FontWeight.normal,
                          color: Colors.black
                        ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                        Jiffy.now().format(pattern: 'EEEE, HH:mm'),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:  FontWeight.normal,
                          color: Colors.black
                      ),
                    )

                  ],
                ),
              ),


              // 3. Texto a la derecha (Temperatura resaltada en negro)
            ],
          ),
        ),
      ),
    );
  }
}