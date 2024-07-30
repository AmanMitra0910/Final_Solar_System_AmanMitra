set terminal pngcairo size 800, 600 enhanced font 'Arial,10'
set output 'hailey_orbit.png'
set title "Hailey Comet Orbit Simulation"
set xlabel "X Position (m)"
set ylabel "Y Position (m)"
set zlabel "Z Position (m)"
set view 60 , 60
set grid

size_scaling_factor = 100  

radius_sun = 6.96e8 * size_scaling_factor
radius_hailey = 10000 * size_scaling_factor

splot 'hailey_positions.dat' every ::1 using 1:2:3 with lines title 'Orbit', \
      '' using (0):(0):(0):(radius_sun) with circles lc rgb 'yellow' title 'Sun', \
      'hailey_positions.dat' using 1:2:3:(radius_hailey) with circles lc rgb 'dark-green' title 'Hailey Comet'

set output