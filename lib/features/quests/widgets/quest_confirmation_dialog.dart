import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class QuestConfirmationDialog extends StatefulWidget {
  const QuestConfirmationDialog({
    super.key,
    required this.questTitle,
    required this.questDescription,
    required this.questIcon,
    required this.iconColor,
    required this.xpReward,
    required this.hasPhoto,
    required this.isWeekly,
  });

  final String questTitle;
  final String questDescription;
  final IconData questIcon;
  final Color iconColor;
  final int xpReward;
  final bool hasPhoto;
  final bool isWeekly;

  @override
  State<QuestConfirmationDialog> createState() => _QuestConfirmationDialogState();
}

class _QuestConfirmationDialogState extends State<QuestConfirmationDialog> {
  bool _check1 = false;
  bool _check2 = false;
  bool _check3 = false;
  bool _photoUploaded = false;

  bool get _canSubmit {
    // All quests now need photo upload + all 3 checkboxes
    return _check1 && _check2 && _check3 && _photoUploaded;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Fixed Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Konfirmasi Quest',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Apakah Anda sudah menyelesaikan\nquest ini?',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: AppTheme.textMuted,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Scrollable Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show quest info for all quests
                    _buildQuestInfo(),
                    const SizedBox(height: 24),
                    // Always show upload for all quests
                    _buildPhotoUpload(),
                    const SizedBox(height: 24),
                    _buildConfirmationChecks(),
                    const SizedBox(height: 24),
                    _buildButtons(),
                    const SizedBox(height: 16),
                    _buildTipsBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              widget.questIcon,
              color: widget.iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.questTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.questDescription,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE5F1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            size: 12,
                            color: Color(0xFFE91E63),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '+${widget.xpReward} XP',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE91E63),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.hasPhoto) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE5E5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              size: 12,
                              color: Color(0xFFFF6B6B),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Wajib Foto',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF6B6B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelfCheckInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2196F3).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF2196F3),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Self-Check Quest',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Quest ini menggunakan sistem self-check. Pastikan Anda sudah benar-benar melakukannya ya! ',
                      ),
                      TextSpan(text: '🌱'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Foto Bukti *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Upload foto untuk memvalidasi quest ini (max 5MB)',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            // Simulate photo upload
            setState(() {
              _photoUploaded = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Foto berhasil diupload!'),
                backgroundColor: AppTheme.secondaryGreen,
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: _photoUploaded ? const Color(0xFFE8F5E9) : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _photoUploaded ? AppTheme.secondaryGreen : Colors.grey[300]!,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  _photoUploaded ? Icons.check_circle : Icons.upload_outlined,
                  size: 48,
                  color: _photoUploaded ? AppTheme.secondaryGreen : Colors.grey[400],
                ),
                const SizedBox(height: 12),
                Text(
                  _photoUploaded
                      ? 'Foto berhasil diupload'
                      : 'Klik untuk upload foto',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _photoUploaded ? AppTheme.secondaryGreen : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'JPG, PNG, atau HEIC (max 5MB)',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationChecks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Konfirmasi:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 12),
        _buildCheckItem(
          'Saya telah menyelesaikan quest\n"${widget.questTitle}"',
          _check1,
          (value) => setState(() => _check1 = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckItem(
          'Saya berkomitmen untuk gaya hidup\nramah lingkungan',
          _check2,
          (value) => setState(() => _check2 = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckItem(
          'Foto bukti yang saya upload adalah\nasli dan valid',
          _check3,
          (value) => setState(() => _check3 = value ?? false),
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.secondaryGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _canSubmit
                ? () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Quest "${widget.questTitle}" berhasil diselesaikan! +${widget.xpReward} XP'),
                        backgroundColor: AppTheme.secondaryGreen,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryGreen,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[500],
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _photoUploaded ? Icons.check_circle_outline : Icons.upload_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _photoUploaded
                      ? 'Selesaikan Quest'
                      : 'Upload Foto Terlebih Dahulu',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textMuted,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTipsBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: AppTheme.secondaryGreen,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tips Foto Bukti:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _buildTipItem('Pastikan foto jelas dan tidak blur'),
                _buildTipItem('Tunjukkan bukti nyata dari quest yang dilakukan'),
                _buildTipItem('Ambil foto saat melakukan aktivitas eco-friendly'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.primaryGreen,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.primaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
