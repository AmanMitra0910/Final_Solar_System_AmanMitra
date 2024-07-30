set terminal pngcairo size 800, 600 enhanced font 'Arial,10'
set output 'pluto_orbit.png'
set title "Pluto Orbit Simulation"
set xlabel "X Position (m)"
set ylabel "Y Position (m)"
set zlabel "Z Position (m)"
set grid

size_scaling_factor = 100  

radius_sun = 6.96e8 * size_scaling_factor
radius_pluto = 1.1883e6 * size_scaling_factor

splot 'pluto_positions.dat' using 1:2:3 with lines title 'Orbit', \
      '' using (0):(0):(0):(radius_sun) with circles lc rgb 'yellow' title 'Sun', \
      'pluto_positions.dat' using 1:2:3:(radius_pluto) with circles lc rgb 'black' title 'Pluto'

set output