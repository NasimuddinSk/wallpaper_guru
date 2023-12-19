import 'package:flutter/material.dart';

class CatBlock extends StatelessWidget {
  const CatBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              height: 50,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black38,
            ),
          ),
          const Positioned(
            left: 30,
            top: 15,
            child: Text(
              "Cars",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
