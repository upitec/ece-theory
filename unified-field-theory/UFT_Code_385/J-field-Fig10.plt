# Origin from:
# $Id: vector.dem,v 1.13 2014/04/05 06:17:08 markisch Exp $
#
# This file demonstrates
# -1- saving contour lines as a gnuplottable datablock
# -2- plotting a vector field on the same graph
# -3- manipulating columns using the '$1,$2' syntax.
# the example is taken here from Physics is the display of equipotential
# lines and electrostatic field for a dipole (+q,-q)
#
      r(x,y)=sqrt(x*x+y*y)
      vtot(x,y)=q1*y/r(x,y)**2
#
# This is the spin connection vector of omega_0=-c/r*cos(theta)
      e1x(x,y)= x*(4*y**2+x**2)/(y**2*r(x,y)**5)
      e1y(x,y)= y*(2*y**2-x**2)/(y**2*r(x,y)**5)
      e2x(x,y)= 0
      e2y(x,y)= 0
      etotx(x,y)=e1x(x,y)+e2x(x,y)
      etoty(x,y)=e1y(x,y)+e2y(x,y)
      enorm(x,y)=sqrt(etotx(x,y)*etotx(x,y)+etoty(x,y)*etoty(x,y))
      dx1(x,y)=coef*etotx(x,y)/enorm(x,y)
      dy1(x,y)=coef*etoty(x,y)/enorm(x,y)
      dx2(x,y)=coef*etotx(x,y)
      dy2(x,y)=coef*etoty(x,y)
      dx3(x,y)=enorm(x,y) > coef/.7 ? 0 : 5*dx2(x,y)
      dy3(x,y)=enorm(x,y) > coef/.7 ? 0 : 5*dy2(x,y)
#
      coef=.7
      x0=0.
      y0=1.
      q1=1.
      q2=-1.
      xmin=-10.
      xmax=10.
      ymin=-10.
      ymax=10.
#
unset autoscale
set xr [xmin:xmax]
set yr [ymin:ymax]
set isosam 31,31
set isosam 61,61
#set view 0, 0, 1, 1
set view map
unset surface
set contour base
set cntrparam order 4
set cntrparam linear
set cntrparam levels discrete 3, -2, -1 ,-0.5 , -0.2 ,-0.1 , -0.05, -0.02 , 0.0, 0.02, 0.05, 0.1 ,0.2, 0.5, 1, 2, 3
set cntrparam points 5
#
#set label "-q" at -1,0 center
#set label "+q" at  1,0 center
splot vtot(x,y) w l lw 3
print "Now create a in-memory datablock with equipotential lines"
pause -1

#############

set table $equipo2
replot
unset table

plot $equipo2 w l
print "Now create a x/y datablock for plotting with vectors "
print "and display vectors parallel to the electrostatic field"
pause -1

##############

set isosam 31,31
set sam 31,31
#set isosam 21,21

set table $field2xy
splot vtot(x,y) w l
unset table

unset autoscale
set xr [xmin:xmax]
set yr [ymin:ymax]
#set isosam 31,31
#set key under Left reverse
unset key
set xlabel "X"
set ylabel "Z"
set grid
set size square
#plot $field2xy u 1:2:(coef*dx1($1,$2)):(coef*dy1($1,$2)) w vec
plot "++" u 1:2:(coef*dx1($1,$2)):(coef*dy1($1,$2)) w vec lw 2.5, \
     $equipo2 w l lw 1.5
pause -1
plot "++" u 1:2:(coef*dx2($1,$2)):(coef*dy2($1,$2)) w vec lw 2.5, \
     $equipo2 w l lw 1.5
pause -1

plot "++" u 1:2:(coef*dx3($1,$2)):(coef*dy3($1,$2)) w vec lw 2.5, \
     $equipo2 w l lw 1.5

set terminal png transparent nocrop enhanced size 1000,1000 font "arial,20" 
set output 'Fig10a.png'
set border lw 3
plot "++" u 1:2:(coef*dx3($1,$2)):(coef*dy3($1,$2)) w vec lw 3, \
     $equipo2 w l lw 3
pause -1
set output 'Fig10.png'
set border lw 3
plot "++" u 1:2:(coef*dx1($1,$2)):(coef*dy1($1,$2)) w vec lw 3, \
     $equipo2 w l lw 3
pause -1
