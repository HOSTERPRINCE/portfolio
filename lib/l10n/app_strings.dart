enum AppLocale { en, hi, de }

class AppStrings {
  final AppLocale locale;
  const AppStrings(this.locale);

  String get heroAvailable => switch (locale) {
    AppLocale.en => 'Available for opportunities',
    AppLocale.hi => 'अवसरों के लिए उपलब्ध',
    AppLocale.de => 'Offen für Möglichkeiten',
  };
  String get heroLocation => switch (locale) {
    AppLocale.en => 'India · Open to Remote',
    AppLocale.hi => 'भारत · रिमोट के लिए उपलब्ध',
    AppLocale.de => 'Indien · Remote möglich',
  };
  String get heroHeadline1 => switch (locale) {
    AppLocale.en => 'Building Projects',
    AppLocale.hi => 'प्रोजेक्ट बनाना',
    AppLocale.de => 'Projekte Entwickeln',
  };
  String get heroHeadline2 => switch (locale) {
    AppLocale.en => 'That Inspire',
    AppLocale.hi => 'जो प्रेरित करें',
    AppLocale.de => 'Die Inspirieren',
  };
  String get heroViewWork => switch (locale) {
    AppLocale.en => 'View Work',
    AppLocale.hi => 'काम देखें',
    AppLocale.de => 'Arbeit ansehen',
  };
  String get heroContact => switch (locale) {
    AppLocale.en => 'Contact Me',
    AppLocale.hi => 'संपर्क करें',
    AppLocale.de => 'Kontakt',
  };
  List<String> get roles => switch (locale) {
    AppLocale.en => [
      'Flutter Developer',
      'Software Engineer',
      'Mobile App Architect',
      'Firebase Specialist',
    ],
    AppLocale.hi => [
      'Flutter डेवलपर',
      'सॉफ्टवेयर इंजीनियर',
      'मोबाइल आर्किटेक्ट',
      'Firebase विशेषज्ञ',
    ],
    AppLocale.de => [
      'Flutter Entwickler',
      'Software Ingenieur',
      'Mobile App Architekt',
      'Firebase Spezialist',
    ],
  };

  // About
  String get aboutLabel => switch (locale) {
    AppLocale.en => 'INTRODUCTION',
    AppLocale.hi => 'परिचय',
    AppLocale.de => 'EINFÜHRUNG',
  };
  String get aboutTitle => switch (locale) {
    AppLocale.en => 'About\nMe',
    AppLocale.hi => 'मेरे\nबारे में',
    AppLocale.de => 'Über\nMich',
  };
  String get aboutText => switch (locale) {
    AppLocale.en =>
      "I'm a passionate Flutter Developer with a love for building sleek, modern apps. "
          'I specialize in crafting responsive, futuristic UI/UX that looks great on both web and mobile. '
          'Driven by innovation, I enjoy exploring cutting-edge technologies and bringing ideas to life. '
          "Welcome to my digital space — let's build something extraordinary together!",
    AppLocale.hi =>
      'मैं एक जुनूनी Flutter डेवलपर हूँ जो स्लीक, मॉडर्न ऐप्स बनाने का शौकीन है। '
          'मैं वेब और मोबाइल दोनों पर शानदार दिखने वाले रिस्पॉन्सिव, फ्यूचरिस्टिक UI/UX बनाने में विशेषज्ञ हूँ। '
          'नवाचार से प्रेरित, मुझे अत्याधुनिक तकनीकों को एक्सप्लोर करना और विचारों को जीवंत करना पसंद है। '
          'मेरे डिजिटल स्पेस में आपका स्वागत है — आइए मिलकर कुछ असाधारण बनाएं!',
    AppLocale.de =>
      'Ich bin ein leidenschaftlicher Flutter-Entwickler mit einer Vorliebe für elegante, moderne Apps. '
          'Ich bin spezialisiert auf responsive, futuristische UI/UX, die auf Web und Mobile großartig aussehen. '
          'Getrieben von Innovation, erkunde ich gerne Spitzentechnologien und bringe Ideen zum Leben. '
          'Willkommen in meinem digitalen Raum — lassen Sie uns gemeinsam etwas Außergewöhnliches schaffen!',
  };
  String get statYears => switch (locale) {
    AppLocale.en => 'Years\nExperience',
    AppLocale.hi => 'वर्षों का\nअनुभव',
    AppLocale.de => 'Jahre\nErfahrung',
  };
  String get statProjects => switch (locale) {
    AppLocale.en => 'Projects\n',
    AppLocale.hi => 'प्रोजेक्ट\n',
    AppLocale.de => 'Projekte\n',
  };
  String get statTech => switch (locale) {
    AppLocale.en => 'Core\nSkills',
    AppLocale.hi => 'मुख्य\nकौशल',
    AppLocale.de => 'Kern-\nSkills',
  };

