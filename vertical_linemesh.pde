void verticalLineMesh(int gridsize) {
  int new_gridsize = gridsize * 2;
  mesh1 = createShape();
  mesh1.beginShape(LINES);
  
  mesh1.texture(cam);

  for( int i = 0; i < new_gridsize; i++ ){
      for( int j = 0; j < new_gridsize; j++ ){

        // shape
        float x0 = i * width / new_gridsize;
        float y0 = j * height / new_gridsize;
        float y1 = ( j + 1 ) * height / new_gridsize;
                
        // textures
        float tx0 = i * cam.width / new_gridsize;
        float ty0 = j * cam.height / new_gridsize;
        float ty1 = (j + 1) * cam.height / new_gridsize;

        mesh1.vertex( x0, y0, tx0, ty0 );
        mesh1.vertex( x0, y1, tx0, ty1 );
          
      } // endxfor
  } // endyfor

  mesh1.endShape();
  vbo_mesh1 = mesh1;
  shape( mesh1 );
}
