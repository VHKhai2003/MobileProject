import 'package:flutter/material.dart';

class Commitment extends StatelessWidget {
  const Commitment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          """* Our subscription plan is designed with flexibility and transparency in mind. While it offers unlimited usage, we acknowledge the possibility of adjustments in the future to meet evolving needs. Rest assured, any such changes will be communicated well in advance, providing our customers with the information they need to make informed decisions. Additionally, we understand that adjustments may not align with everyone's expectations, which is why we've implemented a generous refund program. Subscribers can terminate their subscription within 7 days of the announced adjustments and receive a refund if they so choose. Moreover, our commitment to customer satisfaction is further emphasized by allowing subscribers the freedom to cancel their subscription at any time, providing ultimate flexibility in managing their subscription preferences.""",
          style: TextStyle(
            color: Colors.grey
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 20),
        Text(
          """* By subscribing, you are enrolling in automatic payments. Cancel or manage your subscription through Stripe's customer portal from "Dashboard".""",
          style: TextStyle(
              color: Colors.grey
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 20),
        Text(
          """* All services are delivered according to the Terms of Service you confirm with your sign-up.""",
          style: TextStyle(
              color: Colors.grey
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
