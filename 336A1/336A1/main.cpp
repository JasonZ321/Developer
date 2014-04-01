//
//  main.cpp
//  336A1
//
//  Created by Jason Zhou on 14-3-20.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#include <iostream>
#include <GLUT/GLUT.h>
#include <cmath>
#include <cctype>
using namespace std;
static const float WIN_HEIGHT = 600;
static const float WIN_WIDTH = 800;
static const float SUBWIN_EDGE = 20;    // blank between subwindows

static const float SUBWIN_HEIGHT = (WIN_HEIGHT - 3 * SUBWIN_EDGE)/2;
static const float SUBWIN_WIDTH = (WIN_WIDTH - 3 * SUBWIN_EDGE)/2;
/* zero point position of four subwindows   */
static const float LEFT_DOWN_ZERO_X = SUBWIN_EDGE,LEFT_DOWN_ZERO_Y = SUBWIN_EDGE * 2 + SUBWIN_HEIGHT;
static const float LEFT_UP_ZERO_X = SUBWIN_EDGE,LEFT_UP_ZERO_Y = SUBWIN_EDGE;
static const float RIGHT_DOWN_ZERO_X = SUBWIN_EDGE * 2 + SUBWIN_WIDTH,RIGHT_DOWN_ZERO_Y = SUBWIN_EDGE * 2 + SUBWIN_HEIGHT;
static const float RIGHT_UP_ZERO_X = SUBWIN_EDGE * 2 + SUBWIN_WIDTH,RIGHT_UP_ZERO_Y = SUBWIN_EDGE;
/*  color matrics, there are 13 colors, 4 for chart one, 2 for chart twp, 7 for chart three and four */
float rgb[13][3];

int zoo1[7],zoo2[7]; // values of two zoos
// main window and four subwindows
GLint gMainWindow,gLeftUpWindow,gLeftDownWindow,gRightUpWindow,gRightDownWindow;
// which zoo is selected, zoo one by default, which year is selected, 2005 by default.
int zooSelected = 1,yearSelected = 0;
/*
 * get a random float between 0 and 1
 */
float random_float()
{
    float random = ((float) rand()) / (float) RAND_MAX;
    float diff = 1.0;
    float r = random * diff;
    return r;
}

/*
 * refresh all color matrics
 */
void refresh_color()
{
    for(int i = 0;i<13;i++){
        float r = random_float(),g = random_float(),b = random_float();
        rgb[i][0] = r;
        rgb[i][1] = g;
        rgb[i][2] = b;
    }
}

/*
 * refresh all values of two zoos
 */
void refresh_value()
{
    for (int i = 0; i < 7; i++) {
        zoo1[i] = rand() % 500;
        zoo2[i] = rand() % 500;
    }
}
/*
 * initialize data
 */
void init()
{
    refresh_value();
    refresh_color();
}

/*
 * a function for display string with position and font
 */
void display_str(GLfloat x, GLfloat y, void* font, char* str)
{
    char* ptr;              //temp pointer to position in string
    
    glRasterPos2i(x, y);    //place raster position
    
    for(ptr = str; *ptr != '\0'; ptr++)
    {
        glutBitmapCharacter(font, *ptr); //draw bitmap character
    }
}


/*
 * reshape function for all four subwindows
 */

void reshape(int width,int height)
{
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0, width, 0, height);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}
/*
 * display function for main window
 */
void main_display()
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    glFlush();
    glutSwapBuffers();
}
/* these constans are used for the first two charts */
const float LEFT_BLANK = SUBWIN_WIDTH/12.0;
const float RIGHT_BLANK = LEFT_BLANK * 2;
const float UP_BLANK = SUBWIN_HEIGHT/18.0;
const float DOWN_BLANK = UP_BLANK * 2.0;
const float CHART_WIDTH = SUBWIN_WIDTH - LEFT_BLANK - RIGHT_BLANK;
const float CHART_HEIGHT = SUBWIN_HEIGHT - UP_BLANK - DOWN_BLANK;

