import 'package:e_com_app/models/user_profile_model.dart';
import 'package:e_com_app/provider/user_profile_provider.dart';
import 'package:e_com_app/screens/login_page.dart';
import 'package:e_com_app/widgets/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the data fetch when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileProvider>().fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        title: Text('Account'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, child) {
          if (userProfileProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (userProfileProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(userProfileProvider.errorMessage));
          } else if (userProfileProvider.userProfile == null) {
            return Center(child: Text('No user profile data available.'));
          } else {
            final userProfile = userProfileProvider.userProfile!;
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildProfileInfo(userProfile),
                SizedBox(height: 20),
                AccountOptionTile(
                  title: 'Orders',
                  icon: Icons.shopping_basket,
                  onTap: () {
                    // Handle Orders tap
                  },
                ),
                AccountOptionTile(
                  title: 'Address',
                  icon: Icons.location_on,
                  onTap: () {
                    // Handle Address tap
                  },
                ),
                AccountOptionTile(
                  title: 'Payment Methods',
                  icon: Icons.payment,
                  onTap: () {
                    // Handle Payment Methods tap
                  },
                ),
                AccountOptionTile(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    // Handle Settings tap
                  },
                ),
                AccountOptionTile(
                  title: 'Logout',
                  icon: Icons.exit_to_app,
                  onTap: () {
                    // Show SnackBar before navigating
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logging out...')),
                    );
                    // Navigate after a delay to LoginPage
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    });
                  },
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  // Section to display profile information
  Widget _buildProfileInfo(UserProfileModel userProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.account_circle,
            size: 60,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Name: ${userProfile.name?.firstname} ${userProfile.name?.lastname}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'Email: ${userProfile.email}',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          'Phone: ${userProfile.phone}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Divider(),
      ],
    );
  }
}

class AccountOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const AccountOptionTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => onTap(),
    );
  }
}
