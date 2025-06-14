# Weather-App
# 🌦️ Weather App - Real-Time Forecast with Flutter

This is a fully functional, real-time **Weather Forecast App** built using **Flutter**, **OpenWeatherMap API**, and **Material UI** components. The app fetches live weather data for a specific location (currently Mumbai) and displays current conditions, hourly forecasts, and additional information like humidity, wind speed, and atmospheric pressure.

---

## 🚀 Features

- ✅ Real-time weather data via [OpenWeatherMap API](https://openweathermap.org/api)
- ✅ Displays:
  - Current temperature
  - Weather condition (with appropriate icon)
  - Humidity, Wind Speed, and Pressure
- ✅ Horizontally scrollable hourly forecast
- ✅ Clean, modern UI with Material Design
- ✅ Dynamic AppBar date display
- ✅ Error handling for API calls

---
## 📸 Screenshots

<img src="https://github.com/user-attachments/assets/618910fb-2d10-4027-a8a3-76a6f82afe28" alt="Current Weather" width="300" height="650"/>



---

## 🛠️ Tech Stack

- **Flutter** – UI SDK for crafting native interfaces
- **Dart** – Programming language for Flutter
- **HTTP** – For API requests
- **Intl** – For date and time formatting
- **Font Awesome Flutter** – Weather icons
- **OpenWeatherMap API** – Real-time weather data

---

### 🧠 How it Works
- The WeatherScreen widget initializes an API call to fetch 5-day/3-hour interval forecasts.
- It decodes and parses this data to extract:
    -> Current weather conditions
    -> Next 8 hourly forecasts
- It uses FutureBuilder to build the UI only after the data is loaded.
- Icons are chosen dynamically based on the weather condition.

 ### To-Do / Improvements
 - Add location selection for weather lookup

 - Allow theme switching (dark/light toggle)

 - Store user's last city using local storage

 - Add unit toggle (°C ↔ °F)