  // Education
  String get eduLabel => switch (locale) {
    AppLocale.en => 'EDUCATION',
    AppLocale.hi => 'शिक्षा',
    AppLocale.de => 'BILDUNG',
  };
  String get eduTitle => switch (locale) {
    AppLocale.en => 'Academic\nBackground',
    AppLocale.hi => 'शैक्षणिक\nपृष्ठभूमि',
    AppLocale.de => 'Akademischer\nWerdegang',
  };
  List<Map<String, String>> get educations => switch (locale) {
    AppLocale.en => [
      {
        'degree': 'Bachelor of Computer Science',
        'institution': 'SRM University Sonepat',
        'period': '2023 – 2027',
        'detail': 'Currently Pursuing',
        'sub': 'Software Engineering',
      },
      {
        'degree': 'Flutter Development Course',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'Certified',
        'sub':
            'Complete Flutter bootcamp covering advanced topics and real-world projects',
      },
      {
        'degree': 'Android Development using Java and Kotlin',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'Android app development',
        'sub': 'Android app development using java and kotlin',
      },
      {
        'degree': 'Web Development',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'Certified',
        'sub':
            'Web Development using java and html,css,js and nodejs,expressjs and mongodb',
      },
    ],
    AppLocale.hi => [
      {
        'degree': 'बैचलर ऑफ कंप्यूटर साइंस',
        'institution': 'SRM University सोनीपत',
        'period': '2023 – 2027',
        'detail': 'वर्तमान में अध्ययनरत',
        'sub': 'सॉफ्टवेयर इंजीनियरिंग',
      },
      {
        'degree': 'Flutter डेवलपमेंट कोर्स',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'प्रमाणित',
        'sub': 'उन्नत विषयों और वास्तविक परियोजनाओं को कवर करने वाला पूर्ण Flutter बूटकैंप',
      },
      {
        'degree': 'Java और Kotlin से Android डेवलपमेंट',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'Android ऐप डेवलपमेंट',
        'sub': 'Java और Kotlin से Android ऐप डेवलपमेंट',
      },
      {
        'degree': 'वेब डेवलपमेंट',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'प्रमाणित',
        'sub': 'HTML, CSS, JS और Node.js, Express.js और MongoDB से वेब डेवलपमेंट',
      },
    ],
    AppLocale.de => [
      {
        'degree': 'Bachelor Informatik',
        'institution': 'SRM University Sonepat',
        'period': '2023 – 2027',
        'detail': 'Derzeit im Studium',
        'sub': 'Software Engineering',
      },
      {
        'degree': 'Flutter Entwicklungskurs',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'Zertifiziert',
        'sub': 'Vollständiges Flutter-Bootcamp mit fortgeschrittenen Themen und realen Projekten',
      },
      {
        'degree': 'Android-Entwicklung mit Java und Kotlin',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'Android-App-Entwicklung',
        'sub': 'Android-App-Entwicklung mit Java und Kotlin',
      },
      {
        'degree': 'Web-Entwicklung',
        'institution': 'Udemy',
        'period': '2024',
        'detail': 'Zertifiziert',
        'sub': 'Webentwicklung mit HTML, CSS, JS und Node.js, Express.js und MongoDB',
      },
    ],
  };