// display function of first chart
void leftUp_display()
{
    
    
    
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    /* draw the frame of chart */
    glColor3f(0.0f, 0.0f, 0.0f);
    glBegin(GL_LINE_LOOP);
    glVertex2f(SUBWIN_WIDTH * 0.001, SUBWIN_HEIGHT * 0.001);
    glVertex2f(SUBWIN_WIDTH * 0.001,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999, SUBWIN_HEIGHT * 0.001);
    glEnd();
    
    
    float zero_point[] = {LEFT_BLANK,DOWN_BLANK};  // zero point of coordinate
    const float TUBER_X = SUBWIN_WIDTH/100.0;     // this is the mark on coordinate lines
    const float TUBER_Y = SUBWIN_HEIGHT/100.0;
    
    const float INTERVAL_X = CHART_WIDTH / 7.0;   // range of x line and y line
    const float INTERVAL_Y = CHART_HEIGHT / 10.0;
    
    /* hints is the instruction on the right side of chart */
    const float HINTS_LENGTH = RIGHT_BLANK / 3.0;
    /* two hints' position */
    const float HINTS1_X = LEFT_BLANK + CHART_WIDTH + RIGHT_BLANK/5.0,HINTS1_Y = UP_BLANK + CHART_HEIGHT/2.0 + INTERVAL_Y / 2.0;
    const float HINTS2_X = HINTS1_X,HINTS2_Y = UP_BLANK + CHART_HEIGHT/2.0 - INTERVAL_Y / 2.0;
    
    
    /* draw charts with black lines*/
    glPointSize(8.0f);
    glLineWidth(2.0f);
    glColor3f(0.0f, 0.0f, 0.0f);
    for (int i = 0; i < 11; i++) {
        glBegin(GL_LINES);
        glVertex2f(zero_point[0]- TUBER_X,zero_point[1] + i * INTERVAL_Y);
        glVertex2f(zero_point[0] + CHART_WIDTH, zero_point[1] + i * INTERVAL_Y);
        glEnd();
        
    }
    
    glBegin(GL_LINES);
    glVertex2f(zero_point[0], zero_point[1] - TUBER_Y);
    glVertex2f(zero_point[0], zero_point[1] + CHART_HEIGHT);
    glEnd();
    for (int i = 0;i<8;i++) {
        glBegin(GL_LINES);
        glVertex2f(zero_point[0] + i * INTERVAL_X,zero_point[1]);
        glVertex2f(zero_point[0] + i * INTERVAL_X,zero_point[1] - TUBER_Y);
        glEnd();
    }
    
    
    /* draw fold line of zoo1 */
    
    glColor3f(rgb[7][0], rgb[7][1], rgb[7][2]);
    
    for (int i = 1; i < 7; i++) {
        glBegin(GL_LINES);
        glVertex2f(zero_point[0] + INTERVAL_X / 2.0 + INTERVAL_X * (i-1), zero_point[1] + zoo1[i-1]/50.0 * INTERVAL_Y);
        glVertex2f(zero_point[0] + INTERVAL_X / 2.0 + INTERVAL_X * i, zero_point[1] + zoo1[i]/50.0 * INTERVAL_Y);
        glEnd();
        
    }
    
    // line of hint of zoo1
    glBegin(GL_LINES);
    glVertex2f(HINTS1_X, HINTS1_Y);
    glVertex2f(HINTS1_X + HINTS_LENGTH, HINTS1_Y);
    glEnd();
    
    // draw points of zoo1
    glColor3f(rgb[8][0], rgb[8][1], rgb[8][2]);
    
    for (int i = 0; i < 7; i++) {
        glBegin(GL_POINTS);
        glVertex2f(zero_point[0] + INTERVAL_X / 2.0 + INTERVAL_X * i, zero_point[1] + zoo1[i]/50.0 * INTERVAL_Y);
        glEnd();
    }
    // point of hint of zoo1
    glBegin(GL_POINTS);
    glVertex2f(HINTS1_X + HINTS_LENGTH/2, HINTS1_Y);
    glEnd();
    
    
    // draw fold line of zoo2
    glColor3f(rgb[9][0], rgb[9][1], rgb[9][2]);
    
    for (int i = 1; i < 7; i++) {
        glBegin(GL_LINES);
        glVertex2f(zero_point[0] + INTERVAL_X / 2.0 + INTERVAL_X * (i-1), zero_point[1] + zoo2[i-1]/50.0 * INTERVAL_Y);
        glVertex2f(zero_point[0] + INTERVAL_X / 2.0 + INTERVAL_X * i, zero_point[1] + zoo2[i]/50.0 * INTERVAL_Y);
        glEnd();
        
    }
    // line of hint of zoo2
    glBegin(GL_LINES);
    glVertex2f(HINTS2_X, HINTS2_Y);
    glVertex2f(HINTS2_X + HINTS_LENGTH, HINTS2_Y);
    glEnd();
    
    // points of zoo2
    glColor3f(rgb[10][0], rgb[10][1], rgb[10][2]);
    
    for (int i = 0; i< 7; i++) {
        glBegin(GL_POINTS);
        glVertex2f(zero_point[0] + INTERVAL_X / 2.0 + INTERVAL_X * i, zero_point[1] + zoo2[i]/50.0 * INTERVAL_Y);
        glEnd();
    }
    // point of hint of zoo2
    glBegin(GL_POINTS);
    glVertex2f(HINTS2_X + HINTS_LENGTH/2, HINTS2_Y);
    glEnd();
    
    
    
    // all text
    glColor3f(0.0f, 0.0f, 0.0f);
    char amounts[11][4] = {"0","50","100","150","200","250","300","350","400","450","500"};
    char years[7][5] = {"2005","2006","2007","2008","2009","2010","2011"};
    for(int i = 0;i<11;i++)
    {
        float text_left_blank = LEFT_BLANK /5.0;
        
        display_str(text_left_blank, zero_point[1] + INTERVAL_Y * i,GLUT_BITMAP_HELVETICA_10,amounts[i]);
        
    }
    
    for(int i = 0;i<7;i++)
    {
        float text_down_blank = DOWN_BLANK / 4.0;
        display_str(zero_point[0] + INTERVAL_X * (i + 0.3), text_down_blank,GLUT_BITMAP_HELVETICA_10,years[i]);
    }
    
    display_str(HINTS1_X + HINTS_LENGTH * 1.1, HINTS1_Y, GLUT_BITMAP_HELVETICA_10, "Zoo1");
    display_str(HINTS2_X + HINTS_LENGTH * 1.1, HINTS2_Y, GLUT_BITMAP_HELVETICA_10, "Zoo2");
    
    
    
    glFlush();
    glutSwapBuffers();
    glutPostRedisplay();
}

