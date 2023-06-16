import 'package:flutter/material.dart';


class RetryWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const RetryWidget({Key? key,required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Oops!,Something went wrong please try again!",style: TextStyle(fontSize: 16),),
          const SizedBox(height: 12,),
          TextButton(onPressed: onRetry, child: Text("Retry")),
        ],
      ),
    );
  }
}
