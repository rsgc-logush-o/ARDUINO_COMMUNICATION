import processing.serial.*;

//THE VALUE TO SEND AND THE ARRAY OF VALUES FOR THE DRAWING
boolean barGraph[];
int dataToSend;
Serial myPort; // THE SERIAL OBJECT

//THESE ARE FOR CHECKING IF IT NEEDS TO SEND THE DATA
int currMillis = 0;
int prevMillis = 0;
void setup()
{
  barGraph = new boolean[8];
  
  //SETTING UP AND FORMING A SERIAL CONNECTION
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n');
  println("YES");
  
  size(160, 60);
}

void draw()
{
  background(0);
  int dataBuffer = 0;//THE BUFFER TO HOLD THE DATA
  
  for(int j = 0; j < 8; j++)//THIS FORMS THE DATABUFFER FROM THE CLICKED RECTANGLES AND DISPLAYS THEM
  {
    
    if(barGraph[j] == true)
    {
    dataBuffer += pow(2,j);
    fill(0, 255, 0);
    
    }else fill(255);
   
    
    rect(20*j, 0, 20, 60);
   
    
  }
  dataToSend = dataBuffer; //SETTING THE DATA TO SEND AS THE DATA BUFFER
  currMillis = millis();
  
  if(currMillis - prevMillis > 1000)//HAPPENS ONCE EVERY SECOND AND IT SENDS DATA TO THE ARDUINO
  {
    myPort.write(dataToSend);
    println(dataToSend);
    prevMillis = millis();
  }
}

void mouseClicked()
{
  barGraph[(int)map(mouseX, 0, 160, 0, 8)] = true;//SETTING ANY CLICKED RECTANGLES TO TRUE
}

void keyPressed()
{
 for(int i = 0; i < 8; i++)//CLEARS THE DISPLAY IF ANYTHING IS CLICKED
 {
  barGraph[i] = false; 
 }
}