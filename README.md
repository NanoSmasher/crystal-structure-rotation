Low-level rotations of Crystal structure faces
==============================================

Sounds like a 4th year thesis :P

This is a little side project that combines the applications learned in first year engineering (at UofT) that can be used as a teaching tool for future classes. This program is backed by a `document` that will explain how the program fits into the curriculum. The following courses where used:

 * **APS106** - Fundamentals to Computer Programming
	* Writing statements, using variables and internal math functions
 * **MAT186** - Linear Algebra
	* Solve rotation and transformation matrices
 * **MSE101** - Introduction to Material Science
	* Interpret different crystal structures in various angles

	Additional but minor connections:
 * **MAT187** - Calculus II
	* Using series to approximate sin and cosine
 * **APS111** - Engineering Strategies & Practice I
	* Control/display considers physical & psychological human factors

How it combines multiple courses:
	We are given a set of atom points for a particular face. We take a rotational matrix and compute new coordinates based on old ones. We find a couple of statements that is able to rotate any arbitrary point. We program these statements into the source code. We then rotate the set of atom points until the structure matches up with one of the given crystal structure face. Since there is already a function called rotate() which does this all automatically, the code is *low-level*.

Plan:
 - [] Make buttons FCC[100], FCC[110], FCC[111], BCC[100], BCC[110], about
 - [] Encapsulate data points in a more organized fashion (separate file?)
 - [] Provide extensive commenting
 - [] Useful Aesthetics
	- [] Turning greyed structures on and off
	- [] Bring greyed structures in front, in back
	- [] Switch between unit cells and lattices
 - [] Extra features
	- [] Movement with arrow or WASD keys
	- [] Zooming with mouse wheel
	- [] Snapping at key theta angles
 - [] Extra thought :: Give them data points to plot themselves and find out the structure