/* constants of two pie charts */
#define PI 3.1415926535897932384626433832795
const float HINTS_BEGIN_AT = SUBWIN_WIDTH/8.0 * 7.0;     // hint start position
const float CENTER_X = SUBWIN_WIDTH * 7.0 / 16.0;       //  center of circle
const float CENTER_Y = SUBWIN_HEIGHT / 2.0;
const float RADIUS = SUBWIN_HEIGHT / 3.0;
const float SEGMENTS = 9999;
/* draw one sector of pie */
void sector(float proportion,float start,float end)
{
    glBegin( GL_TRIANGLE_FAN );
    glVertex2f(CENTER_X, CENTER_Y);
    for( int n = start * SEGMENTS; n <= end * SEGMENTS; ++n ) {
        
        float const t = 2*PI*(float)n/(float)SEGMENTS;
        glVertex2f(CENTER_X + sin(t)*RADIUS, CENTER_Y + cos(t)*RADIUS);
    }
    glEnd();
}
/* the first pie chart */
void leftDown_display()
{
    
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT);
    /* draw frame subwindow*/
    glColor3f(0.0f, 0.0f, 0.0f);
    glBegin(GL_LINE_LOOP);
    glVertex2f(SUBWIN_WIDTH * 0.001, SUBWIN_HEIGHT * 0.001);
    glVertex2f(SUBWIN_WIDTH * 0.001,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999, SUBWIN_HEIGHT * 0.001);
    glEnd();
    
    // title
    display_str(SUBWIN_WIDTH * 0.4, SUBWIN_HEIGHT * 0.90, GLUT_BITMAP_HELVETICA_18, "Zoo1");
    char years[7][5] = {"2005","2006","2007","2008","2009","2010","2011"};
    
    // get sum of zoo1
    int sum = 0;
    for(int i = 0;i < 7;i++)
    {
        sum += zoo1[i];
    }
    // percent of different sectors
    float proportions[7];
    for (int i = 0; i < 7; i++) {
        proportions[i] = zoo1[i] / (float)sum;
        
    }
    float start = 0.0f;
    
    // hint's top position
    float const HINTS_DISTANCE = RADIUS / 4.0;
    glPointSize(8.0f);
    // draw the pie
    for (int i = 0; i < 7; i++) {
        glColor3f(rgb[i][0], rgb[i][1], rgb[i][2]);
        sector(proportions[i], start, start + proportions[i]);
        start += proportions[i];
        glBegin(GL_POINTS);
        glVertex2f(HINTS_BEGIN_AT, CENTER_Y + RADIUS - i * HINTS_DISTANCE);
        glEnd();
        glColor3f(0.0f, 0.0f,0.0f);
        display_str(HINTS_BEGIN_AT + 6.0f, CENTER_Y + RADIUS - i * HINTS_DISTANCE - 4.0f, GLUT_BITMAP_HELVETICA_10, years[i]);
    }
    glFlush();
    glutSwapBuffers();
    glutPostRedisplay();
}

