import 'dart:io';

import 'package:floxi/core/utils/extentions/string_extentions.dart';
import 'package:floxi/models/bar_code_model.dart';
import 'package:floxi/models/dasboard_model.dart';
import 'package:floxi/screens/bar_code_screen.dart';
import 'package:floxi/screens/camera_screen.dart';
import 'package:floxi/screens/cart_screen.dart';
import 'package:floxi/screens/eco_points_screen.dart';
import 'package:floxi/screens/items_screen.dart';
import 'package:floxi/screens/profile_screen.dart';
import 'package:floxi/screens/widgets/auto_scroll_circular_indicator.dart';
import 'package:floxi/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = '/dashboard';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => Dashboard(),
    );
  }

  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  DashboardModel? dashboardModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    DashboardModel dashboardModel = await DashboardViewModel().getDashboardData();
    setState(() {
      this.dashboardModel = dashboardModel;
    });
  }

  // Example target emissions in kg CO2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(left: 10, top: 10, bottom: 5),

          child: ClipOval(child: Image.asset('assets/icons/floxi_icon.jpeg')),
        ),
        title: Text('Floxi'),
        elevation: 2,
        actions: [
          GestureDetector(
            onTap:
                () => setState(() {
                  _currentIndex = 3;
                }),
            child: Container(
              margin: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 241, 219, 185),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Text("🪙", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    "${dashboardModel == null ? "" : dashboardModel?.totalPoints ?? ""}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:isLoading?CircularProgressIndicator.adaptive(): SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.camera_alt),
            label: 'Camera',
            onTap: () async {
              final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
                Navigator.of(context).pushReplacementNamed(
                  CameraScreen.routeName,
                  arguments: CameraScreen(image: File(image.path)),
                );
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.qr_code_sharp),
            label: 'Bar Code',
            onTap: () async {
              String? res = await SimpleBarcodeScanner.scanBarcode(
                context,
                barcodeAppBar: const BarcodeAppBar(
                  appBarTitle: '',
                  centerTitle: false,
                  enableBackButton: true,
                  backButtonIcon: Icon(Icons.arrow_back_ios),
                ),
                isShowFlashIcon: false,
                delayMillis: 2000,
                cameraFace: CameraFace.back,
              );
              print(res);

              if (res != null) {
                setState(() {
                  isLoading = true;
                });
                var response = await DashboardViewModel().getBarCodeData(barcode: res);
                await showCustomBottomSheet(context, response);
                setState(() {
                  isLoading = false;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scan Failed')));
              }
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:
          dashboardModel == null
              ? Center(child: CircularProgressIndicator.adaptive())
              : IndexedStack(
                index: _currentIndex,
                children: [
                  // Your other pages here
                  Center(child: HomeScreen(dashboardModel: dashboardModel!, callback: _loadData,),),
                  Center(child: CartTab()),
                  Center(child: Text("Dummy Page")),
                  Center(child: WalletScreen(dashboardModel: dashboardModel!)),
                  Center(child: ProfileScreen(dashboardModel: dashboardModel!)),
                ],
              ), // Display the corresponding page
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Theme.of(context).colorScheme.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 3,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.shop),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(icon: SizedBox(), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.wallet),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showCustomBottomSheet(BuildContext context, BarCodeModel barCodeModel) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Product Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.network(
                              barCodeModel.imageUrl ?? "", // Replace with your product image URL
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                barCodeModel.productNameEn ?? "",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Emission Score: ${barCodeModel.brands}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Green Score: ${barCodeModel.ecoscore?.gradeOverall?.toUpperCase()}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Life Cycle Analysis Score: ${barCodeModel.ecoscore?.lifeCycleAnalysisScore ?? ""}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Maluses: ${barCodeModel.ecoscore?.lifeCycleAnalysisScore ?? ""}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Final Score: ${barCodeModel.ecoscore?.score}/100',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Impact Map',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: barCodeModel.ecoscore?.ecoImpact?.impactBreakdown?.length ?? 0,
                    itemBuilder: (context, index) {
                      double percent =
                          barCodeModel
                              .ecoscore
                              ?.ecoImpact
                              ?.impactBreakdown?[index]
                              .impactPercentage ??
                          0.0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Impact ${index + 1}: ${barCodeModel.ecoscore?.ecoImpact?.impactBreakdown?[index].stageName ?? ""}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 32,
                            lineHeight: 20.0,
                            percent: percent / 100,
                            backgroundColor: Colors.grey[300],
                            progressColor: Colors.grey[600],
                            barRadius: const Radius.circular(10),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Recommandations',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: barCodeModel.recommendations?.length ?? 0,
                    itemBuilder: (context, index) {
                      Recommendations recommendations = barCodeModel.recommendations![index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${recommendations.productName}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text('${recommendations.brand}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: getGradeColor(
                                  recommendations.ecoscoreGrade?.toUpperCase() ?? "",
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                '${recommendations.ecoscoreGrade?.toUpperCase()}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final DashboardModel dashboardModel;
  final Function callback;
  final double totalEmissions = 45.5; // Example total emissions in kg CO2
  final double targetEmissions = 100.0;
  const HomeScreen({super.key, required this.dashboardModel, required this.callback});
  Color getColor(double progress) {
    if (progress < 0.3) return Colors.green;
    if (progress < 0.6) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: RefreshIndicator(
        onRefresh: () async{
          callback();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('Carbon Emission Dashboard', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              // Circular progress indicator for carbon emissions
              AutoScrollCircularIndicator(dashboardModel: dashboardModel),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Total Carbon Emissions in Kg Co2",
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "EcoPoints",
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "*Earn EcoPoints by reducing your carbon footprint",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 20),
              // Activity list section
              Text(
                "Recent Activities",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dashboardModel.transactions?.length ?? 0,
                itemBuilder: (context, index) {
                  TransactionModel transactionModel = dashboardModel.transactions![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ItemsScreen.routeName,
                        arguments: ItemsScreen(itemModelList: transactionModel.items ?? []),
                      );
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      leading: getTransactionIcon(transactionModel.type ?? ""),
                      title: Text(
                        transactionModel.type?.capitalizeFirst() ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              'dd MMM, yyyy',
                            ).format(transactionModel.timestamp as DateTime),
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "*${transactionModel.suggestion ?? ""}",
                            style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "Co2: ${transactionModel.emissions?.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "+${transactionModel.points}",
                              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
