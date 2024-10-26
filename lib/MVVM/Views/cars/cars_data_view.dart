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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: deviceInfo.screenWidth,
            ),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.blue),
              
              columns:  <DataColumn>[
                DataColumn(label: Text( S.of(context).car_license_plate),
                
                ),
                DataColumn(label: Text(S.of(context).brand)),
                DataColumn(label: Text(S.of(context).model)),
                DataColumn(label: Text(S.of(context).year_of_manufacture)),
                DataColumn(label: Text(S.of(context).odometer_reading)),
                DataColumn(label: Text(S.of(context).next_oil_change)),
                DataColumn(label: Text(S.of(context).actions))
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
      ),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title:  Text(S.of(context).cars),
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
                       SnackBar(
                          content: Text(S.of(context).check_internet),),
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
          title:  Text(S.of(context).edit),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: modelController,
                  decoration:  InputDecoration(labelText: S.of(context).model),
                ),
                TextField(
                  controller: yearController,
                  decoration:
                       InputDecoration(labelText: S.of(context).year_of_manufacture),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: odometerController,
                  decoration:
                       InputDecoration(labelText: S.of(context).odometer_reading),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nextOilChangeController,
                  decoration:
                       InputDecoration(labelText: S.of(context).next_oil_change),
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
              child:  Text(S.of(context).cancel),
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
              child:  Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }
}