// display function of second chart
void rightUp_display()
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    float zero_point[] = {LEFT_BLANK,DOWN_BLANK}; // zero point of coordinate
    const float TUBER_X = SUBWIN_WIDTH/100.0;
    const float TUBER_Y = SUBWIN_HEIGHT/100.0;
    
    const float INTERVAL_X = CHART_WIDTH / 5.0;
    const float INTERVAL_Y = CHART_HEIGHT / 7.0;
    
    
    const float HINTS1_X = LEFT_BLANK + CHART_WIDTH + RIGHT_BLANK/3.0,HINTS1_Y = UP_BLANK + CHART_HEIGHT/2.0 + INTERVAL_Y / 2.0;
    const float HINTS2_X = HINTS1_X,HINTS2_Y = UP_BLANK + CHART_HEIGHT/2.0 - INTERVAL_Y / 2.0;
    
    // draw frame
    glClear(GL_COLOR_BUFFER_BIT);
    glColor3f(0.0f, 0.0f, 0.0f);
    glBegin(GL_LINE_LOOP);
    glVertex2f(SUBWIN_WIDTH * 0.001, SUBWIN_HEIGHT * 0.001);
    glVertex2f(SUBWIN_WIDTH * 0.001,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999, SUBWIN_HEIGHT * 0.001);
    glEnd();
    
    // draw lines of charts
    for (int i = 0; i < 6; i++) {
        glBegin(GL_LINES);
        glVertex2f(zero_point[0] + i * INTERVAL_X, zero_point[1]);
        glVertex2f(zero_point[0] + i * INTERVAL_X, zero_point[1] + CHART_HEIGHT);
        glEnd();
    }
    
    glBegin(GL_LINES);
    glVertex2f(zero_point[0]-TUBER_X, zero_point[1]);
    glVertex2f(zero_point[0] + CHART_WIDTH, zero_point[1]);
    glEnd();
    
    for (int i = 0; i<6; i++) {
        glBegin(GL_LINES);
        
        glVertex2f(zero_point[0] + i * INTERVAL_X, zero_point[1]);
        glVertex2f(zero_point[0] + i * INTERVAL_X, zero_point[1] + TUBER_Y);
        
        glEnd();
    }
    
    for (int i = 1; i <= 7; i++) {
        glBegin(GL_LINES);
        
        glVertex2f(zero_point[0] - TUBER_X, zero_point[1] + i * INTERVAL_Y);
        glVertex2f(zero_point[0], zero_point[1] + i * INTERVAL_Y);
        glEnd();
    }
    
    // draw bars of two zoos
    glColor3f(1.0f, 0.0f,0.0f);
    for (int i = 0; i < 7; i++)
    {
        glColor3f(rgb[11][0], rgb[11][1],rgb[11][2]);
        glBegin(GL_POLYGON);
        glVertex2f(zero_point[0], zero_point[1] + INTERVAL_Y/4.0 + i * INTERVAL_Y);
        glVertex2f(zero_point[0], zero_point[1] + INTERVAL_Y/2.0 + i * INTERVAL_Y);
        glVertex2f(zero_point[0] + zoo2[i]/100.0 * INTERVAL_X, zero_point[1] + INTERVAL_Y/2.0 + i * INTERVAL_Y);
        glVertex2f(zero_point[0] + zoo2[i]/100.0 * INTERVAL_X, zero_point[1] + INTERVAL_Y/4.0 + i * INTERVAL_Y);
        glEnd();
        
        glColor3f(rgb[12][0], rgb[12][1],rgb[12][2]);
        
        glBegin(GL_POLYGON);
        glVertex2f(zero_point[0], zero_point[1] + INTERVAL_Y/2.0 + i * INTERVAL_Y);
        glVertex2f(zero_point[0], zero_point[1] + INTERVAL_Y/4.0 * 3.0 + i * INTERVAL_Y);
        glVertex2f(zero_point[0] + zoo1[i]/100.0 * INTERVAL_X, zero_point[1] + INTERVAL_Y/4.0 * 3.0 + i * INTERVAL_Y);
        glVertex2f(zero_point[0] + zoo1[i]/100.0 * INTERVAL_X, zero_point[1] + INTERVAL_Y/2.0 + i * INTERVAL_Y);
        glEnd();
    }
    
    // text
    glColor3f(0.0f, 0.0f, 0.0f);
    char amounts[6][4] = {"0","100","200","300","400","500"};
    char years[7][5] = {"2005","2006","2007","2008","2009","2010","2011"};
    float text_left_blank = LEFT_BLANK / 5.0;
    float text_down_blank = DOWN_BLANK / 3.0;
    for (int i = 0; i < 6; i++) {
        display_str(zero_point[0] + INTERVAL_X * i,text_down_blank,GLUT_BITMAP_HELVETICA_10,amounts[i]);
        
    }
    
    
    for (int i = 0; i < 7; i++) {
        display_str(text_left_blank,zero_point[1] + INTERVAL_Y * (i + 0.4),GLUT_BITMAP_HELVETICA_10,years[i]);
    }
    
    // draw two hints
    glPointSize(8.0f);
    glColor3f(rgb[12][0], rgb[12][1],rgb[12][2]);
    glBegin(GL_POINTS);
    glVertex2f(HINTS1_X, HINTS1_Y);
    glEnd();
    glColor3f(rgb[11][0], rgb[11][1],rgb[11][2]);
    glBegin(GL_POINTS);
    glVertex2f(HINTS2_X, HINTS2_Y);
    glEnd();
    
    glColor3f(0.0f, 0.0f,0.0f);
    
    
    display_str(HINTS1_X + TUBER_X + 4.0, HINTS1_Y, GLUT_BITMAP_HELVETICA_10, "Zoo1");
    display_str(HINTS2_X + TUBER_X + 4.0, HINTS2_Y, GLUT_BITMAP_HELVETICA_10, "Zoo2");
    glFlush();
    glutSwapBuffers();
    glutPostRedisplay();
}

