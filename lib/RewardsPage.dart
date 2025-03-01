import 'package:flutter/material.dart';
import 'dart:math' as math;

class UserRewards {
  int totalPoints;
  int ngoDriveParticipations;
  int wastePhotosSubmitted;
  List<Achievement> achievements;

  UserRewards({
    this.totalPoints = 0,
    this.ngoDriveParticipations = 0,
    this.wastePhotosSubmitted = 0,
    List<Achievement>? achievements,
  }) : achievements = achievements ?? [];
}

class Achievement {
  final String title;
  final String description;
  final int points;
  final IconData icon;
  final bool isUnlocked;

  Achievement({
    required this.title,
    required this.description,
    required this.points,
    required this.icon,
    this.isUnlocked = false,
  });
}

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _headerAnimation;
  final List<GlobalKey<State<StatefulWidget>>> _achievementKeys =
      List.generate(4, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _headerAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Simulated user rewards data
  final UserRewards _userRewards = UserRewards(
    totalPoints: 350,
    ngoDriveParticipations: 2,
    wastePhotosSubmitted: 15,
    achievements: [
      Achievement(
        title: 'NGO Drive Pioneer',
        description: 'Participated in first NGO drive',
        points: 100,
        icon: Icons.volunteer_activism,
        isUnlocked: true,
      ),
      Achievement(
        title: 'Waste Warrior',
        description: 'Submitted 10 waste photos',
        points: 50,
        icon: Icons.camera_alt,
        isUnlocked: true,
      ),
      Achievement(
        title: 'Community Leader',
        description: 'Participate in 5 NGO drives',
        points: 200,
        icon: Icons.groups,
        isUnlocked: false,
      ),
      Achievement(
        title: 'Master Recycler',
        description: 'Submit 50 waste photos',
        points: 150,
        icon: Icons.recycling,
        isUnlocked: false,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildRewardsHeader(),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.2, 0.4, curve: Curves.easeOut),
                  )),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.2, 0.4),
                      ),
                    ),
                    child: _buildPointsSummary(),
                  ),
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.3, 0.5, curve: Curves.easeOut),
                  )),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.3, 0.5),
                      ),
                    ),
                    child: _buildActivityStats(),
                  ),
                ),
                _buildAchievements(),
                _buildRewardsList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRewardsHeader() {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[700]!, Colors.green[500]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              children: [
                Transform.scale(
                  scale: _headerAnimation.value,
                  child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 1000),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.rotate(
                        angle: (1 - value) * math.pi,
                        child: Opacity(
                          opacity: value,
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.emoji_events,
                              size: 40,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _headerAnimation,
                  child: const Text(
                    'Your Rewards',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1500),
                  tween: IntTween(begin: 0, end: _userRewards.totalPoints),
                  builder: (context, int value, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        '$value Points',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPointsSummary() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.stars, color: Colors.green[700], size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'How to Earn Points',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildPointItem(
                Icons.volunteer_activism,
                'NGO Drive Participation',
                '100 points per drive',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(),
              ),
              _buildPointItem(
                Icons.camera_alt,
                'Waste Photo Submission',
                '10 points per photo',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointItem(IconData icon, String title, String points) {
    return Row(
      children: [
        Icon(icon, color: Colors.green[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                points,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildAnimatedStatCard(
              'NGO Drives',
              _userRewards.ngoDriveParticipations.toString(),
              Icons.volunteer_activism,
              0.4,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildAnimatedStatCard(
              'Photos',
              _userRewards.wastePhotosSubmitted.toString(),
              Icons.camera_alt,
              0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedStatCard(
      String title, String value, IconData icon, double delay) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _controller,
        curve: Interval(delay, delay + 0.2, curve: Curves.easeOut),
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.green[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: Colors.green[700], size: 32),
              const SizedBox(height: 12),
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 1500),
                tween: IntTween(begin: 0, end: int.parse(value)),
                builder: (context, int animatedValue, child) {
                  return Text(
                    animatedValue.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.military_tech, color: Colors.green[700]),
              const SizedBox(width: 8),
              const Text(
                'Achievements',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: _userRewards.achievements.length,
            itemBuilder: (context, index) {
              final achievement = _userRewards.achievements[index];
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    0.4 + (index * 0.1),
                    0.6 + (index * 0.1),
                    curve: Curves.easeOut,
                  ),
                )),
                child: _buildAchievementCard(achievement),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: achievement.isUnlocked ? Colors.white : Colors.grey[100],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: achievement.isUnlocked
                ? LinearGradient(
                    colors: [Colors.white, Colors.green[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                achievement.icon,
                size: 40,
                color: achievement.isUnlocked ? Colors.green[700] : Colors.grey,
              ),
              const SizedBox(height: 12),
              Text(
                achievement.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: achievement.isUnlocked ? Colors.black87 : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: achievement.isUnlocked
                      ? Colors.green[100]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${achievement.points} pts',
                  style: TextStyle(
                    color: achievement.isUnlocked
                        ? Colors.green[700]
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.card_giftcard, color: Colors.green[700]),
              const SizedBox(width: 8),
              const Text(
                'Available Rewards',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ..._buildAnimatedRewardItems(),
      ],
    );
  }

  List<Widget> _buildAnimatedRewardItems() {
    final rewards = [
      ('Eco-friendly Water Bottle', '500 points', Icons.water_drop),
      ('Plant a Tree in Your Name', '750 points', Icons.park),
      ('Recycling Kit', '1000 points', Icons.recycling),
    ];

    return List.generate(rewards.length, (index) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.2, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.6 + (index * 0.1),
            0.8 + (index * 0.1),
            curve: Curves.easeOut,
          ),
        )),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.6 + (index * 0.1),
              0.8 + (index * 0.1),
            ),
          ),
          child: _buildRewardItem(
            rewards[index].$1,
            rewards[index].$2,
            rewards[index].$3,
            false,
          ),
        ),
      );
    });
  }

  Widget _buildRewardItem(
      String title, String points, IconData icon, bool isRedeemed) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[50]!],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.green[700]),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            points,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: ElevatedButton(
            onPressed: _userRewards.totalPoints >= 500 ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Redeem',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
