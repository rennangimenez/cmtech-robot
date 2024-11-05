from datetime import datetime, timedelta
import pytz

def get_time_plus_hours(hours_to_add):
    hours_to_add = int(hours_to_add)
    current_time = datetime.utcnow()
    next_day = current_time + timedelta(days=1)
    start_time = datetime(next_day.year, next_day.month, next_day.day, 7, 0, 0)
    time_plus_hours = start_time + timedelta(hours=hours_to_add)
    tz = pytz.timezone('America/Sao_Paulo')
    time_with_timezone = tz.localize(time_plus_hours)
    formatted_time = time_with_timezone.strftime("%Y-%m-%dT%H:%M:%S%z")
    formatted_time = formatted_time[:-2] + ':' + formatted_time[-2:]
    return formatted_time

def get_date_and_time(hours_to_add):
    hours_to_add = int(hours_to_add)
    current_time = datetime.utcnow()
    next_day = current_time + timedelta(days=1)
    start_time = datetime(next_day.year, next_day.month, next_day.day, 7, 0, 0)
    time_plus_hours = start_time + timedelta(hours=hours_to_add)
    tz = pytz.timezone('America/Sao_Paulo')
    time_with_timezone = tz.localize(time_plus_hours)
    formatted_date = time_with_timezone.strftime("%d-%m-%Y")
    formatted_time = time_with_timezone.strftime("%H:%M:%S")
    return {
        "data": formatted_date,
        "horario": formatted_time
    }
