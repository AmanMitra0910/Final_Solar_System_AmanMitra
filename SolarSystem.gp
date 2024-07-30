set terminal pngcairo size 3840, 2160 enhanced font 'Arial,20'
set output 'solar_system.png'
set title "Solar System Orbits Simulation"
set xlabel "X Position (m)"
set ylabel "Y Position (m)"
set zlabel "Z Position (m)"
set grid

s = 50 

radius_sun = 6.96e8 * s

splot 'mercury_positions.dat' using 1:2:3 with lines lc rgb 'orange' title 'Mercury Orbit', \
      'venus_positions.dat' using 1:2:3 with lines lc rgb 'brown' title 'Venus Orbit', \
      'earth_positions.dat' using 1:2:3 with lines lc rgb 'blue' title 'Earth Orbit', \
      'mars_positions.dat' every ::1 using 1:2:3 with lines lc rgb 'orange-red' title 'Mars Orbit', \
      'jupiter_positions.dat' every ::1 using 1:2:3 with lines lc rgb 'bisque' title 'Jupiter Orbit', \
      'saturn_positions.dat' every ::1 using 1:2:3 with lines lc rgb 'magenta' title 'Saturn Orbit', \
      'uranus_positions.dat' every ::1 using 1:2:3 with lines lc rgb 'royalblue' title 'Uranus Orbit', \
      'neptune_positions.dat' every ::1 using 1:2:3 with lines lc rgb 'navy' title 'Neptune Orbit', \
      'pluto_positions.dat' every ::1 using 1:2:3 with lines lc rgb 'black' title 'Pluto Orbit', \
      'hailey_positions.dat' every ::1 using 1:2:3 with lines lc rgb 'dark-green' title 'Hailey Orbit', \
      '' using (0):(0):(0):(radius_sun) with circles lc rgb 'yellow' fillcolor rgb 'yellow' title 'Sun'

set output
