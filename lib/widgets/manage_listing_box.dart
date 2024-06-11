import 'package:flutter/material.dart';

class ManageListingBox extends StatelessWidget {
  final String name;
  final Color colorone;
  final Color colortwo;
  final Color colorthree;
  const ManageListingBox({
    super.key,
    required this.name,
    required this.colorone,
    required this.colortwo,
    required this.colorthree,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: MediaQuery.of(context).size.width / 2 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.5, 1.0],
          colors: [
            colorone,
            colortwo,
            colorthree,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Add, Edit or Delete",
            style: TextStyle(
                //   color: Colors.green,
                //fontSize: 24,
                ),
          ),
        ],
      ),
    );
  }
}
