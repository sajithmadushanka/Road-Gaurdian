import 'package:flutter/material.dart';

Future<bool> showSubmissionDialog(
  BuildContext context,
  Future<bool> Function() submitAction,
) async {
  bool isSuccess = false;
  bool isLoading = true;

  // We use ValueNotifier to avoid setState problems inside dialog
  final loadingNotifier = ValueNotifier<bool>(true);

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      // Start the DB operation when the dialog is shown
      Future.microtask(() async {
        final result = await submitAction();
        isSuccess = result;
        loadingNotifier.value = false;

        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) Navigator.of(context).pop();
      });

      return AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: ValueListenableBuilder<bool>(
          valueListenable: loadingNotifier,
          builder: (context, isLoading, _) {
            return SizedBox(
              width: 200,
              height: 140,
              child: Center(
                child: isLoading
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            "Submitting...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSuccess ? Icons.check_circle : Icons.cancel,
                            size: 48,
                            color: isSuccess ? Colors.green : Colors.red,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isSuccess
                                ? "Report submitted!"
                                : "Submission failed.",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      );
    },
  );

  return isSuccess;
}
