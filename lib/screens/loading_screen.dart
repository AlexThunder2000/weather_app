import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as Rive;
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utilities/animation_source.dart';
import 'package:weather_app/utilities/text_style_source.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              Colors.lightBlue.shade900,
              Colors.lightBlue.shade600,
              Colors.lightBlue.shade400,
              Colors.white70,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            const Expanded(
              child: Rive.RiveAnimation.asset(AnimationSource.loadingRive),
            ),
            Text(
              "Welcome to WeatherApp",
              style: TextStyleSource.inter32.copyWith(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Let\'s start',
                style: TextStyleSource.inter16,
              ),
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'created by Bihnyak Oleksandr',
                  style:
                      TextStyleSource.inter14.copyWith(color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
