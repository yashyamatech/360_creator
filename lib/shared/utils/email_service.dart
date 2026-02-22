import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'app_logger.dart';

class EmailService {
  final _log = AppLogger();
  // Configure with your Gmail credentials
  // For production, use environment variables or secure storage
  static const String _senderEmail = 'your-email@gmail.com';
  static const String _senderPassword = 'your-app-password'; // Use app-specific password
  static const String _agencyEmail = 'agency@360creator.com';

  Future<void> sendInquiryEmail({
    required String clientName,
    required String clientEmail,
    required String projectType,
    required String message,
    String? phoneNumber,
    String? budgetRange,
    String? timeline,
  }) async {
    try {
      final smtpServer = gmail(_senderEmail, _senderPassword);

      final emailMessage = Message()
        ..from = Address(_senderEmail, '360 Creator')
        ..recipients.add(clientEmail)
        ..ccRecipients.add(_agencyEmail)
        ..subject = 'Inquiry Confirmation - 360 Creator'
        ..html = _buildInquiryEmailHtml(
          clientName,
          projectType,
          message,
          phoneNumber,
          budgetRange,
          timeline,
        );

      await send(emailMessage, smtpServer);
      _log.i('Inquiry email sent to $clientEmail');
    } catch (e, st) {
      _log.e('Failed to send inquiry email', e, st);
      throw Exception('Failed to send inquiry email: $e');
    }
  }

  Future<void> sendBookingConfirmationEmail({
    required String clientName,
    required String clientEmail,
    String? phoneNumber,
    String? projectRequirements,
    String? budget,
    String? timeline,
  }) async {
    try {
      final smtpServer = gmail(_senderEmail, _senderPassword);

      final emailMessage = Message()
        ..from = Address(_senderEmail, '360 Creator')
        ..recipients.add(clientEmail)
        ..ccRecipients.add('bookings@360creator.com')
        ..subject = 'Booking Confirmation - 360 Creator'
        ..html = _buildBookingEmailHtml(
          clientName,
          projectRequirements,
          budget,
          timeline,
        );

      await send(emailMessage, smtpServer);
      _log.i('Booking confirmation email sent to $clientEmail');
    } catch (e, st) {
      _log.e('Failed to send booking confirmation email', e, st);
      throw Exception('Failed to send booking confirmation email: $e');
    }
  }

  String _buildInquiryEmailHtml(
    String clientName,
    String projectType,
    String message,
    String? phoneNumber,
    String? budgetRange,
    String? timeline,
  ) {
    return '''
    <html>
      <body style="font-family: Arial, sans-serif; color: #333;">
        <h2>Thank you for your inquiry, $clientName!</h2>
        <p>We have received your inquiry and will review it shortly.</p>
        <h3>Inquiry Details:</h3>
        <ul>
          <li><strong>Project Type:</strong> $projectType</li>
          <li><strong>Phone:</strong> ${phoneNumber ?? 'Not provided'}</li>
          <li><strong>Budget Range:</strong> ${budgetRange ?? 'Not specified'}</li>
          <li><strong>Timeline:</strong> ${timeline ?? 'Not specified'}</li>
        </ul>
        <p><strong>Message:</strong></p>
        <p>$message</p>
        <p>Our team will contact you soon with more information.</p>
        <p>Best regards,<br>360 Creator Team</p>
      </body>
    </html>
    ''';
  }

  String _buildBookingEmailHtml(
    String clientName,
    String? projectRequirements,
    String? budget,
    String? timeline,
  ) {
    return '''
    <html>
      <body style="font-family: Arial, sans-serif; color: #333;">
        <h2>Booking Confirmation, $clientName!</h2>
        <p>Your booking has been received successfully.</p>
        <h3>Booking Details:</h3>
        <ul>
          <li><strong>Budget:</strong> ${budget ?? 'TBD'}</li>
          <li><strong>Timeline:</strong> ${timeline ?? 'TBD'}</li>
        </ul>
        <p><strong>Project Requirements:</strong></p>
        <p>${projectRequirements ?? 'Will be discussed'}</p>
        <p>We will contact you shortly to finalize the details.</p>
        <p>Best regards,<br>360 Creator Team</p>
      </body>
    </html>
    ''';
  }
}
