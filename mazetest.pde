//初期変数

public static final int FIELDSIZEX = 400;
public static final int FIELDSIZEY = 400;
PFont f,bignum , caption;


//画面の状態
public static final int BEFORE = 0;
public static final int EDIT = 1;
public static final int EXPORT = 2;
public int gameState = 0;

//迷路の用意
Maze maze;
public int mazex = 6;
public int mazey = 6;

//画面描画用変数
public static final int  COUNTERPOSX = 0;
public static final int  COUNTERDELTAX = 180;
public static final int  CCDX = 40;
public static final int  COUNTERPOSY = 200;

//フォントサイズ
public static final int  BIGFONTSIZE = 120;
public static final int  MIDFONTSIZE = 60;
public static final int  SMALLFONTSIZE = 20;

//迷路位置
public int mazeoffset = 30;



void setup(){
  size(800, 800);
  frameRate(25);

  f = createFont("Helvetica", MIDFONTSIZE);
  textFont(f);
  bignum = createFont("Helvetica", BIGFONTSIZE);
  caption = createFont("Helvetica", SMALLFONTSIZE);

}

void draw(){

  //maze = new Maze(1,1);


  switch (gameState){
    case  BEFORE :
      BeforeEdit();

    break;

    case  EDIT :
      maze.drawMaze();
      //drawController();
    break;

    case  EXPORT :
//    EndGame();
    noLoop();
    break;
  }
}

void BeforeEdit(){
  //画面にUIを表示し、迷路サイズmxnを表示する

  //画面の掃除
  noStroke();
  fill(250);
  rect(0, 0, width, height);

  //ボタン描画
  //スタートボタン
  stroke(30);
  noFill();
  rect(width / 2 - 200,height - 200, 400, 100);

  //+-ボタン
  fill(90,90,240);
  noStroke();
  rect(width/2 - COUNTERDELTAX - CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE);
  rect(width/2 - COUNTERDELTAX + CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE);
  rect(width/2 + COUNTERDELTAX - CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE);
  rect(width/2 + COUNTERDELTAX + CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE);

  //文字の描画
  //スタート
  fill(30);
  textFont(caption);
  text("作る迷路のサイズを決めてね",width / 2 - 180 ,60);

  textFont(f);
  text("start",width / 2 - 180 ,height - 120);

  //数字
  textFont(bignum);
  text(mazex,width / 2 - COUNTERDELTAX ,COUNTERPOSY);
  text(mazey,width / 2 + COUNTERDELTAX ,COUNTERPOSY);

  //記号
  textFont(f);
  text("x", width/2, COUNTERPOSY);

  fill(250);
  text("-", width/2 - COUNTERDELTAX - CCDX + MIDFONTSIZE/2, COUNTERPOSY + 80);
  text("+", width/2 - COUNTERDELTAX + CCDX + MIDFONTSIZE/2, COUNTERPOSY + 80);
  text("-", width/2 + COUNTERDELTAX - CCDX + MIDFONTSIZE/2, COUNTERPOSY + 80);
  text("+", width/2 + COUNTERDELTAX + CCDX + MIDFONTSIZE/2, COUNTERPOSY + 80);





//  text("チームのカズ  ▼"+ numberOfTeams+ " ▲",teanNumPos.x, teanNumPos.y+15);
//  text("イカのカズ　▼ "+ mazey + " ▲",ikaNumPos.x, ikaNumPos.y + 15);

}

boolean RectOver( int x, int y, int w,int h){
  //あるボタンの上にマウスが乗っているか返す
  if (mouseX >= x && mouseX <= x+w &&
    mouseY >= y && mouseY <= y+h) {
      return true;
      } else {
        return false;
      }
    }


    void mousePressed(){
      if(gameState == BEFORE){
        //スタートが押された
        if (RectOver(width / 2 - 200,height - 200, 400, 100) ) {
          MazeSetup(mazex,mazey);
        }
        if (RectOver(width/2 - COUNTERDELTAX - CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE)){
          if(mazex > 1)mazex--;
        }
        if(RectOver(width/2 - COUNTERDELTAX + CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE)){
          if(mazex < 50) mazex++;
        }
        if(RectOver(width/2 + COUNTERDELTAX - CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE)){
          if(mazey > 1)mazey--;
        }
        if(RectOver(width/2 + COUNTERDELTAX + CCDX + MIDFONTSIZE/4  , COUNTERPOSY + MIDFONTSIZE /2,MIDFONTSIZE,MIDFONTSIZE)){
          if(mazey < 50)mazey++;
        }
      }

    }
void mouseDragged(){
  if (gameState == EDIT){
    maze.editMaze(1);
    maze.drawMaze();
  }


}




void MazeSetup(int n,int m){
  //目的　迷路の大きさnをもらって、2n+1サイズの壁配列と、nサイズの床配列を作成する
  maze = new Maze(n,m);
  gameState = EDIT;
  maze.drawMaze();
}


class Maze{
  //迷路クラス

  //格子サイズ
  int x;
  int y;

  //各パーツの幅
  int wallwidth;
  int floorwidth;

  //壁の様子
  static final int WALL = 0;
  static final int FLOOR = 1;

  int cell[][];


  Maze(int x,int y){
    //セルの初期化
    this.x = x;
    this.y = y;
    this.cell = new int[2 * x + 1 ][2 * y + 1];
    for (int i = 0; i < 2 * x + 1 ; i++){
      for(int j = 0; j < 2 * y + 1 ; j++){
        if(i % 2 == 0) cell[i][j] = WALL;
        else if (j % 2 == 0) cell[i][j] = WALL;
        else cell[i][j] = FLOOR;
      }
    }

  //パーツの幅を変更
  wallwidth = 10;
  floorwidth = 30;

  }

  //迷路を描画する
  void drawMaze(){
    fill(255);
    rect(0,0,width,height);

    int w,h,posx,posy;
    w = 0;
    h = 0;
    posx = mazeoffset;
    posy = mazeoffset;
    for(int j = 0; j < 2 * y + 1 ; j++){
      for (int i = 0; i < 2 * x + 1 ; i++){
        //横壁判定
        if(j % 2 == 0) h = wallwidth;
        else h = floorwidth;
        //縦壁判定
        if (i % 2 == 0) w = wallwidth;
        else w = floorwidth;
        //壁か床かその他か？
        if (cell[i][j] == WALL) fill(0);
        else noFill();

        rect(posx,posy,w,h);
        posx += w;
      }
      posx = mazeoffset;
      posy += h;
    }
  }

  //迷路を編集する
  void editMaze(int mousestate){
    //セル番号を格納
    int numx,numy;
    //マウスの座標を所得し、対応する位置の壁を書いたり消したりする
    numx = cellNumber(mouseX);
    numy = cellNumber(mouseY);

    if (numx < 0 || numx > 2 * x + 1) return;
    if (numy < 0 || numy > 2 * y + 1) return;
    if ( ( numx + numy )% 2 == 1) cell[numx][numy] = mousestate;

  }

  //ある座標値が、どのセル番号に位置するか返す関数
  int cellNumber(int pos){
    pos -= mazeoffset;
    int num;
    int t;
    t = pos  / (wallwidth + floorwidth);

      if (pos > t * (wallwidth + floorwidth) + wallwidth)
        num = t * 2 + 1;
      else num = 2 * t ;

    return num;
  }



}
