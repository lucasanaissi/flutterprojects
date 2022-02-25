import 'package:flutter/material.dart';

class HomeTop extends StatelessWidget {

  final Animation<double> containerGrow;

  const HomeTop({required this.containerGrow, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/background.jpg',
          ),
            fit: BoxFit.cover
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Bem-vindo, Lucas!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              width: containerGrow.value * 120,
              height: containerGrow.value * 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/profile.jpg'
                  ),
                  fit: BoxFit.cover,
                )
              ),
              child: Container(
                width: containerGrow.value * 35,
                height: containerGrow.value * 35,
                margin: const EdgeInsets.only(left: 80),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(247, 64, 106, 1.0),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontSize: containerGrow.value * 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
