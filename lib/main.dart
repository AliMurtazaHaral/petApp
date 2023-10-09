// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp/screens/registration_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51LfUARDwLhA5VoPRkSD2obwEXXsBH6qht4jukSTQMHQDsijrGktCbqawl9UjJPLLapGOcyQrw34kBkmfP9S6fOlm00H3rvSlUO";
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
       home:
       RegistrationScreen()

    );
  }
}
