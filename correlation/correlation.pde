BufferedReader reader;
PrintWriter fileOutput;
FloatTable data;


int upperMargin = 75;
int lowerMargin = 50;
int rightMargin = 150;
int leftMargin = 150;
int year;
String currentFile = "1990.txt";
String yearTitle = "1990";

float minPop;
float maxPop;
float minUnemp;
float maxUnemp;

Integrator[] interpolators;
Integrator[] interpolators2;

void setup(){
  size (600,600);
  int year = 0;
 /* int rowCount = data.rowCount;
 interpolators = new Integrator[rowCount];
  for (int row = 0; row < rowCount; row++) {
    float initialValue = data.getFloat(row, 0);
    interpolators[row] = new Integrator(initialValue);
    interpolators[row].attraction = 0.1;  // Set lower than the default
  }
   interpolators2 = new Integrator[rowCount];
  for (int row = 0; row < rowCount; row++) {
    float initialValue = data.getFloat(row, 1);
    interpolators2[row] = new Integrator(initialValue);
    interpolators2[row].attraction = 0.1;  // Set lower than the default
  }*/
  data = new FloatTable(currentFile);
  setTable();

  fill(0);
  int rowCount = 16;
  interpolators = new Integrator[rowCount];
  interpolators2 = new Integrator[rowCount];
  for(int i=0;i<interpolators.length;i++) {
    float initialValue = data.getFloat(i, 0);
    interpolators[i] = new Integrator(initialValue);
    initialValue = data.getFloat(i, 1);
    interpolators2[i] = new Integrator(initialValue);
  }
  
  
}

void draw(){
  setTable();
  data = new FloatTable(currentFile);
    minPop = data.getColumnMin(0);
  maxPop = data.getColumnMax(0);
  minPop =minPop*.9;
  maxPop = maxPop*1.08;
  
  minUnemp = data.getColumnMin(1);
  maxUnemp = data.getColumnMax(1);
  minUnemp =minUnemp*.9;
  maxUnemp = maxUnemp*1.1;
   int rowCount = 16;
  for (int row = 0; row < rowCount; row++) {
    interpolators[row].target(data.getFloat(row, 0));
    interpolators2[row].target(data.getFloat(row, 1));
  }
  
  //int rowCount=16;
  background(180,225,190);
  strokeWeight(3);
  stroke(10,20,50);
  //draw lines

  for (int row = 0; row < rowCount; row++) {
    interpolators[row].update();
    interpolators2[row].update();
  }
  textSize(20);
  text(yearTitle,290,30);
  fill(150,100,100);
  line(leftMargin,upperMargin,leftMargin,height-lowerMargin);
  line(width -rightMargin,upperMargin,width-rightMargin,height-lowerMargin);
  fill(0);
  float y =0;
  int ordered[] = new int[0];
  
  //interpolators[row].value
    for(int i = 0;i<data.getRowCount();i++){
//      ordered = append(ordered,int(interpolators[i].value));
      ordered = append(ordered,int(data.getFloat(i,0)));
     // println(data.getFloat(i,0));
      ordered = sort(ordered);
    }
    for(int x = 0; x<ordered.length; x++){
    // float y = map(data.getFloat(i,0),minPop,maxPop,1,16);//population
      int posit = data.getRowIndexByPop(ordered[x]);
    
      y = y+30;
     
     //get a y that increases one at a time based on the order
      ellipse(leftMargin,height-lowerMargin-y+10,5,5);
      textSize(12);
      text(data.getRowName(posit),leftMargin-65,height-lowerMargin-y+15);
     // println(data.getRowName(i));
     // float y2 = map(data.getFloat(posit,1),minUnemp,maxUnemp,0,height-upperMargin-lowerMargin);//Unemp Rate
     float y2 = map(interpolators2[posit].value,minUnemp,maxUnemp,upperMargin+20,height-upperMargin-lowerMargin-20);//Unemp Rate
      ellipse(width-rightMargin,height-lowerMargin-y2,5,5);
           //text(int(data.getFloat(posit,1)),width-rightMargin+20,height-lowerMargin-y2+5);
      strokeWeight(2);
      line(leftMargin,height-lowerMargin-y+10,width-rightMargin,height-lowerMargin-y2);
    }
    textAlign(CENTER);
    textSize(20);
    text("Population",leftMargin,upperMargin-20);
    text("Unemployment Rate",width-rightMargin,upperMargin-20);
    
    textSize(12);
    text(int(maxPop)+"",leftMargin,upperMargin-5);
    text(int(minPop)+"",leftMargin,height-lowerMargin+20);
    text(int(maxUnemp)+"",width-rightMargin,upperMargin-5);
    text(int(minUnemp)+"",width-rightMargin,height-lowerMargin+20);
  

}

void mouseClicked() {
  if (year<10) {
    year = year+1;
  } else {
    year = 0;
  }
 /* int rowCount = 16;
  for (int row = 0; row < rowCount; row++) {
    interpolators[row].target(data.getFloat(row, 0));
    interpolators2[row].target(data.getFloat(row, 1));
  }*/
  
}

void setTable(){
  
   if(year ==0){
    currentFile = "1990.txt";
    yearTitle = "1990";
  }
  else if(year ==1){
    currentFile = "1991.txt";
    yearTitle = "1991";
  }
   else if(year ==2){
    currentFile = "1992.txt";
    yearTitle = "1992";
  }
   else if(year ==3){
    currentFile = "1993.txt";
    yearTitle = "1993";
  }
    else if(year ==4){
    currentFile = "1994.txt";
    yearTitle = "1994";
  }
   else if(year ==5){
    currentFile = "1995.txt";
    yearTitle = "1995";
  }
   else if(year ==6){
    currentFile = "1996.txt";
    yearTitle = "1996";
  }
   else if(year ==7){
    currentFile = "1997.txt";
    yearTitle = "1997";
  }
    else if(year ==8){
    currentFile = "1998.txt";
    yearTitle = "1998";
  }
   else if(year ==9){
    currentFile = "1999.txt";
    yearTitle = "1999";
  }
   else if(year ==10){
    currentFile = "2000.txt";
    yearTitle = "2000";
  }

}
