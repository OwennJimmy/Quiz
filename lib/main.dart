import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindCare - Mental Health App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';
  String _selectedTime = '';
  int _selectedDate = 0;
  bool _isBooked = false;
  
  final List<String> _categories = [
    'Relationships',
    'Parenting',
    'Career motivation',
    'Relationship with parents'
  ];

  final List<String> _timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM'
  ];

  final Map<String, Map<String, dynamic>> _categoryDetails = {
    'Relationships': {
      'color': Color(0xFFFF6B6B),
      'icon': Icons.favorite,
      'description': 'Building Healthy Connections\n\n• Communication skills\n• Trust building\n• Conflict resolution\n• Emotional intimacy\n• Setting boundaries\n\nStrong relationships provide emotional support and improve mental wellbeing.'
    },
    'Parenting': {
      'color': Color(0xFF4ECDC4),
      'icon': Icons.family_restroom,
      'description': 'Nurturing Future Generations\n\n• Positive discipline\n• Emotional development\n• Educational support\n• Work-life balance\n• Self-care for parents\n\nEffective parenting creates secure, confident children.'
    },
    'Career motivation': {
      'color': Color(0xFFFFD166),
      'icon': Icons.work,
      'description': 'Achieving Professional Fulfillment\n\n• Goal setting strategies\n• Skill development\n• Networking techniques\n• Work-life integration\n• Career transitions\n\nFind purpose and satisfaction in your professional journey.'
    },
    'Relationship with parents': {
      'color': Color(0xFF6A0572),
      'icon': Icons.people,
      'description': 'Healing Family Bonds\n\n• Generational understanding\n• Communication patterns\n• Setting healthy boundaries\n• Forgiveness and acceptance\n• Cultural considerations\n\nStrengthen family connections for emotional wellbeing.'
    },
  };

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _showCategoryDialog(category);
  }

  void _onTimeSelected(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _onDateSelected(int day) {
    setState(() {
      _selectedDate = day;
    });
  }

  void _onBooking() {
    if (_selectedDate == 0) {
      _showSnackBar('Please select a date first', Colors.orange);
      return;
    }
    if (_selectedTime.isEmpty) {
      _showSnackBar('Please select a time slot', Colors.orange);
      return;
    }

    _showBookingConfirmation();
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      _showSnackBar('Please enter search keywords', Colors.orange);
      return;
    }
    
    _showSearchResults(query);
  }

  void _onBreathingExercises() {
    _showDialog(
      '🧘 Breathing Exercises',
      'Calm Your Mind with These Techniques:\n\n🌈 **4-7-8 Breathing (Relaxing)**\n• Inhale deeply for 4 seconds\n• Hold your breath for 7 seconds\n• Exhale slowly for 8 seconds\n• Repeat 4 times\n\n🔷 **Box Breathing (Focus)**\n• Inhale 4 seconds\n• Hold 4 seconds\n• Exhale 4 seconds\n• Hold 4 seconds\n\n💨 **Diaphragmatic Breathing (Calming)**\n• Place hand on stomach\n• Breathe deeply into belly\n• Slow exhale through mouth\n• Feel the relaxation',
      Icons.self_improvement,
      Color(0xFF4ECDC4)
    );
  }

  void _onPanicAttackInfo() {
    _showDialog(
      '🚨 Understanding Panic Attacks',
      'A panic attack is a sudden episode of intense fear that triggers severe physical reactions:\n\n🔴 **Common Symptoms:**\n• Rapid heart rate & palpitations\n• Sweating or chills\n• Trembling or shaking\n• Shortness of breath\n• Chest pain or discomfort\n• Nausea or dizziness\n• Fear of losing control\n\n🟢 **Immediate Relief Techniques:**\n• Practice breathing exercises\n• Focus on 5 senses (5-4-3-2-1 method)\n• Use grounding techniques\n• Cold water on wrists\n• Repeat calming mantras\n\n🟡 **When to Seek Help:**\n• Frequent attacks\n• Avoiding situations\n• Impacting daily life\n• Lasting more than 10 minutes',
      Icons.health_and_safety,
      Color(0xFFFF6B6B)
    );
  }

  void _onSpecialistSelected(String name, String description) {
    _showDialog(
      '👨‍⚕️ $name',
      description,
      Icons.psychology,
      Color(0xFF6A0572)
    );
  }

  void _showCategoryDialog(String category) {
    final details = _categoryDetails[category]!;
    _showDialog(
      '${details['icon']} $category',
      details['description'],
      details['icon'] as IconData,
      details['color'] as Color
    );
  }

  void _showSearchResults(String query) {
    final results = _searchMentalHealthTopics(query);
    _showDialog(
      '🔍 Search: "$query"',
      results,
      Icons.search,
      Color(0xFFFFD166)
    );
  }

  String _searchMentalHealthTopics(String query) {
    final lowerQuery = query.toLowerCase();
    
    if (lowerQuery.contains('panic') || lowerQuery.contains('attack')) {
      return '🚨 **Panic Attack Information**\n\nA panic attack is an attack of acute fear, horror, and a mixture of otherworldly feeling.\n\n🎯 **Immediate Help:**\n• Practice breathing exercises\n• Use grounding techniques\n• Focus on surroundings\n• Cold compress on neck\n\n💡 **Prevention:**\n• Regular exercise\n• Limit caffeine\n• Practice mindfulness\n• Maintain sleep schedule';
    }
    else if (lowerQuery.contains('breath') || lowerQuery.contains('exercise')) {
      return '🌬️ **Breathing Exercises Guide**\n\nCalm your nervous system with these techniques:\n\n1. **4-7-8 Breathing** - For relaxation\n2. **Box Breathing** - For focus\n3. **Belly Breathing** - For anxiety\n4. **Alternate Nostril** - For balance\n\n⭐ **Benefits:**\n• Reduces stress hormones\n• Lowers blood pressure\n• Improves focus\n• Promotes relaxation';
    }
    else if (lowerQuery.contains('stress') || lowerQuery.contains('anxiety')) {
      return '😌 **Stress & Anxiety Management**\n\n**Daily Practices:**\n• 🏃‍♂️ 30-minute exercise\n• 🧘‍♀️ 10-minute meditation\n• 📝 Journaling thoughts\n• 🌳 Nature walks\n• 🎵 Calming music\n\n**Professional Support:**\n• Therapy sessions\n• Support groups\n• Online counseling\n• Crisis hotlines';
    }
    else if (lowerQuery.contains('therapy') || lowerQuery.contains('counsel')) {
      return '💬 **Therapy Options Available**\n\n**Types of Therapy:**\n• CBT (Cognitive Behavioral)\n• Mindfulness-Based\n• Group Therapy\n• Online Sessions\n• Family Counseling\n\n**Our specialists are ready to help you!**';
    }
    else {
      return '🌟 **Mental Wellness Tips**\n\n**For Better Mental Health:**\n• Connect with others regularly\n• Stay physically active\n• Practice gratitude daily\n• Get quality sleep\n• Eat balanced meals\n• Take breaks when needed\n\nTry searching: "panic attacks", "breathing exercises", or "stress management"';
    }
  }

  void _showBookingConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.celebration, size: 60, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Booking Confirmed! 🎉',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Dear Mrs. Niken,',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'June $_selectedDate, 2022',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'at $_selectedTime',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'We look forward to supporting your mental wellness journey! 🌈',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF667EEA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _resetBooking();
                    },
                    child: Text('Got it!', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _resetBooking() {
    setState(() {
      _selectedDate = 0;
      _selectedTime = '';
      _isBooked = true;
    });
    
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isBooked = false;
      });
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDialog(String title, String content, IconData icon, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 30, color: color),
                  ),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Understand', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: 25),
              
              // Search Bar
              _buildSearchBar(),
              SizedBox(height: 30),
              
              // Categories
              _buildCategories(),
              SizedBox(height: 30),
              
              // Panic Attack Info
              _buildPanicAttackInfo(),
              SizedBox(height: 30),
              
              // Breathing Exercises
              _buildBreathingExercises(),
              SizedBox(height: 30),
              
              // Booking Button
              _buildBookingButton(),
              SizedBox(height: 30),
              
              // Specialists
              _buildSpecialists(),
              SizedBox(height: 30),
              
              // Calendar Section
              _buildCalendarSection(),
              
              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning,',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Mrs. Niken',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1F2937),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles, topics, help...',
                hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _onSearch,
              icon: Icon(Icons.search, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'For you',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _categories.map((category) {
            final details = _categoryDetails[category]!;
            return GestureDetector(
              onTap: () => _onCategorySelected(category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      details['color'] as Color,
                      (details['color'] as Color).withOpacity(0.8)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: (details['color'] as Color).withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(details['icon'] as IconData, size: 18, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      category,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPanicAttackInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About a panic attack',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 16),
        
        // First info box
        GestureDetector(
          onTap: _onPanicAttackInfo,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF9C4), Color(0xFFFFF59D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFD166).withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What to do if the future scares',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFB76E00),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'How does it nourish itself',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFB76E00),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The four-scoren method',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFB76E00),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        
        // Second info box
        GestureDetector(
          onTap: _onPanicAttackInfo,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE8F5E8), Color(0xFFC8E6C9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4CAF50).withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'A panic attack is an attack of acute fear, horror, and a mixture of otherworldly feeling. Perform breathing exercises and make an appointment with a psychologist.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF2E7D32),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreathingExercises() {
    return GestureDetector(
      onTap: _onBreathingExercises,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF2196F3).withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.self_improvement, color: Colors.white, size: 28),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Breathing exercises',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Effective, harmless ways to relieve stress',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Color(0xFF1565C0)),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingButton() {
    return GestureDetector(
      onTap: _onBooking,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF667EEA).withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: _isBooked
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Booked Successfully!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Booking consultation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSpecialists() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our specialists',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            _buildSpecialistCard(
              'Lory Ford',
              '3 years of experience',
              'Specialized in anxiety disorders and cognitive behavioral therapy. Passionate about helping clients build coping strategies.',
              Color(0xFF667EEA),
            ),
            SizedBox(width: 16),
            _buildSpecialistCard(
              'Kato Carter',
              '5 years of career',
              'Expert in family therapy and trauma-informed care. Focuses on holistic approaches to mental wellness.',
              Color(0xFFFF6B6B),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecialistCard(String name, String experience, String description, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onSpecialistSelected(name, description),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.psychology, color: Colors.white, size: 30),
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                experience,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tap to learn more →',
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'June 2022',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 16),
        
        // Calendar
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.05),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Week days header
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'].map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF667EEA),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              // Calendar dates
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildCalendarRow(['', '1', '2', '3', '4', '5', '']),
                    SizedBox(height: 12),
                    _buildCalendarRow(['4', '7', '8', '9', '10', '11', '12']),
                    SizedBox(height: 12),
                    _buildCalendarRow(['13', '14', '15', '16', '17', '18', '19']),
                    SizedBox(height: 12),
                    _buildCalendarRow(['20', '21', '22', '23', '24', '25', '26']),
                    SizedBox(height: 12),
                    _buildCalendarRow(['27', '28', '29', '30', '', '', '']),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 24),
        
        // Time selection
        Text(
          'Select time',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _timeSlots.map((time) {
            return GestureDetector(
              onTap: () => _onTimeSelected(time),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: _selectedTime == time 
                      ? Color(0xFF667EEA) 
                      : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: _selectedTime == time 
                        ? Color(0xFF667EEA) 
                        : Color(0xFFE5E7EB),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: _selectedTime == time 
                        ? Colors.white 
                        : Color(0xFF667EEA),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24),
        
        // Final booking button
        GestureDetector(
          onTap: _onBooking,
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4ECDC4).withOpacity(0.4),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: _isBooked
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Already Booked!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Complete Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarRow(List<String> dates) {
    return Row(
      children: dates.asMap().entries.map((entry) {
        int index = entry.key;
        String date = entry.value;
        bool isSelectable = date.isNotEmpty;
        bool isSelected = isSelectable && _selectedDate == int.tryParse(date);
        
        return Expanded(
          child: GestureDetector(
            onTap: isSelectable ? () => _onDateSelected(int.parse(date)) : null,
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF667EEA) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  date,
                  style: TextStyle(
                    color: isSelected 
                        ? Colors.white 
                        : isSelectable 
                            ? Color(0xFF374151) 
                            : Colors.transparent,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Text(
          'Dibuat dengan ❤️ oleh: Kemas Muhammad Subhan Al Hasan - 232101176',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}