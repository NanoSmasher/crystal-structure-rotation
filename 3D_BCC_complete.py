from visual import *

# Disable default rotation
scene.userspin = False

#initialize variables
theta_x = 0
theta_y = 0
theta_z = 0
face = []
unit = []
r = 2/math.sqrt(3)
original_BCC = [(0,0,0),(r,r,r),(-r,r,r),(r,-r,r),(r,r,-r),(-r,-r,r),(-r,r,-r),(r,-r,-r),(-r,-r,-r)]

# Create initial spheres
for i in range(len(original_BCC)):
    face.append(original_BCC[i])
    unit.append(sphere (pos=face[i], radius=1, color=color.white))

# create new set of coordinates due to a change in theta
def updateunit():
    limit()
    for i in range(len(original_BCC)):
        global theta_x,theta_y,theta_z,face
        x,y,z  = original_BCC[i]
########################################################
########################################################
##################### CODE BELOW #######################
#	HELPFUL NOTES:
#
#   [1] Unlike C, Python space sensitive, meaning:
#this,
#   this,
#
#   have completely different meanings. So please do not alter any spacing.
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
#       math.cos([variable])
#       math.sin([variable])
############################################################

        # z-axis rotation
        newx = x*math.cos(theta_z) - y*math.sin(theta_z)    #CODE HERE
        newy = x*math.sin(theta_z) + y*math.cos(theta_z)    #CODE HERE
        newz = z                                            #CODE HERE

        
        x,y,z = newx,newy,newz                              #DO NOT TOUCH
        # y-axis rotation
        newx = x*math.cos(theta_y) - z*math.sin(theta_y)    #CODE HERE
        newy = y                                            #CODE HERE
        newz = x*math.sin(theta_y) + z*math.cos(theta_y)    #CODE HERE

        
        x,y,z = newx,newy,newz                              #DO NOT TOUCH
        # x-axis rotation
        newx = x                                            #CODE HERE
        newy = y*math.cos(theta_x) - z*math.sin(theta_x)    #CODE HERE
        newz = y*math.sin(theta_x) + z*math.cos(theta_x)    #CODE HERE

##################### CODE ABOVE #######################
########################################################
########################################################
        face[i] = (newx,newy,newz)
    drawunit()

# Reposition spheres
def drawunit():
    for i in range(len(original_BCC)):
        global face, unit
        unit[i].pos = face[i]

# Make sure 0 < theta < 2*pi
def limit():
    global theta_x,theta_y,theta_z
    if (theta_x < 0):
        theta_x = 0
    if (theta_y < 0):
        theta_y = 0    
    if (theta_z < 0):
        theta_z = 0
    if (theta_x > 2*math.pi):
        theta_x = 2*math.pi
    if (theta_y > 2*math.pi):
        theta_y = 2*math.pi
    if (theta_z > 2*math.pi):
        theta_z = 2*math.pi
        
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
