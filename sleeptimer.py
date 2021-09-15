import datetime
import time

OKBLUE = '\033[94m'
END = '\033[0m'

def to_text(hour, minutes, strf=f"{OKBLUE}%H:%M{END}"):
    t = datetime.time(hour=hour, minute=minutes)
    return t.strftime(strf)





def main(hour,minute):
    current = datetime.datetime.now()
    current_hour = current.strftime("%H")
    wakeup_time = datetime.time(hour=hour,minute=minute)
    dt = datetime.timedelta(minutes=90)
    if 0 <= int(current_hour) and int(current_hour) < 4:
        # We still want to wake up to day.
        # current date
        wakeup_date = current
        pass
    else:
        # Next day
        wakeup_date = current + datetime.timedelta(days=1)
        pass
    wakeup = datetime.datetime.combine(wakeup_date,wakeup_time)
    times = list(map(lambda x: wakeup - x*dt, [1,2,3,4,5,6,7,8]))
    print(f"To wake up at {hour}:{minute}, feeling refreshed:")
    for t in times:
        dsleep = wakeup - t
        dsec = time.gmtime(dsleep.total_seconds())
        dsleep_hour = dsec.tm_hour
        dsleep_minutes = dsec.tm_min
        if not dsec.tm_min == 0:
            fsleep = to_text(dsec.tm_hour, dsec.tm_min, strf=f"{OKBLUE}%H{END} hours and {OKBLUE}%M{END} minutes")
        else:
            fsleep = to_text(dsec.tm_hour, dsec.tm_min, strf=f"{OKBLUE}%H{END} hours")
        bedtime = to_text(t.hour,t.minute )
        print(f"Go to sleep at {bedtime} to sleep {fsleep}")


        # if dsec.tm_min == 0:
        #     print(f"Go to sleep at {OKBLUE}{t.hour}:{t.minute}{END} to sleep {dsec.tm_hour} hours")
        # else:
        #     print(f"Go to sleep at {OKBLUE}{t.hour}:{t.minute}{END} to sleep {dsec.tm_hour} hours and {dsec.tm_min} minutes")



if __name__ == '__main__':
    print("When do you wish to wake up?")
    res = input("Hour:minutes > ").split(":")
    main(int(res[0]),int(res[1]))
