import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_model.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseService _productService =
      FirebaseService(collection: 'products');
  final CollectionReference _dashboardReference =
      FirebaseFirestore.instance.collection('dashboard');
  TooltipBehavior? _tooltipBehavior;

  late List<ProductModel> productData = [];

  @override
  void initState() {
    data = [
      _ChartData2('CHN', 12),
      _ChartData2('GER', 15),
      _ChartData2('RUS', 30),
      _ChartData2('BRZ', 6.4),
      _ChartData2('IND', 14)
    ];
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    getData();
  }

  void getData() {
    _productService.getProductList().then((value) {
      productData = value;
      setState(() {});
    });
  }

  DateTime date = DateTime(2022, 10, 11);
  bool isEnable = true;

  late List<_ChartData2> data;

  final List<ChartData> chartData = [
    ChartData('David', 25, Colors.orange),
    ChartData('Steve', 38, Colors.green),
    ChartData('Jack', 34, Colors.deepPurple),
    ChartData('Others', 52, Colors.redAccent)
  ];

  showModal(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Hola"),
          content: const Text("Este es el contenido"),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text("Aceptar"),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  showDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 220,
          color: Colors.white,
          child: CupertinoDatePicker(
            initialDateTime: date,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime dateTime) {
              // print(dateTime);
            },
          ),
        );
      },
    );
  }

  showModal2(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text("Cancelar"),
          ),
          title: const Text("Aquí va el titulo"),
          message: const Text(
              "Aqui va el mensaje que deses cuando te hayan entregado la mercaderia"),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {},
              child: const Text("Acción 1"),
            ),
            CupertinoActionSheetAction(
              onPressed: () {},
              child: const Text("Acción 2"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: COLOR_BRAND_PRIMARY,
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.15),
        middle: const Text(
          "Dashboard",
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(12.0),
      //     child: Column(
      //       children: [
      //         const SizedBox(
      //           height: 20.0,
      //         ),
      //         CupertinoButton(
      //           color: CupertinoColors.darkBackgroundGray,
      //           child: Text("Hola"),
      //           onPressed: () {},
      //         ),
      //         MaterialButton(
      //           color: Colors.deepPurple,
      //           textColor: Colors.white,
      //           child: Text("Hola Material!"),
      //           onPressed: () {},
      //         ),
      //         // CircularProgressIndicator(),
      //         const SizedBox(
      //           height: 12.0,
      //         ),
      //         //CupertinoActivityIndicator(),
      //         const CupertinoTextField(
      //           prefix: Icon(Icons.add),
      //         ),
      //         const SizedBox(
      //           height: 12.0,
      //         ),
      //         const CupertinoSearchTextField(),
      // CupertinoSwitch(
      //     value: isEnable,
      //     onChanged: (value) {
      //       value = !isEnable;
      //       setState(() {});
      //     }),
      //         const SizedBox(
      //           height: 12.0,
      //         ),
      //         CupertinoButton(
      //           color: CupertinoColors.activeBlue,
      //           child: Text("Show"),
      //           onPressed: () {
      //             showModal(context);
      //           },
      //         ),
      //         const SizedBox(
      //           height: 12.0,
      //         ),
      //         CupertinoButton(
      //           color: CupertinoColors.activeBlue,
      //           child: Text("Show Date"),
      //           onPressed: () {
      //             showDate(context);
      //           },
      //         ),
      //         const SizedBox(
      //           height: 12.0,
      //         ),
      //         CupertinoButton(
      //           color: CupertinoColors.activeBlue,
      //           child: Text("Show Action"),
      //           onPressed: () {
      //             showModal2(context);
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                child: SfCartesianChart(
                  title: ChartTitle(
                    text: "Título",
                  ),
                  //backgroundColor: Colors.deepPurple,
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<SalesData, String>>[
                    LineSeries(
                        dataSource: <SalesData>[
                          SalesData('Jan', 35),
                          SalesData('Feb', 20),
                          SalesData('Mar', 34),
                          SalesData('Apr', 32),
                          SalesData('May', 40),
                          SalesData('Jun', 55),
                          SalesData('Jul', 18),
                          SalesData('Ago', 20),
                          SalesData('Set', 70),
                          SalesData('Oct', 26),
                          SalesData('Nov', 60),
                          SalesData('Dic', 10),
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales),
                  ],
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Half yearly sales analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: _tooltipBehavior,
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                      dataSource: <SalesData>[
                        SalesData('Jan', 35),
                        SalesData('Feb', 28),
                        SalesData('Mar', 34),
                        SalesData('Apr', 32),
                        SalesData('May', 40)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      color: Colors.deepPurple,
                    ),
                    LineSeries<SalesData, String>(
                      dataSource: <SalesData>[
                        SalesData('Jan', 15),
                        SalesData('Feb', 38),
                        SalesData('Mar', 44),
                        SalesData('Apr', 22),
                        SalesData('May', 18)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),

              const SizedBox(
                height: 20.0,
              ),

              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 40, interval: 10),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries<_ChartData2, String>>[
                  ColumnSeries<_ChartData2, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData2 data, _) => data.x,
                    yValueMapper: (_ChartData2 data, _) => data.y,
                    name: 'Gold',
                    color: Color.fromRGBO(8, 142, 255, 1),
                  ),
                  // ColumnSeries<_ChartData2, String>(
                  //   dataSource: data,
                  //   xValueMapper: (_ChartData2 data, _) => data.x,
                  //   yValueMapper: (_ChartData2 data, _) => data.y * 0.6,
                  //   name: 'Gold',
                  //   color: Colors.redAccent,
                  // ),
                ],
              ),

              const SizedBox(
                height: 20.0,
              ),

              const Text(
                "Probado con data Firebase",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Container(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis:
                      NumericAxis(minimum: 0, maximum: 40, interval: 10),
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries<ProductModel, String>>[
                    ColumnSeries<ProductModel, String>(
                      dataSource: productData,
                      xValueMapper: (ProductModel data, _) => data.description,
                      yValueMapper: (ProductModel data, _) => data.stockTotal,
                      name: 'Stock',
                      color: CupertinoColors.activeOrange,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              const Text(
                "Probado con data Dashboard de Firebase",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              StreamBuilder(
                stream: _dashboardReference.orderBy('description').snapshots(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    List<DashboardModel> dashboardData = [];
                    QuerySnapshot collection = snap.data;
                    collection.docs.forEach((element) {
                      DashboardModel dashboardModel = DashboardModel.fromJson(
                          element.data() as Map<String, dynamic>);
                      dashboardData.add(dashboardModel);
                    });

                    return Column(
                      children: [
                        Container(
                          child: SfCartesianChart(
                            tooltipBehavior: _tooltipBehavior,
                            title: ChartTitle(text: "Dashboard"),
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(
                                minimum: 0, maximum: 100, interval: 10),
                            series: <ChartSeries<DashboardModel, String>>[
                              ColumnSeries<DashboardModel, String>(
                                dataSource: dashboardData,
                                xValueMapper: (DashboardModel data, _) =>
                                    data.description,
                                yValueMapper: (DashboardModel data, _) =>
                                    data.value,
                                name: 'Ventas',
                                color: CupertinoColors.activeOrange,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: SfCircularChart(
                            title: ChartTitle(
                                text: "Grafico Pie - Ventas",
                                textStyle: const TextStyle(
                                  fontSize: 20.0,
                                )),
                            legend: Legend(
                              isVisible: true,
                              title: LegendTitle(text: "Legend"),
                            ),
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries>[
                              // Render pie chart
                              PieSeries<DashboardModel, String>(
                                dataSource: dashboardData,
                                // pointColorMapper: (DashboardModel data, _) => data.color,
                                xValueMapper: (DashboardModel data, _) =>
                                    data.description,
                                yValueMapper: (DashboardModel data, _) =>
                                    data.value,
                                // explode hacer que la tajada se separe
                                explode: true,
                                // First segment will be exploded on initial rendering
                                // explodeIndex: 2,
                                //explodeAll: true,
                                enableTooltip: true,
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  // return const Center(
                  //   child: CupertinoActivityIndicator(),
                  // );
                  return const Text("Cargando...");
                },
              ),
              Divider(
                indent: 30,
                endIndent: 30.0,
                color: Colors.black54.withOpacity(0.5),
              ),

              const SizedBox(
                height: 20.0,
              ),

              CupertinoSwitch(
                value: isEnable,
                onChanged: (value) {
                  isEnable = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              CupertinoButton(
                color: CupertinoColors.darkBackgroundGray,
                child: const Text("Hola"),
                onPressed: () {},
              ),
              MaterialButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: const Text("Hola Material!"),
                onPressed: () {},
              ),
              // CircularProgressIndicator(),
              const SizedBox(
                height: 12.0,
              ),
              //CupertinoActivityIndicator(),
              const CupertinoTextField(
                prefix: Icon(Icons.add),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const CupertinoSearchTextField(),

              const SizedBox(
                height: 12.0,
              ),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text("Show"),
                onPressed: () {
                  showModal(context);
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text("Show Date"),
                onPressed: () {
                  showDate(context);
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text("Show Action"),
                onPressed: () {
                  showModal2(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardModel {
  final String description;
  final double value;
  DashboardModel({
    required this.description,
    required this.value,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        description: json["description"],
        value: json["value"].toDouble(),
      );
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class _ChartData2 {
  _ChartData2(this.x, this.y);

  final String x;
  final double y;
}
