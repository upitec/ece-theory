# B Field of a dipole, 3D plots
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
      mx = 0
      my = 0.
      mz = 1.
      xmin=-1.
      xmax=1.
      ymin=-1.
      ymax=1.
      zmin=-1.
      zmax=1.
#
##############


unset autoscale
set xr [xmin:xmax]
set yr [ymin:ymax]
set zr [zmin:zmax]
#set key under Left reverse
unset key
#plot "++" u 1:2:(coef*dx2($1,$2)):(coef*dy2($1,$2)) w vec
#plot "++" u 1:2:(coef*dx2($1,$2)):(coef*dy2($1,$2)) w vec, \
#     $equipo2 w l lw 2
#pause -1
set xlabel "X"
set ylabel "Y"
set zlabel "Z"
#set object 1 ellipse center 0,0 size 2*a,2*a fc rgb "red" lw 3 #dashtype 2

#set dgrid3d
   set samples 10,10
   set isosamples 10,10
   set style data vectors 
set ticslevel 0.0
set size square

  splot for [Z=-5:5] '++' using \
       ($1*0.999):($2*0.999):(Z*0.4): (dx1($1,$2,Z)) : (dy1($1,$2,Z)) : (dz1($1,$2,Z)) w vec lw 2.1
pause -1
  splot for [Z=-5:5] '++' using \
       ($1*0.999):($2*0.999):(Z*0.4): (dx2($1,$2,Z)) : (dy2($1,$2,Z)) : (dz2($1,$2,Z)) w vec lw 2.1
pause -1

#  splot for [Z=-5:5] '++' using \
#      ($1*0.999):($2*0.999):(Z*0.25): (0):(0.1):(.0) w vec lw 2.1
#      1:2:Z: (dx1($1,$2,Z)) : (dy1($1,$2,Z)) : (dz1($1,$2,Z)) w vec lw 2.1


#set terminal png transparent nocrop enhanced size 1000,1000 font "arial,16" 
#set output 'B-field.png'
#plot "++" u 1:2:(dx3($1,$2)):(dy3($1,$2)) w vec lw 1.5 head filled, \
#     $equiA w l lw 2.1
#pause -1

########################

# Torque

m1 = mx
m2 = my
m3 = mz
mxBx(x,y,z) = -((m2*mz-m3*my)*R(x,y,z)**2-3*m2*mz*z**2+((3*m3*mz-3*m2*my)*y-3*m2*mx*x)*z+3*m3*my*y**2+3*m3*mx*x*y)/R(x,y,z)**5
mxBy(x,y,z) = ((m1*mz-m3*mx)*R(x,y,z)**2-3*m1*mz*z**2+((3*m3*mz-3*m1*mx)*x-3*m1*my*y)*z+3*m3*my*x*y+3*m3*mx*x**2)/R(x,y,z)**5
mxBz(x,y,z) = -((m1*my-m2*mx)*R(x,y,z)**2+(3*m2*mz*x-3*m1*mz*y)*z-3*m1*my*y**2+(3*m2*my-3*m1*mx)*x*y+3*m2*mx*x**2)/R(x,y,z)**5

      Bnorm(x,y,z)=sqrt(mxBx(x,y,z)**2 + mxBy(x,y,z)**2 + mxBz(x,y,z)**2)
#	normalized direction vecctors
      dx1(x,y,z)=coef*mxBx(x,y,z)/Bnorm(x,y,z)
      dy1(x,y,z)=coef*mxBy(x,y,z)/Bnorm(x,y,z)
      dz1(x,y,z)=coef*mxBz(x,y,z)/Bnorm(x,y,z)
#	scaled direction vecctors
      dx2(x,y,z)=coef*mxBx(x,y,z)
      dy2(x,y,z)=coef*mxBy(x,y,z)
      dz2(x,y,z)=coef*mxBz(x,y,z)
      da(x,y,z) = sqrt(dx2(x,y,z)**2 + dy2(x,y,z)**2 + dz2(x,y,z)**2)
#	clipped direction vectors
      dx3(x,y,z) = da(x,y,z) > coef ? dx1(x,y,z)*coef : dx2(x,y,z)
      dy3(x,y,z) = da(x,y,z) > coef ? dy1(x,y,z)*coef : dy2(x,y,z)
      dz3(x,y,z) = da(x,y,z) > coef ? dz1(x,y,z)*coef : dz2(x,y,z)
#

  splot for [Z=-5:5] '++' using \
       ($1*0.999):($2*0.999):(Z*0.4): (dx1($1,$2,Z)) : (dy1($1,$2,Z)) : (dz1($1,$2,Z)) w vec lw 2.1
pause -1
  splot for [Z=-5:5] '++' using \
       ($1*0.999):($2*0.999):(Z*0.3): (dx2($1,$2,Z)) : (dy2($1,$2,Z)) : (dz2($1,$2,Z)) w vec lw 2.1
pause -1

# Torque Tq_y(z) for x=1, y=0

plot for [z=-5:5] '++' using mxBy(1,0,$1) w lines

