import { WeatherInterface } from './intefaces/weather.interface';

function translateWeather(weather: string): string {
  switch (weather) {
    case 'Clouds':
      return 'Nuageux';
    case 'Clear':
      return 'Dégagé';
    case 'Rain':
      return 'Pluvieux';
    case 'Snow':
      return 'Neigeux';
    case 'Drizzle':
      return 'Bruineux';
    case 'Thunderstorm':
      return 'Orageux';
    case 'Mist':
      return 'Brumeux';
    case 'Smoke':
      return 'Fumeux';
    case 'Haze':
      return 'Brumeux';
    case 'Dust':
      return 'Poussiéreux';
    case 'Fog':
      return 'Brumeux';
    case 'Sand':
      return 'Sableux';
    case 'Ash':
      return 'Cendreux';
    case 'Squall':
      return 'Rafaleux';
    case 'Tornado':
      return 'Tornade';
    default:
      return weather;
  }
}

export function createInterface(weather: any): WeatherInterface {
  return {
    type: translateWeather(weather.weather[0].main),
    description: weather.weather[0].description,
    localisation: weather.name,
    temperature: weather.main.temp,
  };
}
