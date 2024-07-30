set terminal pngcairo size 800, 600 enhanced font 'Arial,10'
set output 'uranus_orbit.png'
set title "Uranus Orbit Simulation"
set xlabel "X Position (m)"
set ylabel "Y Position (m)"
set zlabel "Z Position (m)"
set grid

size_scaling_factor = 50  

radius_sun = 6.96e8 * size_scaling_factor
radius_uranus = 2.5362e7 * size_scaling_factor

splot 'uranus_positions.dat' using 1:2:3 with lines title 'Orbit', \
      '' using (0):(0):(0):(radius_sun) with circles lc rgb 'yellow' title 'Sun', \
      'uranus_positions.dat' using 1:2:3:(radius_uranus) with circles lc rgb 'royalblue' title 'Uranus'

set output