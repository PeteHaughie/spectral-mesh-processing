void gridMeshStrip(int gridsize) {
  mesh1 = createShape();
  
  for( int i = 0; i < gridsize - 1; i++ ) {  // We go to gridsize-1 because we're dealing with pairs of rows
    mesh1.beginShape( TRIANGLE_STRIP );
    mesh1.texture( cam );  // Assuming you've loaded a texture into myTexture
    
    float y0 = i * height / gridsize;
    float y1 = ( i + 1 ) * height / gridsize;
    
    float texY0 = i * ( float ) cam.height / gridsize;
    float texY1 = ( i + 1 ) * ( float ) cam.height / gridsize;

    for( int j = 0; j < gridsize; j++ ) {
      float x0 = j * width / gridsize;
      float texX0 = j * ( float ) cam.width / gridsize;

      // Add vertices for the top and bottom of the current quad
      mesh1.vertex( x0, y0, texX0, texY0 );
      mesh1.vertex( x0, y1, texX0, texY1 );
    }
    mesh1.endShape();
  }

  vbo_mesh1 = mesh1;
  shape( mesh1 );
}
