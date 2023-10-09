void trianglemesh(int gridsize){

  mesh1 = createShape();
  mesh1.beginShape(TRIANGLES);

for(int i = 0; i < gridsize; i++) {
    for(int j = 0; j < gridsize; j++) {
      float x0 = j * width / gridsize;
      float x1 = (j + 1) * width / gridsize;
      float y0 = i * height / gridsize;
      float y1 = (i + 1) * height / gridsize;
      
      float tex_x0 = j * 1.0 / gridsize;
      float tex_x1 = (j + 1) * 1.0 / gridsize;
      float tex_y0 = i * 1.0 / gridsize;
      float tex_y1 = (i + 1) * 1.0 / gridsize;

      // First triangle
      mesh1.vertex(x0, y0, tex_x0, tex_y0);
      mesh1.vertex(x1, y0, tex_x1, tex_y0);
      mesh1.vertex(x1, y1, tex_x1, tex_y1);

      // Second triangle
      mesh1.vertex(x1, y1, tex_x1, tex_y1);
      mesh1.vertex(x0, y1, tex_x0, tex_y1);
      mesh1.vertex(x0, y0, tex_x0, tex_y0);
    }
  }

  mesh1.endShape();
  vbo_mesh1 = mesh1;
  shape( mesh1 );
}
