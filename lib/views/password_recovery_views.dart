import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/stellar_background.dart';
import 'sign_in_view.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return _RecoveryShell(
      title: 'Forgot Password',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Phone Number', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text('+55',
                  style: TextStyle(fontSize: 31, fontWeight: FontWeight.w700)),
              SizedBox(width: 14),
              Expanded(
                child: Text(
                  '11981234567',
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFFE3E3E3),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OtpView()),
              );
            },
            child: const Text('Generate OTP'),
          ),
          _CancelButton(onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class OtpView extends StatefulWidget {
  const OtpView({super.key, this.prefilled = false});

  final bool prefilled;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late bool _filled = widget.prefilled;

  @override
  Widget build(BuildContext context) {
    const digits = ['2', '1', '3', '4', '6'];
    return _RecoveryShell(
      title: 'Forgot Password',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter OTP', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              5,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _filled = true),
                  child: Container(
                    height: 52,
                    margin: EdgeInsets.only(right: index == 4 ? 0 : 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EAED),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      _filled ? digits[index] : '',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () => setState(() => _filled = false),
            child: const Text('Send Again',
                style: TextStyle(color: AppColors.coral)),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewPasswordView()),
              );
            },
            child: const Text('Verify'),
          ),
          _CancelButton(onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return _RecoveryShell(
      title: 'Forgot Password',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PasswordLine(label: 'Create New Password'),
          const SizedBox(height: 34),
          const _PasswordLine(label: 'Confirm New Password'),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SignInView()),
                (_) => false,
              );
            },
            child: const Text('Submit'),
          ),
          _CancelButton(onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class _RecoveryShell extends StatelessWidget {
  const _RecoveryShell({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final headerHeight = constraints.maxHeight * 0.5;
          return Column(
            children: [
              StellarBackground(
                height: headerHeight,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const StellarLogo(),
                      const SizedBox(height: 42),
                      Text(
                        title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 34),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(30, 36, 30, 26),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30)),
                  ),
                  child: child,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PasswordLine extends StatelessWidget {
  const _PasswordLine({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          '**********',
          style: TextStyle(
            color: Color(0xFFD2D2D2),
            fontSize: 20,
            letterSpacing: 3,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: const Text('Cancel', style: TextStyle(color: AppColors.coral)),
      ),
    );
  }
}
