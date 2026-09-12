import 'package:flutter/material.dart';
import '../attendance/attendance_screen.dart';
import '../children/children_screen.dart';
import '../activities/activities_screen.dart';
import '../fees/fee_screen.dart';
import '../parent/parents_screen.dart';
import '../../models/dashboard.dart';
import '../../services/dashboard_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  late Future<Dashboard>
      dashboardFuture;

  final items = [
    "Children",
    "Attendance",
    "Activities",
    "Fees",
    "Parents",
    "Reports",
  ];

  @override
  void initState() {
    super.initState();

    dashboardFuture =
        DashboardService()
            .getDashboard();
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding:
            const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(
              title,
              style:
                  const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Play School Admin",
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            dashboardFuture = DashboardService().getDashboard();
          });

          await dashboardFuture;
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            FutureBuilder<Dashboard>(
              future:
                  dashboardFuture,

              builder:
                  (context,
                      snapshot) {

                if (!snapshot
                    .hasData) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                final data =
                    snapshot.data!;

                return GridView.count(
                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  crossAxisCount:
                      2,

                  crossAxisSpacing:
                      10,

                  mainAxisSpacing:
                      10,

                  childAspectRatio:
                      1.8,

                  children: [

                    _statCard(
                      "Children",
                      data
                          .totalChildren
                          .toString(),
                      Icons.people,
                    ),

                    _statCard(
                      "Present",
                      data
                          .presentToday
                          .toString(),
                      Icons
                          .check_circle,
                    ),

                    _statCard(
                      "Absent",
                      data
                          .absentToday
                          .toString(),
                      Icons.cancel,
                    ),

                    _statCard(
                      "Activities",
                      data
                          .activities
                          .toString(),
                      Icons.event,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),

            GridView.builder(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount:
                  items.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    2,
                crossAxisSpacing:
                    12,
                mainAxisSpacing:
                    12,
              ),

              itemBuilder:
                  (context, index) {

                return InkWell(
                  onTap: () {

                    if (items[index] ==
                        "Children") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  const ChildrenScreen(),
                        ),
                      );
                    }

                    if (items[index] ==
                        "Attendance") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  const AttendanceScreen(),
                        ),
                      );
                    }

                    if (items[index] ==
                        "Activities") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  const ActivitiesScreen(),
                        ),
                      );
                    }

                    if (items[index] ==
                        "Fees") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  const FeesScreen(),
                        ),
                      );
                    }

                    if (items[index] == "Parents") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ParentsScreen(),
                        ),
                      );
                    }
                  },

                  child: Card(
                    elevation: 4,

                    child: Center(
                      child: Text(
                        items[index],

                        style:
                            const TextStyle(
                          fontSize:
                              18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      )
    );
  }
}