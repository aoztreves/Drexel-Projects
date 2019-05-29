
public class AlarmClockRadio extends AlarmClock {

	public static void main(String[] args) {
				
		AlarmClock myClock = new AlarmClock();
		Radio radio = new Radio();
		
		myClock.setClock(30, 30, 11, "AM");
		myClock.setAlarm(10, 35, 11, "AM");
		myClock.saveAlarm();
		
		System.out.print("Initial time: " ); 
		myClock.showClock();
		
		System.out.print("Initial alarm: " );
		myClock.showAlarm();
				
		for(int i = 0;i<5;i++){
			
			System.out.print("Time: "); 			
			
			for(int seconds = myClock.second; seconds<60;seconds++){			
				myClock.tickseconds();
			}
			
			myClock.showClock();
			myClock.checkAlarm();
			
			if(myClock.alarmOn == true){
				System.out.print("Alarm went off at : ");
				myClock.showAlarm();
				radio.turnonRadio();
				radio.showChannel();
			}	
		}
		
		myClock.snooze();
		
		for( int j =0; j<9;j++){
			
			System.out.print("Time: "); 
			
			for(int seconds = myClock.second; seconds<60;seconds++){
				myClock.tickseconds();
			}
			myClock.showClock();
			myClock.checkAlarm();
			
			if(myClock.alarmOn == true){
				System.out.print("Alarm went off at : ");
				myClock.showAlarm();
				radio.turnonRadio();
				radio.showChannel();
			}
		}
		
		myClock.setAlarm(myClock.Alarm[0],myClock.Alarm[1] , myClock.Alarm[2], myClock.AlarmTZ[0]);
		System.out.print("Alarm Back to Normal : ");
		myClock.showAlarm();
		myClock.turnoffAlarm();
		
		System.out.println();
		System.out.println("Attributes of Radio :");
		radio.turnonRadio();
		radio.showChannel();
		radio.changeVolume(5);
		radio.turnoffRadio();	

	}
}
