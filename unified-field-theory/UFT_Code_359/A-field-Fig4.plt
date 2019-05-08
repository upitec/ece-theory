# Vector potential of a dipole, cross section
#
      reset
#
      Ax(x,y)= (my*z-mz*y)/(z**2+y**2+x**2)**(3./2.)
      Ay(x,y)= (mz*x-mx*z)/(z**2+y**2+x**2)**(3./2.)
      Az(x,y)= (mx*y-my*x)/(z**2+y**2+x**2)**(3./2.) 
#	  
      Anorm(x,y)=sqrt(Ax(x,y)*Ax(x,y)+Ay(x,y)*Ay(x,y))
#	normalized direction vecctors
      dx1(x,y)=coef*Ax(x,y)/Anorm(x,y)
      dy1(x,y)=coef*Ay(x,y)/Anorm(x,y)
#	scaled direction vecctors
      dx2(x,y)=coef*Ax(x,y)
      dy2(x,y)=coef*Ay(x,y)
      da(x,y) = sqrt(dx2(x,y)**2 + dy2(x,y)**2)
#	clipped direction vectors
      dx3(x,y) = da(x,y) > coef ? dx1(x,y)*coef : dx2(x,y)
      dy3(x,y) = da(x,y) > coef ? dy1(x,y)*coef : dy2(x,y)
#
      coef=.2
      z=0
      mx = 0
      my = 0.
      mz = 0.5
      xmin=-1.
      xmax=1.
      ymin=-1.
      ymax=1.
#
unset autoscale
set xr [xmin:xmax]
set yr [ymin:ymax]
#set isosam 31,31
set isosam 61,61
#set view 0, 0, 1, 1
set view map
unset surface
set contour base
set cntrparam order 4
set cntrparam linear
set cntrparam levels discrete 1., 2., 3., 4., 5., 6., 7., 8.
set cntrparam points 5
#
#set label "-q" at -1,0 center
#set label "+q" at  1,0 center
set size square
#set size ratio 0.7
splot Anorm(x,y) w l lw 2.1
print "Now create an in-memory datablock with equipotential lines"
pause -1

#############

set table $equiA
replot
unset table

plot $equiA w l lw 2.1
print "Now create a x/y datablock for plotting with vectors "
print "and display vectors parallel to the electrostatic field"
pause -1

##############

set sam 31,31
set isosam 31,31
#set isosam 21,21

set table $field2xy
splot Ax(x,y) w l
unset table

unset autoscale
set xr [xmin:xmax]
set yr [ymin:ymax]
#set key under Left reverse
unset key
#plot "++" u 1:2:(coef*dx2($1,$2)):(coef*dy2($1,$2)) w vec
#plot "++" u 1:2:(coef*dx2($1,$2)):(coef*dy2($1,$2)) w vec, \
#     $equipo2 w l lw 2
#pause -1
set xlabel "X"
set ylabel "Y"
#set object 1 ellipse center 0,0 size 2*a,2*a fc rgb "red" lw 3 #dashtype 2
set grid 
plot "++" u 1:2:(coef*dx1($1,$2)):(coef*dy1($1,$2)) w vec lw 1.5, \
     $equiA w l lw 2.1
pause -1

plot "++" u 1:2:(dx3($1,$2)):(dy3($1,$2)) w vec lw 1.5 head filled, \
     $equiA w l lw 2.1

set terminal png transparent nocrop enhanced size 1000,1000 font "arial,16" 
set output 'Fig4.png'
plot "++" u 1:2:(dx3($1,$2)):(dy3($1,$2)) w vec lw 1.5 head filled, \
     $equiA w l lw 2.1
pause -1
