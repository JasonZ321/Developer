#include <GLUT/glut.h>    //include glut library (automatically includes gl and glu libraries)
#include <iostream>
using namespace std;
GLint gWinWidth = 512;
GLint gWinHeight = 512;
GLint main_window,sub_window1,sub_window2;
//set up states that are going to be used
void init()
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f); //set clear background colour
}

//fit display into window
void reshape1(int width, int height)
{
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(200, 0, 0, 160.0f); //left, right, bottom, top
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}
void reshape11(int width, int height)
{
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(200, 0, 0, 160.0f); //left, right, bottom, top
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}
void reshape12(int width, int height)
{
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(200, 0, 0, 160.0f); //left, right, bottom, top
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

//keep display the same, display part of the world
void reshape2(int width, int height)
{
    glViewport(0, height-gWinHeight, gWinWidth, gWinHeight);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0.0f, 200.0f, 0.0f, 160.0f); //left, right, bottom, top
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

//preserve shapes by making the viewport and world window have same aspect ratio
void reshape3(int width, int height)
{
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if(width <= height)
        gluOrtho2D(0.0f, 200.0f, 0.0f*(GLfloat)height/(GLfloat)width, 160.0f*(GLfloat)height/(GLfloat)width); //left, right, bottom, top
    else
        gluOrtho2D(0.0f*(GLfloat)width/(GLfloat)height, 200.0f*(GLfloat)width/(GLfloat)height, 0.0f, 160.0f); //left, right, bottom, top
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

//draw the scene here
void drawScene()
{
    glClear(GL_COLOR_BUFFER_BIT);  //clear the colour buffer to the colour previously set in glClearColor
    
    glColor3f(1.0f, 0.0f, 0.0f);   //set colour
    
    glBegin(GL_POLYGON);		     //set primitive type
    //define vertices
    glVertex2i(50, 40);
    glVertex2i(50, 120);
    glVertex2i(150, 120);
    glVertex2i(150, 40);
    glEnd();
    
    glFlush();
}
void drawScene1()
{
    glClear(GL_COLOR_BUFFER_BIT);
     glColor3f(1.0f, 1.0f, 0.0f);
    glBegin(GL_POINTS);		     //set primitive type
    //define vertices
    glVertex2i(20, 40);
    //glVertex2i(20, 20);
    //glVertex2i(40, 20);
    //glVertex2i(40, 40);
    glEnd();
    glFlush();
    
}
void drawScene2()
{
    glClear(GL_COLOR_BUFFER_BIT);
 glColor3f(1.0f,0.0f ,1.0f );
    glBegin(GL_POINTS);		     //set primitive type
    //define vertices
    glVertex2i(20, 40);
    /*glVertex2i(20, 20);
    glVertex2i(40, 20);
    glVertex2i(40, 40);*/
    
    glEnd();
    glFlush();
     glutSwapBuffers();
}
void main_display()
{
    glClearColor(1.0f, 1.0f, 1.0f,1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    glFlush();
    glutSwapBuffers();
}
int main(int argc, char* argv[])
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB);      //requests properties for the window (sets up the rendering context)
    glutInitWindowSize(gWinWidth, gWinHeight); //set window size in pixels
    glutInitWindowPosition(50, 100);           //set window position from top-left corner of display
   
     glutCreateWindow("Reshape");        //set window title
    	 init();				          //call function to setup states
    glutReshapeFunc(reshape3);          //register reshape callback function
    glutDisplayFunc(drawScene);	      //register display callback function
/*
    sub_window1 = glutCreateSubWindow(main_window, 0, 0, gWinWidth/2.0, gWinHeight/2.0);
    glutDisplayFunc(drawScene1);

    sub_window2 = glutCreateSubWindow(main_window, gWinWidth/2.0, 0, gWinWidth/2.0, gWinHeight/2.0);
     glutDisplayFunc(drawScene2);
    */
    //cout << "1" << endl;
    
    glutMainLoop();                     //enter event loop
}
