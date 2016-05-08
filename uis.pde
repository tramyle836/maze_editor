
void uiSetup(){

// set up UI items 
  menuItems = new String[] {
    new String[] {
      "ww001cebuMaze"
    }
    , new String[] {
      "ww000breakwallMaze"
    }
    , 
    new String[] {
      "ww000icetunnel"
    }
    , new String[] {
      "ww000icecave"
    }
  };

}

/* interface related things */

void setController ( Controller ctlr )
{
  // labels are supposed to be existing function names

  InterfaceElement element = ctlr.addSelection( "theMenu", menuItems);
  ctlr.setElementLabel( element, "Choose maze type" );


  InterfaceElement element = ctlr.addNumber( "mazexCallback", Dmazex);
  ctlr.setElementLabel( element, "mazeXnumber");

  InterfaceElement element = ctlr.addNumber( "mazeyCallback", Dmazey);
  ctlr.setElementLabel( element, "mazeYnumber" );

  InterfaceElement element = ctlr.addNumber( "mazewwCallback", DwallWidth);
  ctlr.setElementLabel( element, "wall width px" );

  InterfaceElement element = ctlr.addNumber( "mazefwCallback", DfloorWidth);
  ctlr.setElementLabel( element, "floor width px" );

  InterfaceElement element = ctlr.addCheckbox("exportButton");
  ctlr.setElementLabel( element, "export button" );  
 
  
}


/* callbacks */
void mazexCallback ( int value )
{
  maze.xCallback(value);
  Dmazex = value;

}
void mazeyCallback ( int value )
{
  maze.yCallback(value);
  Dmazey = value;
}
void mazewwCallback ( int value )
{
   maze.wwCallback(value);
   DwallWidth = value;
}
void mazefwCallback ( int value )
{
  maze.fwCallback(value);
  DfloorWidth = value;
}



void exportButton ()
{
//  println("push!");
  maze.refresh();
  save("file.png");

}


void theMenu ( String value )
{
  currentMaze = int(value);
}

/* ... and the interfaces */

/* explain InputElement to Processing */
interface InputElement
{
  String type;
  String id;
  Object value;
}

/* explain Controller to Processing */
interface Controller
{
  InputElement addRange ( String label, float initialValue, float minValue, float maxValue );
  void setLabel ( InputElement element, String label );
}

