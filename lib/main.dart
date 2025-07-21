import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PaperType {
  final String name;
  int count;

  PaperType({
    required this.name,
    required this.count,
  });
}

class _ChartData {
  final String day;
  final int bottles;

  _ChartData(this.day, this.bottles);
}

void main() => runApp(const PaperCycleApp());

class PaperCycleApp extends StatelessWidget {
  const PaperCycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaperCycle - Pinamukan IS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = const Color(0xFF6A7C5E);
    final Color logoCircleColor = const Color(0xFF6EE76D);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
  width: 100,
  height: 80,
  decoration: BoxDecoration(
    color: logoCircleColor, // Using the variable
    shape: BoxShape.circle,
    image: DecorationImage(
      image: AssetImage('images/logo.jpeg'),
      fit: BoxFit.contain,
    ),
  ),
),
    const SizedBox(width: 12),
    const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Paper',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            )),
        Text('Cycle',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            )),
      ],
    ),
  ],
),
            
            const SizedBox(height: 8),
            const Text(
              'Pinamukan Integrated School',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withAlpha(229),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'GET STARTED',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';
  bool _obscureText = true;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      errorMessage = '';
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter both email and password';
        _isLoading = false;
      });
      return;
    }

    const String predefinedEmail = 'pinamukan@admin.com';
    const String predefinedPassword = 'pinamukan123';

    if (email == predefinedEmail && password == predefinedPassword) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      setState(() {
        errorMessage = 'Invalid email or password';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 80, 
            color: const Color(0xFF6A7C5E),
            child: Center(
              child: Text(
                'Pinamukan IS Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Image.asset(
                    'images/pinamukan_logo.jpg',
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => 
                      const Icon(Icons.school, size: 100, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Login to PaperCycle',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'School Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A7C5E),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'LOG IN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80, 
            color: const Color(0xFF6A7C5E),
            child: Center(
              child: Text(
                'Pinamukan Integrated School © 2023',
                style: TextStyle(
                  color: Colors.white.withAlpha(280),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool _isLoading = true;
  bool _showWeeklyChart = true;

  // Collection targets
  final int weeklyTarget = 200;
  final int monthlyTarget = 800;
  final int schoolYearTarget = 5000;

  // Student Database
  final Map<String, Map<String, dynamic>> students = {
    '2023-001': {
      'name': 'Juan Dela Cruz',
      'grade': 'Grade 11',
      'strand': 'STEM',
      'section': 'Newton',
      'avatar': '👦',
      'bottles': 24,
    },
    '2023-002': {
      'name': 'Maria Santos',
      'grade': 'Grade 12',
      'strand': 'HUMSS',
      'section': 'Aristotle',
      'avatar': '👧',
      'bottles': 32,
    },
    '2023-003': {
      'name': 'Pedro Reyes',
      'grade': 'Grade 10',
      'strand': 'ICT',
      'section': 'Edison',
      'avatar': '👨',
      'bottles': 15,
    },
    '2023-004': {
      'name': 'Anna Lopez',
      'grade': 'Grade 11',
      'strand': 'ABM',
      'section': 'Pythagoras',
      'avatar': '👩',
      'bottles': 28,
    },
    '2023-005': {
      'name': 'Carlos Gomez',
      'grade': 'Grade 12',
      'strand': 'STEM',
      'section': 'Einstein',
      'avatar': '🧑',
      'bottles': 19,
    },
  };

  List<Map<String, dynamic>> activities = [];
  List<Map<String, dynamic>> alerts = [];
  List<Map<String, dynamic>> binHistory = [];
  List<PaperType> paperTypes = [
    PaperType(name: 'Oslo', count: 25),
    PaperType(name: 'Long Bond', count: 42),
    PaperType(name: 'Short Bond', count: 18),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      activities = [
        {
          'time': '3:11 PM',
          'date': 'Nov 15, 2023',
          'action': 'Recycled 6 plastic bottles',
          'reward': '1 Oslo paper dispensed',
          'studentId': '2023-001',
          'type': 'recycling',
        },
        {
          'time': '2:45 PM',
          'date': 'Nov 15, 2023',
          'action': 'Recycled 3 plastic bottles',
          'reward': '1 Long Bond paper dispensed',
          'studentId': '2023-002',
          'type': 'recycling',
        },
        {
          'time': '2:30 PM',
          'date': 'Nov 14, 2023',
          'action': 'Recycled 3 plastic bottles',
          'reward': '1 Short Bond paper dispensed',
          'studentId': '2023-003',
          'type': 'recycling',
        },
        {
          'time': '1:10 PM',
          'date': 'Nov 14, 2023',
          'action': 'System maintenance',
          'reward': 'Machine calibrated',
          'studentId': 'admin',
          'type': 'maintenance',
        },
        {
          'time': '10:45 AM',
          'date': 'Nov 13, 2023',
          'action': 'Recycled 5 plastic bottles',
          'reward': '1 Oslo paper dispensed',
          'studentId': '2023-004',
          'type': 'recycling',
        },
        {
          'time': '9:30 AM',
          'date': 'Nov 12, 2023',
          'action': 'Recycled 8 plastic bottles',
          'reward': '1 Long Bond paper dispensed',
          'studentId': '2023-002',
          'type': 'recycling',
        },
        {
          'time': '3:15 PM',
          'date': 'Nov 11, 2023',
          'action': 'Recycled 4 plastic bottles',
          'reward': '1 Short Bond paper dispensed',
          'studentId': '2023-005',
          'type': 'recycling',
        },
      ];

      alerts = [
        {
          'type': 'full',
          'message': 'Bottle bin is full (50/50)',
          'time': '2:45 PM',
          'date': 'Nov 16, 2023',
          'urgent': true,
        },
        {
          'type': 'invalid',
          'message': 'Non-bottle object detected',
          'time': '10:30 AM',
          'date': 'Nov 16, 2023',
          'studentId': '2023-001',
          'urgent': true,
        },
        {
          'type': 'maintenance',
          'message': 'Scheduled maintenance needed',
          'time': '9:00 AM',
          'date': 'Nov 16, 2023',
          'urgent': false,
        },
      ];

      binHistory = [
        {'date': 'Nov 16, 2023', 'action': 'Emptied', 'bottles': 50},
        {'date': 'Nov 14, 2023', 'action': 'Emptied', 'bottles': 42},
        {'date': 'Nov 11, 2023', 'action': 'Emptied', 'bottles': 38},
        {'date': 'Nov 8, 2023', 'action': 'Emptied', 'bottles': 45},
      ];

      _isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildStockPage() {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Paper Stock Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A7C5E),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSummaryItem(Icons.description, 'Total Types', '${paperTypes.length}'),
                    _buildSummaryItem(Icons.layers, 'Total Sheets', 
                      '${paperTypes.fold(0, (sum, paper) => sum + paper.count)}'),
                  ],
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: paperTypes.length,
            itemBuilder: (context, index) {
              final paper = paperTypes[index];
              return _buildPaperTypeCard(paper, index);
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () => _showAddPaperDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Add New Paper Type'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A7C5E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 28, color: const Color(0xFF6A7C5E)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaperTypeCard(PaperType paper, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _getPaperIcon(paper.name),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paper.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${paper.count} sheets available',
                        style: TextStyle(
                          color: paper.count < 10 ? Colors.red : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showEditDialog(context, paper, index),
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6A7C5E),
                      side: const BorderSide(color: Color(0xFF6A7C5E)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showRestockDialog(context, paper, index),
                    icon: const Icon(Icons.add_box, size: 18),
                    label: const Text('Restock'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A7C5E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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

  String _getPaperIcon(String paperName) {
    if (paperName.contains('Oslo')) return '📄';
    if (paperName.contains('Bond')) return '📝';
    if (paperName.contains('Colored')) return '🎨';
    if (paperName.contains('Cartolina')) return '🖍️';
    return '📑';
  }

  void _showEditDialog(BuildContext context, PaperType paper, int index) {
    final nameController = TextEditingController(text: paper.name);
    final countController = TextEditingController(text: paper.count.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Paper Type'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Paper Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: countController,
                decoration: const InputDecoration(
                  labelText: 'Sheet Count',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                paperTypes[index] = PaperType(
                  name: nameController.text,
                  count: int.tryParse(countController.text) ?? paper.count,
                );
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${paper.name} updated')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A7C5E),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _showRestockDialog(BuildContext context, PaperType paper, int index) {
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Restock ${paper.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current stock: ${paper.count} sheets'),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity to add',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(quantityController.text) ?? 0;
              if (quantity > 0) {
                setState(() {
                  paperTypes[index] = PaperType(
                    name: paper.name,
                    count: paper.count + quantity,
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Restocked $quantity sheets of ${paper.name}')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A7C5E),
            ),
            child: const Text('Restock'),
          ),
        ],
      ),
    );
  }

  void _showAddPaperDialog(BuildContext context) {
    final nameController = TextEditingController();
    final countController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Paper Type'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Paper Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: countController,
                decoration: const InputDecoration(
                  labelText: 'Initial Stock',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final count = int.tryParse(countController.text) ?? 0;
              if (nameController.text.isNotEmpty && count > 0) {
                setState(() {
                  paperTypes.add(PaperType(
                    name: nameController.text,
                    count: count,
                  ));
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added ${nameController.text} to paper types')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A7C5E),
            ),
            child: const Text('Add Paper'),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesPage() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text(
                'Pinamukan IS Activities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Chip(
                label: Text('${activities.length} records'),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadData,
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                final isAdmin = activity['studentId'] == 'admin';
                final student = isAdmin ? null : students[activity['studentId']!];
                
                return GestureDetector(
                  onTap: () => _showActivityDetails(index),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: isAdmin ? Colors.grey[200] : Colors.green[100],
                                child: Text(isAdmin ? '🛠️' : student!['avatar']),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isAdmin ? 'System Activity' : student!['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${activity['time']} • ${activity['date']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(activity['action']),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                activity['reward'],
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showActivityDetails(int index) {
    final activity = activities[index];
    final isAdmin = activity['studentId'] == 'admin';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Activity Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              if (!isAdmin) ...[
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Text(students[activity['studentId']]!['avatar']),
                  ),
                  title: Text(students[activity['studentId']]!['name']),
                  subtitle: Text(
                    '${students[activity['studentId']]!['grade']} ${students[activity['studentId']]!['strand']} - ${students[activity['studentId']]!['section']}',
                  ),
                ),
                const Divider(),
              ],
              _buildDetailRow('Date', activity['date']),
              _buildDetailRow('Time', activity['time']),
              _buildDetailRow('Action', activity['action']),
              _buildDetailRow('Reward', activity['reward']),
              if (!isAdmin) 
                _buildDetailRow('Total Bottles Recycled', 
              '${students[activity['studentId']!]!['bottles']} bottles')
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildAlertsPage() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text(
                'System Alerts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Chip(
                label: Text('${alerts.length} alerts'),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadData,
            child: ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                final student = alert['studentId'] != null ? students[alert['studentId']] : null;
                
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: alert['urgent'] ? Colors.red[50] : null,
                  child: ListTile(
                    leading: Icon(
                      alert['type'] == 'full' 
                        ? Icons.warning
                        : alert['type'] == 'invalid'
                          ? Icons.block
                          : Icons.engineering,
                      color: alert['urgent'] ? Colors.red : Colors.orange,
                    ),
                    title: Text(
                      alert['message'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: alert['urgent'] ? Colors.red[800] : Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (student != null)
                          Text('Student: ${student['name']}'),
                        Text('${alert['time']} • ${alert['date']}'),
                      ],
                    ),
                    trailing: alert['urgent']
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                    onTap: () => _showAlertDetails(alert),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showAlertDetails(Map<String, dynamic> alert) {
    final student = alert['studentId'] != null ? students[alert['studentId']] : null;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          alert['type'] == 'full'
            ? 'Bottle Bin Full'
            : alert['type'] == 'invalid'
              ? 'Invalid Object Detected'
              : 'Maintenance Needed',
          style: TextStyle(
            color: alert['urgent'] ? Colors.red : Colors.blue,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alert['message']),
            const SizedBox(height: 16),
            _buildDetailRow('Date', alert['date']),
            _buildDetailRow('Time', alert['time']),
            if (student != null) ...[
              const SizedBox(height: 8),
              _buildDetailRow('Student', student['name']),
              _buildDetailRow('Grade', '${student['grade']} ${student['strand']}'),
              _buildDetailRow('Section', student['section']),
            ],
            const SizedBox(height: 8),
            Text(
              alert['urgent'] ? '❗ Urgent Attention Needed' : 'ℹ️ Informational',
              style: TextStyle(
                color: alert['urgent'] ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Dismiss'),
          ),
          if (alert['urgent'])
            TextButton(
              onPressed: () {
                setState(() {
                  alerts.remove(alert);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Alert resolved')),
                );
              },
              child: const Text('Resolve'),
            ),
        ],
      ),
    );
  }

  Widget _buildCollectionChart() {
    final weeklyData = [
      _ChartData('Mon', 25),
      _ChartData('Tue', 42),
      _ChartData('Wed', 38),
      _ChartData('Thu', 56),
      _ChartData('Fri', 29),
    ];

    final monthlyData = [
      _ChartData('Week 1', 180),
      _ChartData('Week 2', 210),
      _ChartData('Week 3', 195),
      _ChartData('Week 4', 230),
    ];

    final data = _showWeeklyChart ? weeklyData : monthlyData;
    final target = _showWeeklyChart ? weeklyTarget : monthlyTarget;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showWeeklyChart ? 'Weekly Collection' : 'Monthly Collection',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => setState(() => _showWeeklyChart = !_showWeeklyChart),
                  child: Text(
                    _showWeeklyChart ? 'Show Monthly' : 'Show Weekly',
                    style: TextStyle(color: Colors.green[700]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey[800],
                      getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                        BarTooltipItem(
                          '${data[groupIndex].day}\n${rod.toY.toInt()} bottles',
                          const TextStyle(color: Colors.white),
                        ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(
                          data[value.toInt()].day,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey[300]!,
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: data
                      .asMap()
                      .entries
                      .map((entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.bottles.toDouble(),
                                color: Colors.green,
                                width: 16,
                                borderRadius: BorderRadius.circular(4),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: target.toDouble(),
                                  color: Colors.grey[200],
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Target: $target bottles',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboard() {
    final sortedStudents = students.values.toList()
      ..sort((a, b) => b['bottles'].compareTo(a['bottles']));

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Recyclers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...sortedStudents.take(5).map((student) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green[100],
                child: Text(student['avatar']),
              ),
              title: Text(student['name']),
              subtitle: Text('${student['grade']} ${student['strand']}'),
              trailing: Chip(
                label: Text('${student['bottles']}'),
                backgroundColor: Colors.green[50],
              ),
            )).toSet(),
            if (sortedStudents.length > 5)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Full leaderboard coming soon!')),
                  );
                },
                child: const Text('View All Students'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetProgress() {
    final totalBottles = activities.fold(0, (sum, activity) => 
      activity['type'] == 'recycling' ? 
      sum + (int.tryParse(activity['action'].split(' ')[2]) ?? 0) : 
      sum
    );

    final weeklyProgress = (totalBottles / weeklyTarget * 100).clamp(0, 100).toInt();
    final monthlyProgress = (totalBottles / monthlyTarget * 100).clamp(0, 100).toInt();
    final yearlyProgress = (totalBottles / schoolYearTarget * 100).clamp(0, 100).toInt();

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Collection Targets',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildProgressItem('Weekly', weeklyProgress, weeklyTarget),
            _buildProgressItem('Monthly', monthlyProgress, monthlyTarget),
            _buildProgressItem('School Year', yearlyProgress, schoolYearTarget),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String label, int progress, int target) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$progress% ($target bottles)',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress / 100,
            minHeight: 10,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 100 ? Colors.green : Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }

  Widget _buildBinHistory() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bin History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (binHistory.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'No bin history available',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              Column(
                children: binHistory.map((entry) => ListTile(
                  leading: const Icon(Icons.delete, color: Colors.green),
                  title: Text('${entry['action']} - ${entry['bottles']} bottles'),
                  subtitle: Text(entry['date']),
                  trailing: const Icon(Icons.chevron_right),
                )).toList(),
              ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Detailed bin history coming soon!')),
                );
              },
              child: const Text('View Full History'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottlesPage() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final totalBottles = activities.fold(0, (sum, activity) => 
      activity['type'] == 'recycling' ? 
      sum + (int.tryParse(activity['action'].split(' ')[2]) ?? 0) : 
      sum
    );

    final fullAlert = alerts.firstWhere(
      (alert) => alert['type'] == 'full',
      orElse: () => {},
    );
    final isBinFull = fullAlert.isNotEmpty;
    final binCapacity = isBinFull ? 50 : 0 ;
    final binPercentage = (binCapacity / 50 * 100).toInt();

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.recycling, size: 50, color: Colors.green),
                  const SizedBox(height: 16),
                  const Text(
                    'Total Bottles Collected',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$totalBottles',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Since ${activities.isNotEmpty ? activities.last['date'] : 'system start'}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isBinFull ? Icons.warning : Icons.check_circle,
                        color: isBinFull ? Colors.orange : Colors.green,
                        size: 30 ,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isBinFull ? 'Bin Full' : 'Bin Status Normal',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isBinFull ? Colors.orange : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: binCapacity / 50,
                    minHeight: 20,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isBinFull ? Colors.red : Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$binCapacity/50 bottles ($binPercentage%)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (isBinFull)
                    Text(
                      'Last alert: ${fullAlert['time']} ${fullAlert['date']}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        alerts.removeWhere((alert) => alert['type'] == 'full');
                        binHistory.insert(0, {
                          'date': 'Now',
                          'action': 'Emptied',
                          'bottles': binCapacity,
                        });
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Bin has been emptied')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Mark as Emptied'),
                  ),
                ],
              ),
            ),
          ),

          _buildCollectionChart(),
          _buildLeaderboard(),
          _buildTargetProgress(),
          _buildBinHistory(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildActivitiesPage(),
      _buildAlertsPage(),
      _buildBottlesPage(),
      _buildStockPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('PaperCycle - Pinamukan IS'),
        backgroundColor: const Color(0xFF6A7C5E),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF6A7C5E),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Bottles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Stock',
          ),
        ],
      ),
    );
  }
}