  // Skills
  String get skillsLabel => switch (locale) {
    AppLocale.en => 'EXPERTISE',
    AppLocale.hi => 'विशेषज्ञता',
    AppLocale.de => 'FACHKENNTNIS',
  };
  String get skillsTitle => switch (locale) {
    AppLocale.en => 'Skills &\nTechnologies',
    AppLocale.hi => 'कौशल और\nतकनीकें',
    AppLocale.de => 'Fähigkeiten &\nTechnologien',
  };

  // Projects
  String get projectsLabel => switch (locale) {
    AppLocale.en => 'WORK',
    AppLocale.hi => 'काम',
    AppLocale.de => 'ARBEIT',
  };
  String get projectsTitle => switch (locale) {
    AppLocale.en => 'Featured\nProjects',
    AppLocale.hi => 'प्रमुख\nप्रोजेक्ट',
    AppLocale.de => 'Ausgewählte\nProjekte',
  };
  String get viewProject => switch (locale) {
    AppLocale.en => 'VIEW PROJECT',
    AppLocale.hi => 'प्रोजेक्ट देखें',
    AppLocale.de => 'PROJEKT ANSEHEN',
  };
  List<Map<String, String>> get projects => switch (locale) {
    AppLocale.en => [
      {
        'tag': '01',
        'title': 'PairVana',
        'tech': 'Flutter · Firebase · Cloudinary',
        'description':
            'A fully Social Media application with dating theme where you can post , like , comment , follow , message , search etc with bloc state management',
        'impact': 'Production',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '02',
        'title': 'Khoder',
        'tech': 'Flutter · Firebase · Firebase Auth · FCM · Cloudinary',
        'description':
            'An application like stackOverflow but allows you to get the code copy it and have a compiler to check code , have community based approach like comments replys different feed , notes and wps screen too made for coders.',
        'impact': 'Real-time',
        'color': 'cyan',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': 'https://khoder.vercel.app/',
      },
      {
        'tag': '03',
        'title': 'LifeLine',
        'tech': 'Flutter · FireBase . OpenStreetMaps',
        'description':
            'An cross platform application made for emergency where people can make their vechile as the emergency vechile like ambulance and provide further notification for more bteer road clearance.',
        'impact': 'Emergency Based',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '04',
        'title': 'Caloried Tracker App',
        'tech': 'Flutter . Hive',
        'description':
            'An application where you can track your calories by entering your meal and track it on daily basis how much calories you have consumed and also calculate the macros.',
        'impact': 'fitness',
        'color': 'cyan',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '05',
        'title': 'Sangeet',
        'tech': 'Java',
        'description':
            'A music player which fetches songs from your device and plays them.,',
        'impact': 'Vibe',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
    ],
    AppLocale.hi => [
      {
        'tag': '01',
        'title': 'PairVana',
        'tech': 'Flutter · Firebase · Cloudinary',
        'description': 'डेटिंग थीम वाला सोशल मीडिया ऐप जहाँ आप पोस्ट, लाइक, कमेंट, फॉलो, मैसेज, सर्च आदि कर सकते हैं। Bloc स्टेट मैनेजमेंट के साथ।',
        'impact': 'प्रोडक्शन',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '02',
        'title': 'Khoder',
        'tech': 'Flutter · Firebase · Firebase Auth · FCM · Cloudinary',
        'description': 'StackOverflow जैसा ऐप जहाँ आप कोड कॉपी कर सकते हैं, कंपाइलर से चेक कर सकते हैं, कमेंट, रिप्लाई, फीड, नोट्स और WPS स्क्रीन — कोडर्स के लिए बनाया गया।',
        'impact': 'रियल-टाइम',
        'color': 'cyan',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': 'https://khoder.vercel.app/',
      },
      {
        'tag': '03',
        'title': 'LifeLine',
        'tech': 'Flutter · Firebase · OpenStreetMaps',
        'description': 'इमरजेंसी के लिए बना क्रॉस-प्लेटफ़ॉर्म ऐप जहाँ लोग अपने वाहन को एम्बुलेंस जैसे इमरजेंसी वाहन बना सकते हैं और बेहतर रोड क्लियरेंस के लिए नोटिफिकेशन दे सकते हैं।',
        'impact': 'इमरजेंसी',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '04',
        'title': 'कैलोरी ट्रैकर ऐप',
        'tech': 'Flutter · Hive',
        'description': 'एक ऐप जहाँ आप अपनी मील दर्ज करके कैलोरी ट्रैक कर सकते हैं, दैनिक आधार पर खपत देख सकते हैं और मैक्रोस की गणना कर सकते हैं।',
        'impact': 'फिटनेस',
        'color': 'cyan',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '05',
        'title': 'Sangeet',
        'tech': 'Java',
        'description': 'एक म्यूज़िक प्लेयर जो आपके डिवाइस से गाने लाता है और उन्हें चलाता है।',
        'impact': 'वाइब',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
    ],
    AppLocale.de => [
      {
        'tag': '01',
        'title': 'PairVana',
        'tech': 'Flutter · Firebase · Cloudinary',
        'description': 'Social-Media-App mit Dating-Thema — Posten, Liken, Kommentieren, Folgen, Nachrichten, Suche usw. Mit Bloc State Management.',
        'impact': 'Produktion',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '02',
        'title': 'Khoder',
        'tech': 'Flutter · Firebase · Firebase Auth · FCM · Cloudinary',
        'description': 'StackOverflow-ähnliche App mit Code-Kopieren, Compiler, Community-Kommentaren, Antworten, verschiedenen Feeds, Notizen und WPS — für Entwickler gemacht.',
        'impact': 'Echtzeit',
        'color': 'cyan',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': 'https://khoder.vercel.app/',
      },
      {
        'tag': '03',
        'title': 'LifeLine',
        'tech': 'Flutter · Firebase · OpenStreetMaps',
        'description': 'Plattformübergreifende Notfall-App, mit der Fahrzeuge als Rettungsfahrzeuge markiert werden können, um Benachrichtigungen für bessere Straßenfreigabe zu senden.',
        'impact': 'Notfall',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '04',
        'title': 'Kalorien-Tracker App',
        'tech': 'Flutter · Hive',
        'description': 'App zum Verfolgen von Kalorien durch Mahlzeiteneingabe, täglicher Verbrauchsübersicht und Makronährstoff-Berechnung.',
        'impact': 'Fitness',
        'color': 'cyan',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
      {
        'tag': '05',
        'title': 'Sangeet',
        'tech': 'Java',
        'description': 'Musikplayer, der Songs vom Gerät abruft und abspielt.',
        'impact': 'Vibe',
        'color': 'gold',
        'github': 'https://github.com/HOSTERPRINCE',
        'demo': '',
      },
    ],
  };

  // Achievements
  String get achieveLabel => switch (locale) {
    AppLocale.en => 'RECOGNITION',
    AppLocale.hi => 'उपलब्धियाँ',
    AppLocale.de => 'AUSZEICHNUNGEN',
  };
  String get achieveTitle => switch (locale) {
    AppLocale.en => 'Achievements',
    AppLocale.hi => 'उपलब्धियाँ',
    AppLocale.de => 'Erfolge',
  };
  List<Map<String, String>> get achievements => switch (locale) {
    AppLocale.en => [
      {'icon': 'code', 'title': 'Hackathon Participant', 'sub': 'Super Nova'},
      {'icon': 'people', 'title': '200+ App Users', 'sub': 'Across production deployments'},
      {'icon': 'code', 'title': 'E-Cell Tech Lead', 'sub': 'Led team of 8 developers'},
      {'icon': 'code', 'title': 'Workshop Mentor', 'sub': 'Mentored a Jetpack Compose workshop'},
      {'icon': 'hub', 'title': '20+ GitHub Repositories', 'sub': 'Learning and working projects'},
    ],
    AppLocale.hi => [
      {'icon': 'code', 'title': 'हैकाथॉन प्रतिभागी', 'sub': 'Super Nova'},
      {'icon': 'people', 'title': '200+ ऐप उपयोगकर्ता', 'sub': 'प्रोडक्शन डिप्लॉयमेंट में'},
      {'icon': 'code', 'title': 'E-Cell तकनीकी प्रमुख', 'sub': '8 डेवलपर्स की टीम का नेतृत्व'},
      {'icon': 'code', 'title': 'वर्कशॉप मेंटर', 'sub': 'Jetpack Compose वर्कशॉप का मेंटरिंग'},
      {'icon': 'hub', 'title': '20+ GitHub रिपॉजिटरी', 'sub': 'सीखने और काम करने के प्रोजेक्ट'},
    ],
    AppLocale.de => [
      {'icon': 'code', 'title': 'Hackathon-Teilnehmer', 'sub': 'Super Nova'},
      {'icon': 'people', 'title': '200+ App-Nutzer', 'sub': 'In Produktivumgebungen'},
      {'icon': 'code', 'title': 'E-Cell Tech-Leiter', 'sub': 'Team von 8 Entwicklern geleitet'},
      {'icon': 'code', 'title': 'Workshop-Mentor', 'sub': 'Jetpack Compose Workshop betreut'},
      {'icon': 'hub', 'title': '20+ GitHub-Repositories', 'sub': 'Lern- und Arbeitsprojekte'},
    ],
  };

  // Contact
  String get contactLabel => switch (locale) {
    AppLocale.en => "LET'S TALK",
    AppLocale.hi => 'बात करें',
    AppLocale.de => "KONTAKT",
  };
  String get contactTitle => switch (locale) {
    AppLocale.en => 'Get In\nTouch',
    AppLocale.hi => 'संपर्क\nकरें',
    AppLocale.de => 'Kontakt\nAufnehmen',
  };
  String get contactSubtitle => switch (locale) {
    AppLocale.en =>
      'Open to full-time roles, freelance projects, and exciting collaborations. Let\'s build something remarkable together.',
    AppLocale.hi =>
      'पूर्णकालिक भूमिकाओं, फ्रीलांस परियोजनाओं और रोमांचक सहयोगों के लिए खुला। आइए मिलकर कुछ उल्लेखनीय बनाएं।',
    AppLocale.de =>
      'Offen für Vollzeitstellen, Freelance-Projekte und spannende Kooperationen. Lassen Sie uns gemeinsam etwas Bemerkenswertes schaffen.',
  };
  String get formName => switch (locale) {
    AppLocale.en => 'Your Name',
    AppLocale.hi => 'आपका नाम',
    AppLocale.de => 'Ihr Name',
  };
  String get formEmail => switch (locale) {
    AppLocale.en => 'Your Email',
    AppLocale.hi => 'आपका ईमेल',
    AppLocale.de => 'Ihre E-Mail',
  };
  String get formMessage => switch (locale) {
    AppLocale.en => 'Your Message',
    AppLocale.hi => 'आपका संदेश',
    AppLocale.de => 'Ihre Nachricht',
  };
  String get formSend => switch (locale) {
    AppLocale.en => 'Send Message',
    AppLocale.hi => 'संदेश भेजें',
    AppLocale.de => 'Nachricht senden',
  };
  String get formSent => switch (locale) {
    AppLocale.en => 'Message sent! I\'ll get back to you soon.',
    AppLocale.hi => 'संदेश भेजा गया! मैं जल्द ही आपसे संपर्क करूँगा।',
    AppLocale.de => 'Nachricht gesendet! Ich melde mich bald bei Ihnen.',
  };

  // Footer
  String get footerCraft => switch (locale) {
    AppLocale.en => 'Crafted with Flutter · Designed with Purpose',
    AppLocale.hi => 'Flutter से बनाया · उद्देश्य के साथ डिज़ाइन किया',
    AppLocale.de => 'Mit Flutter entwickelt · Mit Absicht gestaltet',
  };

  // Section nav labels
  List<String> get sectionLabels => switch (locale) {
    AppLocale.en => [
      'Home',
      'About',
      'Education',
      'Skills',
      'Projects',
      'Awards',
      'Contact',
    ],
    AppLocale.hi => [
      'होम',
      'परिचय',
      'शिक्षा',
      'कौशल',
      'प्रोजेक्ट',
      'पुरस्कार',
      'संपर्क',
    ],
    AppLocale.de => [
      'Start',
      'Über',
      'Bildung',
      'Skills',
      'Projekte',
      'Preise',
      'Kontakt',
    ],
  };
}
