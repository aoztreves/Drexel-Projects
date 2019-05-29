
public class Radio {
	public int volume;
	public boolean radioOn= false;
	public String channel = "Aslan's Channel 1060 AM";
	
	public Radio(){
		
	}
	public void turnoffRadio(){
		System.out.println("Radio is off!");
		radioOn=false;
	}
	public void turnonRadio(){
		//System.out.println("Radio is on!");
		radioOn=true;
	}
	public int changeVolume(int vol){
		if(radioOn == false){
			System.out.println("Please turn on the radio first");
		}
		else{
			System.out.println("Volume is: " + vol);
			volume = vol;
		}
		return volume;
	}
	public void showChannel(){
		if(radioOn == false){
			System.out.println("Please turn on the radio first");
		}
		else{
			System.out.println("Radio is playing: " + channel);	
		}
	}
	
}
