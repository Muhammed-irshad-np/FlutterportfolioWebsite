import 'package:flutter/material.dart';

class TestimonialCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Client Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "NeuMachina",
                    ),
                  ),
                  Text(
                    "Position / Company",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "I've been working with them for several years now on countless projects and I can honestly say that they blow my mind every single time!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
} 