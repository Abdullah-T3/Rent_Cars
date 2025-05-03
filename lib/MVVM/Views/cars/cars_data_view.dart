import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Responsive/UiComponanets/InfoWidget.dart';
import '../../../widgets/myDrawer.dart';
import '../../Models/cars/cars_data_model.dart';
import '../../View Model/cars_data_view_model.dart';

class CarsDataView extends StatefulWidget {
  const CarsDataView({super.key});
  @override
  State<CarsDataView> createState() => _CarsDataViewState();
}

class _CarsDataViewState extends State<CarsDataView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch data from local cache first
      Provider.of<CarsViewModel>(context, listen: false).fetchLocalCars();
      // Then, try to fetch fresh data from the API
      if (Provider.of<CarsViewModel>(context, listen: false).cars.isEmpty) {
        Provider.of<CarsViewModel>(context, listen: false).fetchCars();
      }
    });
  }

  Widget buildTable(CarsViewModel carsDataViewModel) {
    return Infowidget(builder: (context, deviceInfo) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: deviceInfo.screenWidth,
              height: deviceInfo.screenHeight * 0.8,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: deviceInfo.screenWidth - 64,
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.grey.withOpacity(0.3),
                            dataTableTheme: DataTableThemeData(
                              headingTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              dataTextStyle: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.all(Colors.blue),
                            showBottomBorder: true,
                            headingRowHeight: 50,
                            dataRowHeight: 65,
                            horizontalMargin: 16,
                            columnSpacing: 24,
                            showCheckboxColumn: false,
                            dividerThickness: 1,
                            columns: <DataColumn>[
                              DataColumn(
                                  label: Text(S.of(context).car_license_plate)),
                              DataColumn(label: Text(S.of(context).brand)),
                              DataColumn(label: Text(S.of(context).model)),
                              DataColumn(
                                  label:
                                      Text(S.of(context).year_of_manufacture)),
                              DataColumn(
                                  label: Text(S.of(context).odometer_reading)),
                              DataColumn(
                                  label: Text(S.of(context).next_oil_change)),
                              DataColumn(label: Text(S.of(context).actions))
                            ],
                            rows: carsDataViewModel.cars.map<DataRow>((car) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(car.license_plate ?? 'N/A')),
                                  DataCell(Text(car.brand ?? 'N/A')),
                                  DataCell(Text(car.model ?? 'N/A')),
                                  DataCell(Text(
                                      car.yearOfManufacture?.toString() ??
                                          'N/A')),
                                  DataCell(Text(
                                      car.odometerReading?.toString() ??
                                          'N/A')),
                                  DataCell(Text(
                                      car.nextOilChange?.toString() ?? 'N/A')),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          child: IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            tooltip: S.of(context).edit,
                                            onPressed: () {
                                              _showEditDialog(context, car,
                                                  carsDataViewModel);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).cars),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search Cars',
              onPressed: () {
                // Implement search functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Search feature coming soon')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add Car',
              onPressed: () {
                Navigator.of(context).pushNamed('/add_car');
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Back to Home',
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
          ],
        ),
        drawer: const Mydrawer(),
        body: Consumer<CarsViewModel>(
          builder: (context, carsDataViewModel, child) {
            if (carsDataViewModel.isLoading) {
              return Center(
                child: Image.asset("assets/images/Progress.gif"),
              );
            }

            if (carsDataViewModel.errorMessage!.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (carsDataViewModel.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).check_internet),
                    ),
                  );
                }
              });

              if (carsDataViewModel.cars.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: deviceInfo.screenHeight * 0.15,
                              child: Image.asset("assets/images/no-wifi.png"),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              S.of(context).check_internet,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return buildTable(carsDataViewModel);
            }

            if (carsDataViewModel.cars.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.directions_car_outlined,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            'No Cars Found',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add a new car to get started',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: Text('Add Car'),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/add_car');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return buildTable(carsDataViewModel);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<CarsViewModel>(context, listen: false).fetchCars();
          },
          tooltip: 'Refresh',
          child: const Icon(Icons.refresh),
        ),
      );
    });
  }

  void _showEditDialog(
      BuildContext context, CarsDataModel car, CarsViewModel viewModel) {
    TextEditingController modelController =
        TextEditingController(text: car.model);
    TextEditingController yearController =
        TextEditingController(text: car.yearOfManufacture?.toString());
    TextEditingController odometerController =
        TextEditingController(text: car.odometerReading?.toString());
    TextEditingController nextOilChangeController =
        TextEditingController(text: car.nextOilChange?.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).edit),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                TextField(
                  controller: modelController,
                  decoration: InputDecoration(
                    labelText: S.of(context).model,
                    prefixIcon:
                        const Icon(Icons.directions_car, color: Colors.blue),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(
                    labelText: S.of(context).year_of_manufacture,
                    prefixIcon:
                        const Icon(Icons.date_range, color: Colors.blue),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: odometerController,
                  decoration: InputDecoration(
                    labelText: S.of(context).odometer_reading,
                    prefixIcon: const Icon(Icons.speed, color: Colors.blue),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nextOilChangeController,
                  decoration: InputDecoration(
                    labelText: S.of(context).next_oil_change,
                    prefixIcon:
                        const Icon(Icons.oil_barrel, color: Colors.blue),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text(S.of(context).cancel,
                  style: const TextStyle(fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () {
                // Update the car data
                car.model = modelController.text;
                car.yearOfManufacture = int.tryParse(yearController.text);
                car.odometerReading = int.tryParse(odometerController.text);
                car.nextOilChange = int.tryParse(nextOilChangeController.text);

                // Send the updated data to the ViewModel
                viewModel.updateCar(car).then((_) {
                  viewModel.fetchCars();
                }).catchError((error) {
                  // Handle any errors if the update fails
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Failed to update car data: $error')),
                  );
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: Text(S.of(context).save,
                  style: const TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
}
