import 'package:flutter/material.dart';

/// Boundary Class to display the UI for showing some basic recycling guidelines
class RecycleInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 40,
        ),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 60.00,
          width: double.infinity,
          child: Center(
            child: Text(
              'Lets Recycle',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/images/Wastetastic_Logo.png'),
              ),
              Text(
                "Point System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 39.0,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "The points allocated to you are displayed on the shield icon at the top right corner of the screen. Points are allocated when you login and depending on the type of waste you dispose. They are explained in detail below:",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                "1. If you dispose Normal Waste, points will be updated as (7* Weight of Waste) + Current points",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "2. If you dispose E-Waste, points will be updated as (3* Weight of Waste) + Current points",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "3. If you dispose Lightning Waste, points will be updated as (4* Weight of Waste) + Current points",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "4. If you opt for Waste Treatment, points will be updated as (6* Weight of Waste) + Current points",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "5. If you opt for Cash for Trash, points will be updated as (9* Weight of Waste) + Current points. ",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "We hope that the point system was easy to understand. Happy Recycling :)",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Types of Waste",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 39.0,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Normal Waste",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 29.0,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Normal waste can be generated from: Biodegradable products like food and kitchen waste, green waste, paper, cardboard, glass, bottles or jars. Composite wastes like clothing, tetra pack food, waste plastic from toys or furniture. Some of these are recyclable but materials like plastic must be treated properly. Regardless of being recyclable, they should be disposed of by proper waste management methods.",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "E-Waste",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 29.0,
                  color: Colors.teal.shade900,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "E-waste is generated from electrical devices, including computers and computer parts, printers, DVD and music players, TVs, telephones, vacuum cleaners and so on. These may contain toxic metals like lead, mercury, cadmium, and brominated flame retardants, which are all harmful to humans and the environment.",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Lightning Waste",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 29.0,
                  color: Colors.teal.shade900,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Lightning waste is generated from different types of bulbs/tubes contain chemicals and materials which maybe harmful to people or the environment and need to be properly disposed of.",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Waste Treatment",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 29.0,
                  color: Colors.teal.shade900,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Waste Treatment ensures that waste has the least least practicable impact on the environment. It broadly consists of 3 categories:-",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "1. Solid Waste Treatment: The treatment of solid wastes is a key component of waste management. Different forms of solid waste treatment are graded in the waste hierarchy.",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "2. Waste Water Treatment: It is further divided into 3 categories:",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "a. Agricultural Waste Water Treatment: Treatment and disposal of liquid animal waste, pesticide residues etc. from agriculture",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "b. Industrial Waste Water Treatment: Treatment of wet wastes from factories, mines, power plants and other commercial facilities.",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "c. Sewage Treatment:  Treatment and disposal of human waste.",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "3. Radioactive Waste Treatment: Treatment and containment of radioactive waste.",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Cash For Trash",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 29.0,
                  fontFamily: 'DancingScript',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "You may bring your RECYCLABLE waste to the Cash-for-Trash stations and depending on the weight of your trash, cash will be given in exchange for it .",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.grey,
            child: const Text(
              'Okay, got it!',
              style: TextStyle(
                fontSize: 16.0,
                //fontFamily: 'DancingScript',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
