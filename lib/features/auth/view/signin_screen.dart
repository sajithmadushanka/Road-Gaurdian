import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_gurdian/app/routes.dart';
import 'package:road_gurdian/shared/widget/auth_btn.dart';
import 'package:road_gurdian/shared/widget/auth_text_filed.dart';
import 'package:road_gurdian/shared/widget/header_text.dart';
import '../view_model/auth_view_model.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void _onLogin(AuthViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      viewModel.signIn(
        email: emailController.text,
        password: passwordController.text,
        onSuccess: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login successful!")));
     Navigator.pushReplacementNamed(context, AppRoutes.main);

        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeaderText(title: "WELCOME BACK"),
              const SizedBox(height: 32),

              /// Email----------------------------------------------------------
              AuthTextField(
                controller: emailController,
                label: "Email",
                prefixIcon: Icons.email,
                validator: (val) {
                  if (val!.isEmpty) return "Email required";
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val))
                    return "Enter valid email";
                  return null;
                },
              ),
              const SizedBox(height: 16),

              /// Password----------------------------------------------------------
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
                validator: (val) => val!.isEmpty ? "Password required" : null,
              ),
              const SizedBox(height: 24),

              /// Login Button--------------------------------------------
              authVM.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                    width: double.infinity,
                    child: AuthBtn(
                      btnName: "Login",
                      onPressed: () => _onLogin(authVM),
                    ),
                  ),

              /// Error
              if (authVM.error != null) ...[
                const SizedBox(height: 12),
                Text(authVM.error!, style: const TextStyle(color: Colors.red)),
              ],

              /// Signup Redirect
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
                child: const Text("Don't have an account? Sign up"),
              ),

              // admin redirect
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.adminDashboard);
                },
                child: const Text("Admin Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
