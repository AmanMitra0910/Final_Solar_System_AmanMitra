set terminal pngcairo size 800, 600 enhanced font 'Arial,10'
set output 'mercury_orbit.png'
set title "Mercury Orbit Simulation"
set xlabel "X Position (m)"
set ylabel "Y Position (m)"
set zlabel "Z Position (m)"
set grid

size_scaling_factor = 20  

radius_sun = 6.96e8 * size_scaling_factor
radius_mercury = 2.439e6 * size_scaling_factor

splot 'mercury_positions.dat' using 1:2:3 with lines title 'Orbit', \
      '' using (0):(0):(0):(radius_sun) with circles lc rgb 'yellow' title 'Sun', \
      'mercury_positions.dat' using 1:2:3:(radius_mercury) with circles lc rgb 'orange' title 'Mercury'

set output
