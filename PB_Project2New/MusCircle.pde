//represents a Music Triangle
public class MusCircle implements IMusShape {
  private float midptX;
  private float midptY;
  private int bandNum;
  private int bandStart;
  private int bandEnd;
  private color shapeColor;
  private float spectrumAvg;
  private float spectrumSum;
  
  public MusCircle(int midptX, int midptY) {
    this.midptX = midptX; //set midpoint at the given coordinates
    this.midptY = midptY; //set midpoint at the given coordinates
    this.bandNum = (int)random(20); //get random number between 0 and 20 to determine how many bands of the spectrum to average
    if (((int)midptY - bandNum/2) < 0) { //starting point is the y coordinate minus 1/2 of the number of bands, must be >= 0
      this.bandStart = 0;
    } else {
      this.bandStart = (int)midptY - bandNum/2;
    }
    if ((bandStart + bandNum/2) > 512) { //ending point is the y coordinate plus 1/2 of the number of bands, must be <= 512
      this.bandEnd = 512;
    } else {
      this.bandEnd = bandStart + bandNum/2;
    }
    this.shapeColor = randColor(); //randomize the color of the shape
  }
  
  public void drawShape(float[] spectrum) {
    spectrumSum = 0;
    for(int i = this.bandStart; i < this.bandEnd; i++){ //add up the magnitude of this circle's set of bands of the given spectrum
      spectrumSum += spectrum[i]*25; 
    }
    
    spectrumAvg = spectrumSum / bandNum; //get the average of this circle's set of bands of the given spectrum
    fill(this.shapeColor);
    ellipse(midptX, midptY, spectrumAvg, spectrumAvg); //draw a circle with a radius that is th average of this circle's set of bands of given spectrum
  }
}
