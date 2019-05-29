
public class Clock {

	public int second;
	public int minutes;
	public int hour;
	public String past12;
	
	
	public Clock(){
		setClock(0,0,0,null);
	}
	public Clock(int second, int min, int hour, String past12){
		setClock( second, min, hour , past12);
	}
	public void showClock(){
		System.out.println( hour + ":" + minutes +":" + past12);
	}
	public void setClock( int sec, int min, int hr , String p12){
		if(p12 == "PM"){
			past12="PM";
			hour = hr-12;
		}
		else{
			
			past12="AM";
			hour = hr;
		}
		if(min < 60 && min > 0){
			minutes = min;
		}
		else{
			minutes = 0;
		}
		if(sec < 60 && sec > 0){
			second = sec;
		}
		else{
			second = 0;
		}
	}
	public void tickseconds(){
		second++;
		
		if(second > 59){
			second=0;
			tickminutes();
		}
		
	}
	public void tickminutes(){
		minutes++;
		if(minutes>59){
			minutes=0;
			tickhour();
		}
	}
	public void tickhour(){
		hour++;
		if(hour>11){
			past12="PM";
			hour=0;
		}
		else{
			past12="AM";
		}
	}
	public int getSecond() {
		return second;
	}
	public void setSecond(int second) {
		this.second = second;
	}
	public int getMinutes() {
		return minutes;
	}
	public void setMinutes(int minutes) {
		this.minutes = minutes;
	}
	public int getHour() {
		return hour;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public String isPast12() {
		return past12;
	}
	public void setPast12(String past12) {
		this.past12 = past12;
	}
	
	
}
