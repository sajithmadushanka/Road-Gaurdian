import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/routes.dart';
import 'package:road_gurdian/features/auth/view_model/auth_view_model.dart';
import 'package:road_gurdian/features/home/view_model/home_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthViewModel>(context);

    return Consumer<HomeViewModel>( builder: (context, viewModel, _) {
        final name = viewModel.userName ?? "Loading...";
        final email = viewModel.userEmail ?? "Loading...";
        final address = viewModel.userAddress ?? "Loading...";

        return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                  const Divider(height: 40, thickness: 1),

                  ProfileTile(icon: Icons.email, title: "Email", value: email),
                  ProfileTile(icon: Icons.person, title: "Name", value: name),
                  ProfileTile(icon: Icons.location_on, title: "Address", value: address),
                  
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      onPressed: () {
                        authModel.signOut();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logged out successfully!")),
                        );
                        // Navigate to login screen
                        Navigator.pushReplacementNamed(context, AppRoutes.signin);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  });
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
