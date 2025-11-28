import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoucherCard extends StatefulWidget {
  const VoucherCard({
    super.key,
    required this.title,
    required this.description,
    required this.expiryDate,
    this.voucherCode,
  });

  final String title;
  final String description;
  final String expiryDate;
  final String? voucherCode;

  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  bool _isClaimed = false;
  late String _generatedCode;

  @override
  void initState() {
    super.initState();
    _generatedCode = widget.voucherCode ?? _generateVoucherCode();
  }

  String _generateVoucherCode() {
    // Generate simple voucher code based on title
    final prefix = widget.title
        .toUpperCase()
        .replaceAll(' ', '')
        .replaceAll('%', '')
        .substring(0, widget.title.length > 6 ? 6 : widget.title.length);
    return 'ECO${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}$prefix';
  }

  void _claimVoucher() {
    setState(() {
      _isClaimed = true;
    });
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Text('🎉', style: TextStyle(fontSize: 18)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Reward berhasil diklaim!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0B8F6E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _copyVoucherCode() {
    Clipboard.setData(ClipboardData(text: _generatedCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Kode voucher berhasil disalin!',
          style: TextStyle(fontSize: 13),
        ),
        backgroundColor: const Color(0xFF1F2E2B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isClaimed
              ? [const Color(0xFF0B8F6E), const Color(0xFF24C08E)]
              : [const Color(0xFFFF9500), const Color(0xFFFFB84D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (_isClaimed
                    ? const Color(0xFF0B8F6E)
                    : const Color(0xFFFF9500))
                .withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  SizedBox(width: 8),
                ],
              ),
              if (_isClaimed)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          if (_isClaimed)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kode Voucher:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _generatedCode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      InkWell(
                        onTap: _copyVoucherCode,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.copy,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            InkWell(
              onTap: _claimVoucher,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(width: 8),
                    Text(
                      'Claim Voucher',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
          Text(
            'Berlaku hingga: ${widget.expiryDate}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