// draw second pie chart, @see function leftDown_display
void rightDown_display()
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    glColor3f(0.0f, 0.0f, 0.0f);
    glBegin(GL_LINE_LOOP);
    glVertex2f(SUBWIN_WIDTH * 0.001, SUBWIN_HEIGHT * 0.001);
    glVertex2f(SUBWIN_WIDTH * 0.001,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999,SUBWIN_HEIGHT * 0.999);
    glVertex2f(SUBWIN_WIDTH * 0.999, SUBWIN_HEIGHT * 0.001);
    glEnd();
    
    
    display_str(SUBWIN_WIDTH * 0.4, SUBWIN_HEIGHT * 0.90, GLUT_BITMAP_HELVETICA_18, "Zoo2");
    char years[7][5] = {"2005","2006","2007","2008","2009","2010","2011"};
    
    int sum = 0;
    for(int i = 0;i < 7;i++)
    {
        sum += zoo2[i];
    }
    float proportions[7];
    for (int i = 0; i < 7; i++) {
        proportions[i] = zoo2[i] / (float)sum;
        
    }
    float start = 0.0f;
    
    
    float const HINTS_DISTANCE = RADIUS / 4.0;
    glPointSize(8.0f);
    for (int i = 0; i < 7; i++) {
        glColor3f(rgb[i][0], rgb[i][1], rgb[i][2]);
        sector(proportions[i], start, start + proportions[i]);
        start += proportions[i];
        glBegin(GL_POINTS);
        glVertex2f(HINTS_BEGIN_AT, CENTER_Y + RADIUS - i * HINTS_DISTANCE);
        glEnd();
        glColor3f(0.0f, 0.0f,0.0f);
        display_str(HINTS_BEGIN_AT + 6.0f, CENTER_Y + RADIUS - i * HINTS_DISTANCE - 4.0f, GLUT_BITMAP_HELVETICA_10, years[i]);
    }
    glFlush();
    glutSwapBuffers();
    glutPostRedisplay();
    
}

