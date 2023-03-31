//Using cooked controls for now as to start simple and advance further and further.
// see https://ksp-kos.github.io/KOS/commands/flight/cooked.html#cooked




SET ALTITUDE_THRESHOLD TO 1000.0.
SET CRUISE_ALTITUDE TO 1100.0.

// Can we get BDArmory team status from this??

// PARAMETER target_list.

// LIST TARGETS IN target_list.


// for vessels in target_list {
//     if vessels:THRUST > 0 {
//         print("thrust is more then 0").

//     }
// }


FUNCTION lift_off {
    //TODO A more gradual liftoff would be benificial as not every plane will be able to take of like this.
    PRINT "Starting liftoff".
    STAGE.
    LOCK STEERING TO HEADING(90,0). 
    LOCK THROTTLE TO 1.
    UNTIL 
    SHIP:groundspeed > 150 
    OR 
    NOT SHIP:STATUS = "LANDED"
    OR
    NOT SHIP:STATUS = "PRELAUNCH"
    {  
        
        WAIT 0.001.  // This line is Vitally Important.
    }
    PRINT SHIP:STATUS.
    LOCK STEERING TO HEADING(90,45). 
    UNTIL SHIP:STATUS = "FLYING"{
        WAIT 0.001.  // This line is Vitally Important.
    }  
}


FUNCTION evade_terrain {
//TODO Enhance the evasion of terrain check what the velocity to the ground is and what our max thrust etc etc is.
  IF SHIP:ALTITUDE - BODY:GEOPOTENTIALALTITUDE(SHIP:GEOPOSITION:LATITUDE, SHIP:GEOPOSITION:LONGITUDE) < ALTITUDE_THRESHOLD 
   
  {
    LOCK STEERING TO HEADING(90,45). 
  }
}



FUNCTION cruise {
    //TODO should circle around the kerbin center
    // PRINT BODY:GEOPOTENTIALALTITUDE(SHIP:GEOPOSITION:LATITUDE, SHIP:GEOPOSITION:LONGITUDE).
    UNTIL SHIP:ALTITUDE > CRUISE_ALTITUDE {
        LOCK STEERING TO HEADING(120,45). 
    }
    //PRINT VCRS(SHIP:VELOCITY:ORBIT, BODY:POSITION).
    //LOCK STEERING TO VCRS(SHIP:VELOCITY:ORBIT, BODY:POSITION).
    PRINT HEADING(180,45):vector*10.

    // TODO don't call it the draw function all the time as this causes flicker.
    SET anArrow TO VECDRAW(
      V(0,0,0),
      HEADING(120,45):vector*10,
      RGB(1,0,0),
      "See the arrow?",
      1.0,
      TRUE,
      0.2,
      TRUE,
      TRUE
    ).
}




PRINT "Starting things".
lift_off().
PRINT "liftoff done".
PRINT SHIP:STATUS.
PRINT "DOING UNTIL".
UNTIL NOT SHIP:STATUS = "FLYING" { 
    //PRINT "evade".
    //evade_terrain().
    //PRINT "cruise".
    cruise().

    WAIT 0.001.  // This line is Vitally Important.
}

PRINT "TEST2".

// PRINT normVec.

// LOCK STEERING TO HEADING(90,45).
// LOCK THROTTLE TO 1.
// STAGE.
// WAIT UNTIL SHIP:ALTITUDE > 1000.
// // LOCK STEERING TO HEADING(120,30).


// LOCK normVec to VCRS(SHIP:BODY:POSITION,SHIP:VELOCITY:ORBIT).  // Cross-product these for a normal vector
// LOCK STEERING TO LOOKDIRUP( normVec, SHIP:BODY:POSITION).



