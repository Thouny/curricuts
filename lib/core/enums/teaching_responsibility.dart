enum TeachingResponsibility {
  biomedicalEngineering,
  civilEnvironmentalEngineering,
  computerScience,
  electricalDataEngineering,
  informationSystemsModelling,
  mechanicalMechatronicEngineering,
  professionalPracticeLeadership,
  unmapped,
}

extension TeachingResponsibilityExtension on TeachingResponsibility {
  String get name {
    switch (this) {
      case TeachingResponsibility.biomedicalEngineering:
        return 'Biomedical Engineering';
      case TeachingResponsibility.civilEnvironmentalEngineering:
        return 'Civil and Environmental Engineering';
      case TeachingResponsibility.computerScience:
        return 'Computer Science';
      case TeachingResponsibility.electricalDataEngineering:
        return 'Electrical and Data Engineering';
      case TeachingResponsibility.informationSystemsModelling:
        return 'Information, Systems and Modelling';
      case TeachingResponsibility.mechanicalMechatronicEngineering:
        return 'Mechanical and Mechatronic Engineering';
      case TeachingResponsibility.professionalPracticeLeadership:
        return 'Professional Practice and Leadership';
      case TeachingResponsibility.unmapped:
        return 'Unmapped';
    }
  }
}

class TeachingResponsibilityTypeConverter {
  static TeachingResponsibility convertFrom(String name) {
    switch (name) {
      case 'Biomedical Engineering':
        return TeachingResponsibility.biomedicalEngineering;
      case 'Civil and Environmental Engineering':
        return TeachingResponsibility.civilEnvironmentalEngineering;
      case 'Computer Science':
        return TeachingResponsibility.computerScience;
      case 'Electrical and Data Engineering':
        return TeachingResponsibility.electricalDataEngineering;
      case 'Information, Systems and Modelling':
        return TeachingResponsibility.informationSystemsModelling;
      case 'Mechanical and Mechatronic Engineering':
        return TeachingResponsibility.mechanicalMechatronicEngineering;
      case 'Professional Practice and Leadership':
        return TeachingResponsibility.professionalPracticeLeadership;
      default:
        return TeachingResponsibility.unmapped;
    }
  }
}