// keyboard listener of normal keys
void myKeypress(unsigned char key, int x, int y)
{
    
    switch(key)
    {
            //if 'q' pressed, quit program
        case 'q':
            
            exit(0);//quit
            break;
        case 'v':
            refresh_value();
            break;
        case 'r':
            refresh_color();
            break;
        case GLUT_KEY_F1:
            zooSelected = 1;    // zoo1 is choosed
            break;
        case GLUT_KEY_F2:
            zooSelected = 2;    // zoo2 is choosed
            break;
            
        default: break;
    };
    if (key >= '1' && key <= '7') {
        yearSelected = key - '1';
    }
    
    
    glutPostRedisplay();
}

// listener of special keys
void mySpecialKeys(int key,int x,int y)
{
    int *zoo;
    switch (zooSelected) {
        case 1:
            zoo = zoo1;
            break;
        case 2:
            zoo = zoo2;
            break;
        default:
            zoo = zoo1;
            break;
    }
    switch (key) {
        case GLUT_KEY_UP:
            if (zoo[yearSelected] <= 500) {
                zoo[yearSelected] += 10;
            }
            
            
            break;
        case GLUT_KEY_DOWN:
            if (zoo[yearSelected] > 0) {
                zoo[yearSelected] -= 10;
            }
            
            break;
        default:
            break;
    }
    glutPostRedisplay();
}

// menu option
void myMenu(int value)
{
    if (value == 'v') {
        refresh_value();
        glutPostRedisplay();
        return;
    }
    if (value == 'r') {
        refresh_color();
        glutPostRedisplay();
        return;
    }
    if (value == 'q') {
        exit(1);
    }
    /*
     * if value is digit then zoo1 is selected,value is the year selected
     * if value is alpha then zoo2 is selected,value minus 'a' is the year selected
     */
    if (isdigit(value)) {
        zooSelected = 1;
        yearSelected = value;
        cout << value << endl;
        
    }
    
    if (isalpha(value)) {
        zooSelected = 2;
        yearSelected = value - 'a';
        
    }
    glutPostRedisplay();
    
}

