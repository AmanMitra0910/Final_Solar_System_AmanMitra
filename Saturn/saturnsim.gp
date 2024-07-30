set terminal pngcairo size 800, 600 enhanced font 'Arial,10'
set output 'saturn_orbit.png'
set title "Saturn Orbit Simulation"
set xlabel "X Position (m)"
set ylabel "Y Position (m)"
set zlabel "Z Position (m)"
set grid

size_scaling_factor = 50  

radius_sun = 6.96e8 * size_scaling_factor
radius_saturn = 5.8232e7 * size_scaling_factor

splot 'saturn_positions.dat' using 1:2:3 with lines title 'Orbit', \
      '' using (0):(0):(0):(radius_sun) with circles lc rgb 'yellow' title 'Sun', \
      'saturn_positions.dat' using 1:2:3:(radius_saturn) with circles lc rgb 'magenta' title 'Saturn'

set output