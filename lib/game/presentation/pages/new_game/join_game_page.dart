import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/strok_text.dart';
import '../../../../core/widgets/trapezed_painter.dart';

class JoinGamePage extends StatelessWidget {
  const JoinGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: Center(
        child: CustomPaint(
          painter: TrapezedPainter(color: Colors.amber),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: CustomPaint(
              painter: TrapezedPainter(color: Colors.amber.shade200),
              child: IntrinsicHeight(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * .7,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/person.svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.red, BlendMode.srcIn),
                        semanticsLabel: 'Red dash paths',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const StrokeText(
                        text: 'Entrer votre code d\'invitation',
                        strokeColor: Colors.black,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "CarterOne",
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CustomTextField(
                        decoration: InputDecoration(
                          hintText: 'Code de la partie',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 105,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const StrokeText(text: 'Valider'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
