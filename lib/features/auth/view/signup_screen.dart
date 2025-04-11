import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/routes.dart';
import 'package:road_gurdian/shared/widget/auth_btn.dart';
import 'package:road_gurdian/shared/widget/auth_text_filed.dart';
import 'package:road_gurdian/shared/widget/header_text.dart';
import '../view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void _onSubmit(AuthViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      viewModel.signUp(
        name: nameController.text,
        address: addressController.text,
        email: emailController.text,
        password: passwordController.text,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account created successfully!")),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.main);

        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header----------------------------
              HeaderText(title: "CREATE AN ACCOUNT"),
              const SizedBox(height: 24),

              /// Full Name
              /// ------------------------------------------------
              AuthTextField(
                controller: nameController,
                label: "Full Name",
                prefixIcon: Icons.person,
                validator:
                    (val) => val!.isEmpty ? "Full name is required" : null,
              ),
              const SizedBox(height: 16),

              /// Address----------------------------------------------------------
              AuthTextField(
                controller: addressController,
                label: "Address",
                prefixIcon: Icons.home,
                validator: (val) => val!.isEmpty ? "Address is required" : null,
              ),
              const SizedBox(height: 16),

              /// Email----------------------------------------------------------
              AuthTextField(
                controller: emailController,
                label: "Email",
                prefixIcon: Icons.email,
                validator: (val) {
                  if (val!.isEmpty) return "Email required";
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              /// Password----------------------------------------------------------
              /// ----------------------------------------------------------
              AuthTextField(
                controller: passwordController,
                label: "Password",
                prefixIcon: Icons.lock,
                obscureText: !isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed:
                      () => setState(
                        () => isPasswordVisible = !isPasswordVisible,
                      ),
                ),
                validator:
                    (val) =>
                        val!.length < 6
                            ? "Password must be at least 6 chars"
                            : null,
              ),
              const SizedBox(height: 24),

              /// Submit Button ------------------------------------------------
              authVM.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                    width: double.infinity,
                    child: AuthBtn(
                      btnName: "Sign Up",
                      onPressed: () => _onSubmit(authVM),
                    ),
                  ),

              /// Error Text
              if (authVM.error != null) ...[
                const SizedBox(height: 12),
                Text(authVM.error!, style: const TextStyle(color: Colors.red)),
              ],

              /// Login Redirect
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already have an account? Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
