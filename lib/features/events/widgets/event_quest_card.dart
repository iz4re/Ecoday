import 'package:flutter/material.dart';

enum QuestStatus {
  notStarted,
  pending,    // Waiting for approval
  approved,   // Approved by admin/system
  rejected,   // Rejected, need to redo
}

class EventQuestCard extends StatefulWidget {
  const EventQuestCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.xp,
    required this.tag,
    required this.category,
    required this.tagColor,
    this.hasUpload = false,
    this.requiresValidation = true,
    this.initialStatus = QuestStatus.notStarted,
    this.onCompleted,
    this.onSubmitForReview,
  });

  final String icon;
  final String title;
  final String description;
  final int xp;
  final String tag;
  final String category;
  final Color tagColor;
  final bool hasUpload;
  final bool requiresValidation;
  final QuestStatus initialStatus;
  final Function(int xp)? onCompleted;
  final Function(String questTitle)? onSubmitForReview;

  @override
  State<EventQuestCard> createState() => _EventQuestCardState();
}

class _EventQuestCardState extends State<EventQuestCard> {
  late QuestStatus _status;
  String? _rejectReason;
  String? _uploadedPhotoPath;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => _QuestCompletionDialog(
        title: widget.title,
        description: widget.description,
        xpReward: widget.xp,
        hasUpload: widget.hasUpload,
        requiresValidation: widget.requiresValidation,
        onConfirm: (photoPath) {
          setState(() {
            _uploadedPhotoPath = photoPath;
            if (widget.requiresValidation) {
              // Submit for review
              _status = QuestStatus.pending;
              widget.onSubmitForReview?.call(widget.title);
            } else {
              // Auto-approve
              _status = QuestStatus.approved;
              widget.onCompleted?.call(widget.xp);
            }
          });

          // Show appropriate message
          _showStatusMessage();

          // Simulate admin approval after 3 seconds (for demo)
          if (widget.requiresValidation) {
            _simulateAdminReview();
          }
        },
      ),
    );
  }

  void _simulateAdminReview() {
    // Simulate admin review - in real app, this comes from backend
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // Random approval/rejection for demo (90% approval rate)
        final isApproved = DateTime.now().second % 10 != 0;
        
        setState(() {
          if (isApproved) {
            _status = QuestStatus.approved;
            widget.onCompleted?.call(widget.xp);
            _showApprovedMessage();
          } else {
            _status = QuestStatus.rejected;
            _rejectReason = 'Foto kurang jelas. Silakan upload foto yang lebih baik.';
            _showRejectedMessage();
          }
        });
      }
    });
  }

  void _showStatusMessage() {
    String message;
    Color bgColor;
    IconData icon;

    switch (_status) {
      case QuestStatus.pending:
        message = 'Quest sedang direview admin 🔍';
        bgColor = const Color(0xFFFF9500);
        icon = Icons.pending;
        break;
      case QuestStatus.approved:
        message = 'Quest selesai! +${widget.xp} XP 🎉';
        bgColor = const Color(0xFF0ABF8A);
        icon = Icons.check_circle;
        break;
      case QuestStatus.rejected:
        message = 'Quest ditolak. Coba lagi!';
        bgColor = const Color(0xFFFF6B6B);
        icon = Icons.cancel;
        break;
      default:
        return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showApprovedMessage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SuccessDialog(
        xpReward: widget.xp,
        onClaim: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showRejectedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFFF6B6B),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '❌ Quest ditolak: ${_rejectReason ?? "Tidak memenuhi kriteria"}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Coba Lagi',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _status = QuestStatus.notStarted;
              _uploadedPhotoPath = null;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = _status == QuestStatus.approved;
    final isPending = _status == QuestStatus.pending;
    final isRejected = _status == QuestStatus.rejected;

    return Opacity(
      opacity: isCompleted ? 0.7 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: _getBorder(),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon with status badge
                Stack(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FAF6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          widget.icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    if (isCompleted)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0ABF8A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    if (isPending)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF9500),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.pending,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    if (isRejected)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B6B),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1F2E2B),
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                          if (isCompleted)
                            _buildStatusBadge('✓ Disetujui', const Color(0xFF0ABF8A)),
                          if (isPending)
                            _buildStatusBadge('⏳ Review', const Color(0xFFFF9500)),
                          if (isRejected)
                            _buildStatusBadge('✗ Ditolak', const Color(0xFFFF6B6B)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7A7B),
                        ),
                      ),
                      if (isRejected && _rejectReason != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B6B).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFF6B6B).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Color(0xFFFF6B6B),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _rejectReason!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFFF6B6B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Text(
                                '⭐',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+${widget.xp} XP',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F2E2B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: widget.tagColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _getTagIcon(widget.tag),
                                  size: 12,
                                  color: widget.tagColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.tag,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: widget.tagColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4A574).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4A574),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.category,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF6B7A7B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Border? _getBorder() {
    switch (_status) {
      case QuestStatus.approved:
        return Border.all(color: const Color(0xFF0ABF8A), width: 2);
      case QuestStatus.pending:
        return Border.all(color: const Color(0xFFFF9500), width: 2);
      case QuestStatus.rejected:
        return Border.all(color: const Color(0xFFFF6B6B), width: 2);
      default:
        return null;
    }
  }

  Widget _buildActionButton() {
    final isCompleted = _status == QuestStatus.approved;
    final isPending = _status == QuestStatus.pending;
    final isRejected = _status == QuestStatus.rejected;

    IconData icon;
    String text;
    Color bgColor;
    Color textColor;
    bool isEnabled;

    if (isCompleted) {
      icon = Icons.verified;
      text = 'Quest Disetujui';
      bgColor = const Color(0xFFE0E0E0);
      textColor = const Color(0xFF0ABF8A);
      isEnabled = false;
    } else if (isPending) {
      icon = Icons.pending;
      text = 'Menunggu Persetujuan...';
      bgColor = const Color(0xFFE0E0E0);
      textColor = const Color(0xFFFF9500);
      isEnabled = false;
    } else if (isRejected) {
      icon = Icons.refresh;
      text = 'Kerjakan Ulang';
      bgColor = const Color(0xFFFF6B6B);
      textColor = Colors.white;
      isEnabled = true;
    } else {
      icon = widget.hasUpload ? Icons.upload : Icons.check;
      text = widget.hasUpload ? 'Upload & Submit' : 'Kerjakan Quest';
      bgColor = const Color(0xFF9C27B0);
      textColor = Colors.white;
      isEnabled = true;
    }

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: isEnabled ? _showCompletionDialog : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: const Color(0xFFE0E0E0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTagIcon(String tag) {
    switch (tag.toLowerCase()) {
      case 'harian':
        return Icons.wb_sunny;
      case 'mingguan':
        return Icons.calendar_today;
      case 'foto':
        return Icons.camera_alt;
      default:
        return Icons.circle;
    }
  }
}

// Quest Completion Dialog with Validation
class _QuestCompletionDialog extends StatefulWidget {
  const _QuestCompletionDialog({
    required this.title,
    required this.description,
    required this.xpReward,
    required this.hasUpload,
    required this.requiresValidation,
    required this.onConfirm,
  });

  final String title;
  final String description;
  final int xpReward;
  final bool hasUpload;
  final bool requiresValidation;
  final Function(String? photoPath) onConfirm;

  @override
  State<_QuestCompletionDialog> createState() => _QuestCompletionDialogState();
}

class _QuestCompletionDialogState extends State<_QuestCompletionDialog> {
  bool _photoUploaded = false;
  String? _photoPath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.requiresValidation
                  ? 'Submit Quest untuk Review?'
                  : 'Selesaikan Quest?',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2E2B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7A7B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '⭐',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+${widget.xpReward} XP',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF9500),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.requiresValidation) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: Color(0xFF1976D2), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Quest akan direview oleh admin sebelum XP diterima',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.hasUpload) ...[
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  // TODO: Implement image picker
                  setState(() {
                    _photoUploaded = !_photoUploaded;
                    _photoPath = _photoUploaded ? 'quest_photo_${DateTime.now().millisecondsSinceEpoch}.jpg' : null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _photoUploaded
                        ? const Color(0xFF9C27B0).withValues(alpha: 0.1)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _photoUploaded
                          ? const Color(0xFF9C27B0)
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _photoUploaded ? Icons.check_circle : Icons.camera_alt,
                        color: _photoUploaded
                            ? const Color(0xFF9C27B0)
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _photoUploaded ? 'Foto Terupload ✓' : 'Upload Foto Bukti',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _photoUploaded
                              ? const Color(0xFF9C27B0)
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF9C27B0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        color: Color(0xFF9C27B0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (widget.hasUpload && !_photoUploaded)
                        ? null
                        : () {
                            Navigator.pop(context);
                            widget.onConfirm(_photoPath);
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF9C27B0),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.requiresValidation ? 'Submit' : 'Konfirmasi',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessDialog extends StatefulWidget {
  const _SuccessDialog({
    required this.xpReward,
    required this.onClaim,
  });

  final int xpReward;
  final VoidCallback onClaim;

  @override
  State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Trophy Icon with Glow
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD54F), Color(0xFFFFA000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFA000).withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '🏆',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Title
              const Text(
                'Quest Complete!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
              const SizedBox(height: 8),
              
              // XP Reward
              Text(
                '+${widget.xpReward} XP',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0ABF8A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kamu hebat! Teruslah berkontribusi untuk bumi.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7A7B),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              
              // Claim Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onClaim,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0ABF8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Selesai',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
