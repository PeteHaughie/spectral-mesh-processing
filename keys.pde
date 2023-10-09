void keyPressed() {
    if( key == 'a' ){ 
      az += 0.01;
    }
    if( key == 'z' ){
      az -= 0.01;
    }
    
    // zflo biz
    if( key == 's' ){
      sx += 0.0001;
    }
    if( key == 'x' ){
      sx -= 0.0001;
    }
    if( key == 'd' ){
      dc += 0.001;
    }
    if( key == 'c' ){
      dc -= 0.001;
    }
    if( key == 'f' ){
      fv += 0.001;
    }
    if( key == 'v' ){
      fv -= 0.001;
    }
    
    //ylfo biz
    if( key == 'g' ){
      gb += 0.001;
    }
    if( key == 'b' ){
      gb -= 0.001;
    }
    if( key == 'h' ){
      hn += 0.001;
    }
    if( key == 'n' ){
      hn -= 0.001;
    }
    if( key == 'j' ){
      jm += 0.1;
    }
    if( key == 'm' ){
      jm -= 0.1;
    }
    if( key == 'k' ){
      kk += 0.001;
    }
    if( key == ',' ){
      kk -= 0.001;
    }
    if( key == 'l' ){
      ll += 0.001;
    }
    if( key == '.' ){
      ll -= 0.001;
    }
    if( key == ';' ){
      yLfoAmp += 0.1;
    }
    if( key == '/' ){
      yLfoAmp -= 0.1;
    }
    
    if( key == 't' ){
      ty += 5;
    }
    if( key == 'y' ){
      ty -= 5;
    }
    
    if( key == 'u' ){
      ui += 5;
    }
    if( key == 'i' ){
      ui -= 5;
    }
    
    if( key == 'o' ){
      op += 5;
    }
    if( key == 'p' ){
      op -= 5;
    }
    
    if( key == 'e' ){
      er += 0.01;
    }
    if( key == 'r' ){
      er-=0.01;
    }

    if( key == 'q' ){
      qw += 0.01;
    }
    if( key == 'w' ){
      qw -= 0.01;
    }

    if( key ==']' ){
      scaleKey += 1;
    }
    if( key =='[' ){
      scaleKey -= 1;
    }    
    if( key == '1' ){
      lumaSwitch = !lumaSwitch;
      println("lumaSwitch: ", lumaSwitch);
    }
    if( key == '2' ){
      brightSwitch = !brightSwitch;
      println("brightSwitch: ", brightSwitch);
    }
    if( key == '3' ){
      invertSwitch = !invertSwitch;
      println("invertSwitch: ", invertSwitch);
    }
    if( key == '4' ){
      // ?
    }
    if( key == '5' ){
      BWSwitch = !BWSwitch;
      println("BWSwitch: ", BWSwitch);
    }
    
    if( key == '6' ){
      zLfoShape++;
      zLfoShape = zLfoShape % 4;
    }
    
    if( key == '7' ){
      xLfoShape++;
      xLfoShape = xLfoShape % 4;
    }
    
    if( key == '8' ){
      yLfoShape++;
      yLfoShape = yLfoShape % 4;
    }

    if( key == '9' ){
      verticalLinemesh( scale );
    }
    if( key == '0' ){
      horizontalLinemesh( scale );
    }
    if( key == '-' ){
      trianglemesh( scale );
      if( wireframeSwitch == true ){
        wireframeSwitch = false;
      }
    }
    if( key == '=' ){
      trianglemesh( scale );
      if( wireframeSwitch == false ){
        wireframeSwitch = true;
      }
    }
   
   // ring mod
   if( key == '!' ){
     zRingmodSwitch =! zRingmodSwitch;
   }
   if( key == '@' ){
     xRingmodSwitch =! xRingmodSwitch;
   }
   if( key == '#' ){
     yRingmodSwitch =! yRingmodSwitch;
   }
   if( key == '$' ){
     zPhasemodSwitch =! zPhasemodSwitch;
   }
   if( key == '%' ){
     xPhasemodSwitch =! xPhasemodSwitch;
   }
   if( key == '^' ){
     yPhasemodSwitch =! yPhasemodSwitch;
   }
  if (key == 'i') {
    invertValue = (invertValue == 1.0) ? 0.0 : 1.0;
    myShader.set("invert_switch", invertValue);
  }
}
