import 'package:flutter/material.dart';

import 'main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      print("session is null");
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      final userID = supabase.auth.currentUser!.id;
      final checkAdmin =
          await supabase.from('admin').select().eq('user_id', userID);
      final checkRider =
          await supabase.from('rider').select().eq('user_id', userID);
      final checkCustomer =
          await supabase.from('user').select().eq('user_id', userID);

      if (checkAdmin.isNotEmpty) {
        print('User is an admin');
        Navigator.of(context).pushReplacementNamed('/admin_home');
      } else if (checkRider.isNotEmpty) {
        print('User is a rider');
        Navigator.of(context).pushReplacementNamed('/rider_home');
      } else if (checkCustomer.isNotEmpty) {
        print('User is a customer');
        Navigator.of(context).pushReplacementNamed('/customer_home');
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
