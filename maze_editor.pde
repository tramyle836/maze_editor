/**
 *    drag to erase Wall <br />
 *    press SPACE and drag to draw wall again <br />
 *    works by standard Processing. <br />
 *
 *    <form id="form-form"><!-- empty --></form>
 *    <!-- the following css adds a tiny bit of layout -->
 *    <style>textarea,input,label,select{display:block;width:95%}select{width:97.5%}
 *    input[type=checkbox],input[type=radio]{width: auto}textarea{height:5em}</style>
 */

//korekara
// auto centering maze
// start and goal marker
// generate mazes
// export strictly
// 


//maze setup
Maze maze;
String[][] menuItems;

// dafault input values
int currentMaze = 0;
int Dmazex = 6;
int Dmazey = 6;
int mazeCellsDefault = 80;

int DwallWidth = 5;
int DfloorWidth = 30;

int drawMode = 1;


// export options
String mazeName = "alpha";
int madeDate = 160000;



//迷路位置
public int mazeoffset = 30;
public int mazeoffsetx = 30;
public int mazeoffsety = 30;


void setup(){
  size(600, 600);
  frameRate(20);
  maze = new Maze(Dmazex,Dmazey,DwallWidth,DfloorWidth);
  uiSetup();
  maze.refresh();
}

void draw(){
  maze.refresh();

  // draw maze
  if (keyPressed == true)  fill(0,80);
  else fill(200,80);
  ellipse(mouseX,mouseY,30,30);
}

boolean RectOver( int x, int y, int w,int h){
  //mouseover on rect?
  if (mouseX >= x && mouseX <= x+w &&
    mouseY >= y && mouseY <= y+h) {
      return true;
      } else {
        return false;
      }
    }



void mouseDragged(){
 //edit maze
  if (keyPressed == true) maze.editMaze(0, mouseX, mouseY);
  else maze.editMaze(1, mouseX, mouseY);
}



void MazeSetup(int n,int m){
  //aim get maze size n, make 2n + 1 wall Array and n floor Arr.
  maze = new Maze(n,m);
  maze.refresh();
}


class Maze{

  //grid size
  int x;
  int y;

  //widths
  int wallwidth;
  int floorwidth;

  //wall var
  static final int WALL = 0;
  static final int FLOOR = 1;

  int cell[][];


  Maze(int x,int y, int ww, int fw){
    //init cells
    this.x = x;
    this.y = y;
    this.cell = new int[2 * mazeCellsDefault + 1 ][2 * mazeCellsDefault + 1];
    for (int i = 0; i < 2 * mazeCellsDefault + 1 ; i++){
      for(int j = 0; j < 2 * mazeCellsDefault + 1 ; j++){
        if(i % 2 == 0) cell[i][j] = WALL;
        else if (j % 2 == 0) cell[i][j] = WALL;
        else cell[i][j] = FLOOR;
      }
    }

  //init widths
  this.wallwidth = ww;
  this.floorwidth = fw;

  }


  void refresh(){
    //refresh All
    noStroke();
    fill(255);
    rect(0,0,width,height);

    //draw maze
    int tmpw,tmph,posx,posy;
    tmpw = 0;
    tmph = 0;
    posx = mazeoffset;
    posy = mazeoffset;
    for(int j = 0; j < 2 * y + 1 ; j++){
      for (int i = 0; i < 2 * x + 1 ; i++){

        if (i == 1 && j == 2){println("beforerect"+ posx +"," + posy +","+ tmpw +","+ tmph);}

        //val wakk
        if(j % 2 == 0) tmph = int(this.wallwidth);
        else tmph = int(this.floorwidth);

        //col wall
        if (i % 2 == 0) tmpw = int(this.wallwidth);
        else tmpw = int(this.floorwidth);

        //wall? floor? other?
        if (cell[i][j] == WALL) fill(0);
        else noFill();
        if (i == 1 && j == 2){println("rect"+ posx +"," + posy +","+ tmpw +","+ tmph);}
        rect(posx,posy,tmpw,tmph);
        posx += tmpw;
      }
      posx = mazeoffset;
      posy += tmph;
    }
  }


  void editMaze(int mousestate,float mouseX,float mouseY){
    //save cell num
    int numx,numy;
    //get mousePos and return cellnum
    numx = cellNumber(mouseX);
    numy = cellNumber(mouseY);

    if (numx < 0 || numx > 2 * x + 1) return;
    if (numy < 0 || numy > 2 * y + 1) return;
    if ( ( numx + numy )% 2 == 1) {
      cell[numx][numy] = mousestate;
      refresh();
      println("mouse is now "+ numx + "," + numy + "cell ,it becomes" + mousestate);

        }

  }

  //get position return cellnumber
  int cellNumber(float pos){
    pos -= int(mazeoffset);
    int num;
    int t;
    int k; // atari hantei supporter

    int w = int(this.wallwidth);
    int f = int(this.floorwidth);
    if ( w < 5 ) k = int(5 - w);

    t =floor( pos  / (w + f));

      if (pos > t * (w + f) + w + k)
        num = t * 2 + 1;
      else num = 2 * t ;

    return num;
  }

// UI options
  void xCallback(int value){
    this.x = value ;
  }
  void yCallback(int value){
    this.y = value ;
  }
  void wwCallback(int value){
    this.wallwidth = value ;
  }
  void fwCallback(int value){
    this.floorwidth = value ;
  }


}
