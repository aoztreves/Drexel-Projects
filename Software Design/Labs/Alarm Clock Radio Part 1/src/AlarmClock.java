
public class AlarmClock extends Clock{
	
	
	public String alarmPast12;
	public int alarmHour;
	public int alarmMin;
	public int alarmSec;
	public boolean alarmOn =false;
	public int[] Alarm = new int[5];
	public String[] AlarmTZ = new String[1];
	
	
	
	public AlarmClock(){
	
	}
	public void turnoffAlarm(){
		alarmOn=false;
	}
	public void turnonAlarm(){
		alarmOn=true;
	}
	public AlarmClock(int aSec,int aMin, int aHour, String aPast12){
		setAlarm(aSec,aMin, aHour , aPast12);
	}
	public void showAlarm(){
		System.out.println( alarmHour + ":" + alarmMin);
	}
	public void checkAlarm(){
		if((alarmHour == hour) && (alarmMin == minutes)){
			alarmOn=true;
		}
		else{
			alarmOn=false;
		}
	}
	public void snooze(){
		System.out.println("Snooze was pressed!");
		setAlarm(alarmSec,(alarmMin+9),alarmHour,alarmPast12);
	}
	public void setAlarm(int aSec,int aMin,int aHour,String aPast12){
		if(aPast12 == "PM"){
			if(aHour > 12){
				alarmHour = aHour-12;
				aPast12 ="PM";
			}
			else{
				alarmHour = aHour;
				aPast12 ="PM";
			}
			
		}
		else{
			aPast12 = "AM";
			alarmHour = aHour;
		}
		if(aMin < 60 && aMin > 0){
			alarmMin = aMin;
		}
		else{
			alarmMin = 0;
		}
		if(aSec < 60 && aSec > 0){
			alarmSec = aSec;
		}
		else{
			alarmSec = 0;
		}
	}
	public void saveAlarm(){
		Alarm[0]=alarmSec;
		Alarm[1]=alarmMin;
		Alarm[2]=alarmHour;
		AlarmTZ[0]=alarmPast12;
	}
	public String getAlarmPast12() {
		return alarmPast12;
	}
	public void setAlarmPast12(String alarmPast12) {
		this.alarmPast12 = alarmPast12;
	}
	public int getAlarmHour() {
		return alarmHour;
	}
	public void setAlarmHour(int alarmHour) {
		this.alarmHour = alarmHour;
	}
	public int getAlarmMin() {
		return alarmMin;
	}
	public void setAlarmMin(int alarmMin) {
		this.alarmMin = alarmMin;
	}
	
}
