import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/Screens/Home%20Screen/homeScreen_viewModel.dart';
import 'package:weather_app/utilis/app_colors.dart';
import 'package:weather_app/widgets/custom_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.getCurrentWeather("Karachi");
        viewModel.getHourlyWeather("Karachi");
        viewModel.getWeekWeather("Karachi");
      },
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        Map weatherData = viewModel.currentWeatherData;
        int celsiusWeather = ((weatherData["main"]?["temp"] ?? 273) - 273).toInt();
        String humidity = (weatherData["main"]?["humidity"] ?? 0.0).toString();
        String wind = (weatherData["wind"]?["speed"] ?? 0.0).toString();
        String precipitation = (weatherData["rain"]?["1h"] ?? 0.0).toString();
        String cloudlines = weatherData["weather"]?[0]["main"] ?? "Clear";
        String animation = viewModel.animation(cloudlines);

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3A0CA3), // Dark Purple
                  Color(0xFF7209B7), // Medium-Dark Purple
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16),
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          TextField(
                            style: TextStyle(color: AppColors.white),
                            controller: viewModel.citySearch,
                            decoration: InputDecoration(
                              label: Text("Enter City Name", style: TextStyle(color: AppColors.white)),
                              prefixIcon: Icon(Icons.location_on, color: Colors.red[900]),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  viewModel.getCurrentWeather(viewModel.citySearch.text);
                                  viewModel.getHourlyWeather(viewModel.citySearch.text);
                                  viewModel.getWeekWeather(viewModel.citySearch.text);

                                  viewModel.citySearch.clear();
                                },
                                icon: Icon(Icons.search, color: AppColors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          viewModel.iscurrentWeatherData
                              ? Center(child: CircularProgressIndicator())
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${weatherData["name"]}", style: TextStyle(color: AppColors.white, fontSize: 30)),
                                    SizedBox(height: 10),
                                    Text("Current Weather", style: TextStyle(color: AppColors.lightgrey, fontSize: 15)),
                                    SizedBox(height: 10),
                                    Center(
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Lottie.asset("$animation"),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Center(
                                      child: Text(
                                        "${celsiusWeather}°C".toString(),
                                        style: TextStyle(color: AppColors.white, fontSize: 55, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Center(child: Text(cloudlines, style: TextStyle(color: AppColors.lightgrey, fontSize: 20))),
                                  ],
                                ),
                          SizedBox(height: 20),

                          //Additional Information:----------------------------------------------------------------------
                          Text("Additional Information", style: TextStyle(color: AppColors.white, fontSize: 22,fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AddtionalInformationContainer(customIcon: Icons.water_drop_outlined, customText: "Humidity", customResult: "$humidity%"),
                                AddtionalInformationContainer(customIcon: Icons.air_outlined, customText: "Wind Speed", customResult: "$wind km/h"),
                                AddtionalInformationContainer(customIcon: FontAwesomeIcons.cloudRain, customText: "Precipitation", customResult: "$precipitation mm"),
                              ],
                            ),
                          ),

                          SizedBox(height: 30),

                          //Hourly Forcast:----------------------------------------------------------------------
                          Text("Hourly Forcast", style: TextStyle(color: AppColors.white, fontSize: 22,fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),

                          viewModel.ishourlyWeatherData ? Center(child: CircularProgressIndicator()) :
                          Container(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.hourlyWeatherData['forecast']['forecastday'][0]['hour'].length,
                              itemBuilder: (context, index){
                                final hourData = viewModel.hourlyWeatherData['forecast']['forecastday'][0]['hour'][index];
                                final time = viewModel.formatTime(hourData['time']);
                                final iconUrl = 'https:${hourData['condition']['icon']}'; // Fetch icon URL
                                final temperature = hourData['temp_c'];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0), // Inner padding
                                    decoration: BoxDecoration(
                                      color: Color(0xFF6A4C93), // Complementary color to your gradient
                                      borderRadius: BorderRadius.circular(12), // Rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2), // Soft shadow
                                          blurRadius: 8,
                                          offset: Offset(4, 4), // Offset for depth
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                        children: [
                                          Text('$time',style: TextStyle(color: AppColors.white,)),
                                          SizedBox(height: 3,),
                                          Image.network(iconUrl),
                                          SizedBox(height: 3,),
                                          Text('$temperature°C',style: TextStyle(color: AppColors.white,)),
                                  
                                        ],
                                      ),
                                  
                                  ),
                                );
                        })  ,
                          ),
                          SizedBox(height: 30),

                          //7 Days Forcast:----------------------------------------------------------------------
                          Text("7 Days Forcast", style: TextStyle(color: AppColors.white, fontSize: 22,fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),

                          viewModel.isweeklyWeatherData ? Center(child: CircularProgressIndicator()) :
                          
                          Container(
                            height: 400,
                            child: ListView.builder(
                              //shrinkWrap: true,
                              //physics: NeverScrollableScrollPhysics(),
                              itemCount: viewModel.WeekWeatherData["forecast"]["forecastday"].length,
                              itemBuilder: (context, index){
                                final weekforecast = viewModel.WeekWeatherData["forecast"]["forecastday"][index];
                                final iconUrl = 'https:${weekforecast['day']['condition']['icon']}';
                                final maxTemp = weekforecast['day']['maxtemp_c'];
                                final minTemp = weekforecast['day']['mintemp_c'];
                                final date = viewModel.formatDate(weekforecast['date']);
                                final dayName = DateFormat('EEEE').format(DateTime.parse(weekforecast['date']));

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF6A4C93), // Container background color
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(16.0), // Inner padding
                                      leading: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dayName, // Day (e.g., Monday)
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 14,
                                              
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            date, 
                                            style: TextStyle(
                                              color: AppColors.lightgrey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                        title: 
                                        Center(
                                          child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
                                                 crossAxisAlignment: CrossAxisAlignment.start,                                          children: [
                                              Text(
                                                'Max Temp: $maxTemp°C', // Max temperature
                                                style: TextStyle(color: Colors.white, fontSize: 14),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Min Temp: $minTemp°C', // Min temperature
                                                style: TextStyle(color: Colors.white70, fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                    trailing: Image.network(
                                    iconUrl, // Weather icon
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.contain,
                                                                  ),
                                                          ),
                                  ),
                                );
                              }),
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
