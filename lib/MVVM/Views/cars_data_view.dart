import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Responsive/UiComponanets/InfoWidget.dart';
import '../../widgets/myDrawer.dart';
import '../Models/cars_data_model.dart';
import '../View Model/cars_data_view_model.dart';

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
      if(Provider.of<CarsViewModel>(context, listen: false).cars.isEmpty) {
              Provider.of<CarsViewModel>(context, listen: false).fetchCars();
      }
    });
  }

Widget buildTable(CarsViewModel carsDataViewModel) {
  return Infowidget(builder: (context, deviceInfo) {
    return SizedBox(
      width: deviceInfo.screenWidth,
      height: deviceInfo.screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Plate Number')),
              DataColumn(label: Text('Brand')),
              DataColumn(label: Text('Model')),
              DataColumn(label: Text('Year of Manufacture')),
              DataColumn(label: Text('Odometer Reading')),
              DataColumn(label: Text('Next Oil Change')),
              DataColumn(label: Text('Actions')),
            ],
            rows: carsDataViewModel.cars.map<DataRow>((car) { // Explicitly cast to DataRow
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(car.license_plate ?? 'N/A')),
                  DataCell(Text(car.brand ?? 'N/A')),
                  DataCell(Text(car.model ?? 'N/A')),
                  DataCell(Text(car.yearOfManufacture?.toString() ?? 'N/A')),
                  DataCell(Text(car.odometerReading?.toString() ?? 'N/A')),
                  DataCell(Text(car.nextOilChange?.toString() ?? 'N/A')),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(context, car, carsDataViewModel);
                      },
                    ),
                  ),
                ],
              );
            }).toList(), // Ensure this converts to List<DataRow>
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
          title: const Text('Cars List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
          ],
        ),
        drawer: const Mydrawer(),
        body: Center(
          child: Consumer<CarsViewModel>(
            builder: (context, carsDataViewModel, child) {
              if (carsDataViewModel.isLoading) {
                return Image.asset("assets/images/Progress.gif");
              }
              if (carsDataViewModel.errorMessage!.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (carsDataViewModel.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Check your internet connection")),
                    );
                  }
                });
                // Return an error indicator or empty widget
                return carsDataViewModel.cars.isEmpty ?  SizedBox(
                  height: deviceInfo.screenHeight * 0.2,
                  width: deviceInfo.screenWidth * 0.2,
                  child: Image.asset("assets/images/no-wifi.png"),
                ): buildTable(carsDataViewModel);
              }
              return buildTable(carsDataViewModel);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<CarsViewModel>(context, listen: false).fetchCars();
          },
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
          title: const Text('Edit Car Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: modelController,
                  decoration: const InputDecoration(labelText: 'Model'),
                ),
                TextField(
                  controller: yearController,
                  decoration:
                      const InputDecoration(labelText: 'Year of Manufacture'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: odometerController,
                  decoration:
                      const InputDecoration(labelText: 'Odometer Reading'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nextOilChangeController,
                  decoration:
                      const InputDecoration(labelText: 'Next Oil Change'),
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the car data
                car.model = modelController.text;
                car.yearOfManufacture = int.tryParse(yearController.text);
                car.odometerReading = int.tryParse(odometerController.text);
                car.nextOilChange = int.tryParse(nextOilChangeController.text);

                // Send the updated data to the ViewModel
                viewModel.updateCar(car).then((_) {
                  // Optionally refresh the car list
                  viewModel.fetchCars();
                }).catchError((error) {
                  // Handle any errors if the update fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Failed to update car data: $error')),
                  );
                });

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