// main function
int main(int argc,char * argv[])
{
    init();
    
    
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB);
    glutInitWindowSize(WIN_WIDTH, WIN_HEIGHT);
    glutInitWindowPosition(50, 100);
    gMainWindow = glutCreateWindow("Banana Consumption");
    glutDisplayFunc(main_display);
    // 0-6 and 'a' - 'g' for 2005-2011
    int sub_menu1 = glutCreateMenu(myMenu);
    glutAddMenuEntry("2005", 0);
    glutAddMenuEntry("2006", 1);
    glutAddMenuEntry("2007", 2);
    glutAddMenuEntry("2008", 3);
    glutAddMenuEntry("2009", 4);
    glutAddMenuEntry("2010", 5);
    glutAddMenuEntry("2011", 6);
    
    int sub_menu2 = glutCreateMenu(myMenu);
    glutAddMenuEntry("2005", 'a');
    glutAddMenuEntry("2006", 'b');
    glutAddMenuEntry("2007", 'c');
    glutAddMenuEntry("2008", 'd');
    glutAddMenuEntry("2009", 'e');
    glutAddMenuEntry("2010", 'f');
    glutAddMenuEntry("2011", 'g');
    
    int main_menu = glutCreateMenu(myMenu);
    glutAddSubMenu("Zoo1", sub_menu1);
    glutAddSubMenu("Zoo2", sub_menu2);
    glutAddMenuEntry("random value", 'v');
    glutAddMenuEntry("random color", 'r');
    glutAddMenuEntry("Quit", 'q');
    glutAttachMenu(GLUT_RIGHT_BUTTON);
    
    
    gLeftUpWindow = glutCreateSubWindow(gMainWindow, LEFT_UP_ZERO_X, LEFT_UP_ZERO_Y, SUBWIN_WIDTH, SUBWIN_HEIGHT);
    glutReshapeFunc(reshape);
    glutDisplayFunc(leftUp_display);
    glutKeyboardFunc(myKeypress);
    glutSpecialFunc(mySpecialKeys);
    glutAttachMenu(GLUT_RIGHT_BUTTON);
    
    
    gLeftDownWindow = glutCreateSubWindow(gMainWindow, LEFT_DOWN_ZERO_X, LEFT_DOWN_ZERO_Y, SUBWIN_WIDTH, SUBWIN_HEIGHT);
    glutReshapeFunc(reshape);
    glutDisplayFunc(leftDown_display);
    glutKeyboardFunc(myKeypress);
    glutSpecialFunc(mySpecialKeys);
    glutAttachMenu(GLUT_RIGHT_BUTTON);
    
    
    gRightUpWindow = glutCreateSubWindow(gMainWindow, RIGHT_UP_ZERO_X, RIGHT_UP_ZERO_Y, SUBWIN_WIDTH, SUBWIN_HEIGHT);
    glutReshapeFunc(reshape);
    glutDisplayFunc(rightUp_display);
    glutKeyboardFunc(myKeypress);
    glutSpecialFunc(mySpecialKeys);
    glutAttachMenu(GLUT_RIGHT_BUTTON);
    
    
    gRightDownWindow = glutCreateSubWindow(gMainWindow, RIGHT_DOWN_ZERO_X, RIGHT_DOWN_ZERO_Y, SUBWIN_WIDTH, SUBWIN_HEIGHT);
    glutReshapeFunc(reshape);
    glutDisplayFunc(rightDown_display);
    glutKeyboardFunc(myKeypress);
    glutSpecialFunc(mySpecialKeys);
    glutAttachMenu(GLUT_RIGHT_BUTTON);
    
    
    glutMainLoop();
    
    
    
}

