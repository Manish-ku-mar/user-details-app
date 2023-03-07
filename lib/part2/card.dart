import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  //we can also use them if need this card for something else
  var width;
  var height;
  MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: screenWidth/ 1.5,
            height: screenHeight / 2,
            decoration: BoxDecoration(color: Colors.grey[200],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Colors.grey.shade50,
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                  Colors.grey.shade200,
                ],
              ),),
          ),
          Container(
            width: screenWidth / 2.5,
            height: screenHeight / 3,
            decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.deepOrangeAccent.shade400,
                    Colors.deepOrangeAccent.shade200,
                    Colors.deepOrangeAccent.shade100,
                    Colors.deepOrangeAccent.shade100,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(80),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                )),
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0, left:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Breakfast",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15,),
                  const Text(
                    "Bread,",
                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Peanut butter,",
                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Apple",
                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        "525",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "kcal",
                        style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top:20,
            left: 40,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:Color.fromRGBO(255, 255, 255, 0.5),
              ),
              child: const Image(
                image: AssetImage('assets/egg-g99e422fee_1920.png'),
                fit: BoxFit.fill,
              ),

            ),
          )
        ],
      ),
    );
  }
}
