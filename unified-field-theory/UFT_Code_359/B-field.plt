#
#     Dipole field, analytical formula
#
      reset
#
      R(x,y,z) = sqrt(x**2+y**2+z**2);
#
      Bx(x,y,z)= -(mx*R(x,y,z)**2-3*mz*x*z-3*my*x*y-3*mx*x**2)/R(x,y,z)**5
      By(x,y,z)= -(my*R(x,y,z)**2-3*mz*y*z-3*my*y**2-3*mx*x*y)/R(x,y,z)**5
      Bz(x,y,z)= -(mz*R(x,y,z)**2-3*mz*z**2+(-3*my*y-3*mx*x)*z)/R(x,y,z)**5
#	  
      Bnorm(x,y,z)=sqrt(Bx(x,y,z)**2 + By(x,y,z)**2 + Bz(x,y,z)**2)
#	normalized direction vecctors
      dx1(x,y,z)=coef*Bx(x,y,z)/Bnorm(x,y,z)
      dy1(x,y,z)=coef*By(x,y,z)/Bnorm(x,y,z)
      dz1(x,y,z)=coef*Bz(x,y,z)/Bnorm(x,y,z)
#	scaled direction vecctors
      dx2(x,y,z)=coef*Bx(x,y,z)
      dy2(x,y,z)=coef*By(x,y,z)
      dz2(x,y,z)=coef*Bz(x,y,z)
      da(x,y,z) = sqrt(dx2(x,y,z)**2 + dy2(x,y,z)**2 + dz2(x,y,z)**2)
#	clipped direction vectors
      dx3(x,y,z) = da(x,y,z) > coef ? dx1(x,y,z)*coef : dx2(x,y,z)
      dy3(x,y,z) = da(x,y,z) > coef ? dy1(x,y,z)*coef : dy2(x,y,z)
      dz3(x,y,z) = da(x,y,z) > coef ? dz1(x,y,z)*coef : dz2(x,y,z)
#
      coef=.2
      mx = 0.
      my = 0.1
      mz = 0.
      z = 0
      xmin=-1.
      xmax=1.
      ymin=-1.
      ymax=1.
      #zmin=-1.
      #zmax=1.
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
set cntrparam levels discrete -30,-20 ,-10 ,-5 ,-2 ,-1 ,-0.35 ,-0.2 ,0.0 ,0.2 ,0.5 ,1 ,2 ,5 , 10 ,20 ,30 
set cntrparam points 5
#
#set label "-q" at -1,0 center
#set label "+q" at  1,0 center
splot Bnorm(x,y,z) w l lw 2
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

#set isosam 21,21
set isosam 31,31
set sam 31,31

#set table $field2xy
#splot vtot(x,y) w l
#unset table

unset autoscale
set xr [xmin:xmax]
set yr [ymin:ymax]
#set isosam 31,31
#set key under Left reverse
unset key
set xlabel "r"
set ylabel "r"
set grid
set size square
#plot $field2xy u 1:2:(coef*dx1($1,$2)):(coef*dy1($1,$2)) w vec
plot "++" u 1:2:(coef*dx1($1,$2,z)):(coef*dy1($1,$2,z)) w vec lw 1.5, \
     $equipo2 w l lw 1.5
pause -1

plot "++" u 1:2:(coef*dx3($1,$2,z)):(coef*dy3($1,$2,z)) w vec lw 1.5, \
     $equipo2 w l lw 1.5

set terminal png transparent nocrop enhanced size 1200,800 font "arial,16" 
set output 'Dipole.png'
plot "++" u 1:2:(coef*dx1($1,$2,z)):(coef*dy1($1,$2,z)) w vec, \
     $equipo2 w l lw 1.6
pause -1
