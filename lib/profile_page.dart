import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 32),
        Center(
          child: Text(
            'Profile Page',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.0,
                ),
              ),
              child: CircleAvatar(
                foregroundImage: Image.asset('assets/images/1305211.png').image,
                radius: 100,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Material(
            color: Theme.of(context).colorScheme.primaryContainer,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                IconTextButton(
                  icon: Icons.favorite,
                  label: 'Favourites',
                  onTap: () {},
                ),
                SizedBox(height: 4),
                IconTextButton(
                  icon: Icons.star,
                  label: 'Reviews',
                  onTap: () {},
                ),
                SizedBox(height: 4),
                IconTextButton(
                  icon: Icons.person_2,
                  label: 'Edit Profile',
                  onTap: () {},
                ),
                SizedBox(height: 4),
                IconTextButton(
                  icon: Icons.logout,
                  label: 'Sign Out',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
