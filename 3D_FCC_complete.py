from visual import *
from math import sin
from math import cos

# Disable default rotation
scene.userspin = False

#initialize variables
theta_x = 0
theta_y = 0
theta_z = 0
face = []
unit = []
a = math.sqrt(2)
original_FCC = [(0,0,0),(0,a,a),(-2*a,0,0),(-a,0,a),(-a,0,-a),(0,-a,a),(0,-a,-a),(-2*a,-a,-a),(-a,-a,0),(-a,a,0),(-2*a,a,a),(-2*a,a,-a),(0,a,-a),(a,a,0),(a,-a,0),(a,0,-a),(a,0,-a),(2*a,a,-a),(2*a,-a,-a)]

# Create initial spheres
for i in range(len(original_FCC)):
    face.append(original_FCC[i])
    unit.append(sphere (pos=face[i], radius=1, color=color.white))

# create new set of coordinates due to a change in theta
def updateunit():
    limit()
    for i in range(len(original_FCC)):
        global theta_x,theta_y,theta_z,face
        x,y,z  = original_FCC[i]
        newx,newy,newz = 0,0,0
########################################################
########################################################
##################### CODE BELOW #######################
#	HELPFUL NOTES:
#
#   [1] Unlike C, Python is space sensitive. Meaning:
#this,
#   this,
#
#   can have completely different results. Please don't alter t spacing.
#
#
#   [2] Use the following variables to help you code:
#
#       x : The point's original x location
#       y : The point's original y location
#       z : The point's original z location
#       theta_x : The radian to rotate in the x axis
#       theta_y : The radian to rotate in the y axis
#       theta_z : The radian to rotate in the z axis
#
#
#   [3] Use these functions to help you code:
#
#       cos([variable])
#       sin([variable])
#
#		Both require radian input
############################################################

        # z-axis rotation
        newx = x*cos(theta_z) - y*sin(theta_z)    #CODE HERE
        newy = x*sin(theta_z) + y*cos(theta_z)    #CODE HERE
        newz = z                                  #CODE HERE

        
        x,y,z = newx,newy,newz                    #DO NOT TOUCH
        # y-axis rotation
        newx = x*cos(theta_y) - z*sin(theta_y)    #CODE HERE
        newy = y                                  #CODE HERE
        newz = x*sin(theta_y) + z*cos(theta_y)    #CODE HERE

        
        x,y,z = newx,newy,newz                    #DO NOT TOUCH
        # x-axis rotation
        newx = x                                  #CODE HERE
        newy = y*cos(theta_x) - z*sin(theta_x)    #CODE HERE
        newz = y*sin(theta_x) + z*cos(theta_x)    #CODE HERE

##################### CODE ABOVE #######################
########################################################
########################################################
        face[i] = (newx,newy,newz)
    drawunit()

# Reposition spheres
def drawunit():
    unit[1].color = color.red
    for i in range(len(original_FCC)):
        global face, unit
        unit[i].pos = face[i]

# Make sure -pi < theta < pi
def limit():
    global theta_x,theta_y,theta_z
    if (theta_x < -math.pi):
        theta_x = -math.pi
    if (theta_y < -math.pi):
        theta_y = -math.pi    
    if (theta_z < -math.pi):
        theta_z = -math.pi
    if (theta_x > math.pi):
        theta_x = math.pi
    if (theta_y > math.pi):
        theta_y = math.pi
    if (theta_z > math.pi):
        theta_z = math.pi
        
#infinite loop to check for keyboard input
while 1:
    key = scene.kb.getkey()
    if len(key) == 1:
        if (key == 'q'): 
            theta_x -= math.pi/12
        elif (key == 'w'): 
            theta_x += math.pi/12
        elif (key == 'a'): 
            theta_y -= math.pi/12
        elif (key == 's'): 
            theta_y += math.pi/12
        elif (key == 'z'): 
            theta_z -= math.pi/12
        elif (key == 'x'): 
            theta_z += math.pi/12
        updateunit()
