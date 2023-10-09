void horizontalLineMesh(int gridsize) {
  int new_gridsize = gridsize * 2;
  mesh1 = createShape();
  mesh1.beginShape(LINES);
  mesh1.texture(cam); // Assuming you have a PImage named myTexture
  
  for(int i = 0; i < new_gridsize; i++) {
    for(int j = 0; j < new_gridsize; j++) {
      float x0 = j * width / (float)new_gridsize;
      float x1 = (j + 1) * width / (float)new_gridsize;
      float y0 = i * height / (float)new_gridsize;
      
      float texX0 = j / (float)new_gridsize;
      float texX1 = (j + 1) / (float)new_gridsize;
      float texY0 = i / (float)new_gridsize;

      mesh1.vertex(x0, y0, texX0, texY0);
      mesh1.vertex(x1, y0, texX1, texY0);
    }
  }
  mesh1.endShape();
  vbo_mesh1 = mesh1;
  shape( mesh1 );
}
