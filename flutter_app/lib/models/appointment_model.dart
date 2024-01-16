class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final AiAssessment? aiAssessment;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    this.aiAssessment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      aiAssessment: json['aiAssessment'] != null
          ? AiAssessment.fromJson(json['aiAssessment'])
          : null,
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'aiAssessment': aiAssessment?.toJson(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class AiAssessment {
  final String patientId;
  final String symptoms;
  final String assessment;

  AiAssessment({
    required this.patientId,
    required this.symptoms,
    required this.assessment,
  });

  factory AiAssessment.fromJson(Map<String, dynamic> json) {
    return AiAssessment(
      patientId: json['patientId'],
      symptoms: json['symptoms'],
      assessment: json['aiAssessment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'symptoms': symptoms,
      'aiAssessment': assessment,
    };
  }
}
