module PlanetModule
    implicit none

    type :: PlanetType
        character(len=20) :: name
        real :: mass
        real :: position(3)
        real :: radial_velocity
        real :: orbital_velocity
        real :: semi_major_axis
        real :: eccentricity
        real :: true_anomaly
        real :: mean_anomaly
    end type PlanetType

    contains

    subroutine initialize_planet(planet, name, mass, position, radial_velocity, orbital_velocity, semi_major_axis, eccentricity)
        type(PlanetType), intent(out) :: planet
        character(len=*), intent(in) :: name
        real, intent(in) :: mass
        real, intent(in) :: position(3)
        real, intent(in) :: radial_velocity
        real, intent(in) :: orbital_velocity
        real, intent(in) :: semi_major_axis
        real, intent(in) :: eccentricity

        planet%name = name
        planet%mass = mass
        planet%position = position
        planet%radial_velocity = radial_velocity
        planet%orbital_velocity = orbital_velocity
        planet%semi_major_axis = semi_major_axis
        planet%eccentricity = eccentricity
        planet%true_anomaly = 0.0
        planet%mean_anomaly = 0.0
    end subroutine initialize_planet

    subroutine print_planet_info(planet)
        type(PlanetType), intent(in) :: planet

        print *, 'Planet Information:'
        print *, 'Name:', planet%name
        print *, 'Mass:', planet%mass
        print *, 'Position: (', planet%position(1), ',', planet%position(2), ',', planet%position(3), ')'
        print *, 'Radial Velocity:', planet%radial_velocity
        print *, 'Orbital Velocity:', planet%orbital_velocity
        print *, 'Semi-Major Axis:', planet%semi_major_axis
        print *, 'Eccentricity:', planet%eccentricity
    end subroutine print_planet_info

    subroutine calculate_orbital_velocity(planet, central_mass, orbital_velocity)
        type(PlanetType), intent(in) :: planet
        real, intent(in) :: central_mass
        real, intent(out) :: orbital_velocity
        real :: G, semi_major_axis

        G = 6.67430e-11 
        semi_major_axis = planet%semi_major_axis
        orbital_velocity = sqrt(G * central_mass * (2.0 / semi_major_axis - & 
                        1.0 / (semi_major_axis * (1.0 - planet%eccentricity**2))))
    end subroutine calculate_orbital_velocity

    subroutine calculate_time_period(planet, time_period)
        type(PlanetType), intent(in) :: planet
        real, intent(out) :: time_period
        real :: G, central_mass, semi_major_axis

        G = 6.67430e-11 
        central_mass = 1.989e30  
        semi_major_axis = planet%semi_major_axis
        time_period = 2.0 * 3.14159265358979323846 * sqrt(semi_major_axis**3 / (G * central_mass))
    end subroutine calculate_time_period    

    subroutine update_position(planet, dt)
        type(PlanetType), intent(inout) :: planet
        real, intent(in) :: dt
        real :: G, central_mass, semi_major_axis, eccentricity, mean_motion
        real :: M, E, E_new, true_anomaly, radius
        integer :: i
    
        G = 6.67430e-11 
        central_mass = 1.989e30  
        semi_major_axis = planet%semi_major_axis
        eccentricity = planet%eccentricity
    
        mean_motion = sqrt(G * central_mass / semi_major_axis**3)
        planet%mean_anomaly = planet%mean_anomaly + mean_motion * dt
    
        M = mod(planet%mean_anomaly, 2.0 * 3.14159265358979323846)
    
        E = M
        do i = 1, 100
            E_new = M + eccentricity * sin(E)
            if (abs(E_new - E) < 1.0e-6) exit
            E = E_new
        end do
    
        true_anomaly = 2.0 * atan2(sqrt(1.0 + eccentricity) * sin(E / 2.0), &
                                   sqrt(1.0 - eccentricity) * cos(E / 2.0))
        planet%true_anomaly = true_anomaly
    
        radius = semi_major_axis * (1.0 - eccentricity**2) / &
                 (1.0 + eccentricity * cos(true_anomaly))
        planet%position(1) = radius * cos(true_anomaly)
        planet%position(2) = radius * sin(true_anomaly)
        planet%position(3) = 0.0
    end subroutine update_position    

end module PlanetModule

program simulate_orbit
    use PlanetModule
    implicit none

    type(PlanetType) :: jupiter
    character(len=20) :: name
    real :: mass, central_mass, radial_velocity, orbital_velocity, dt, total_time
    real :: position(3)
    real :: semi_major_axis, eccentricity, t_jupiter
    integer :: i, num_steps
    open(unit=10, file='jupiter_positions.dat', status='replace')

    name = 'Jupiter'
    mass = 1.8982e27
    position = (/7.7857e11, 0.0, 0.0/)
    radial_velocity = 2.978e4
    semi_major_axis = 7.7857e11  
    eccentricity = 0.0489       
    central_mass = 1.989e30     

    call initialize_planet(jupiter, name, mass, position, radial_velocity, 0.0, semi_major_axis, eccentricity)

    call calculate_orbital_velocity(jupiter, central_mass, orbital_velocity)

    call initialize_planet(jupiter, name, mass, position, radial_velocity, orbital_velocity, semi_major_axis, eccentricity)
    call print_planet_info(jupiter)

    call calculate_time_period(jupiter, t_jupiter)

    dt = 86400.0 
    total_time = t_jupiter 
    num_steps = int(total_time / dt)

    write(10, *) jupiter%position(1), jupiter%position(2), jupiter%position(3)

    do i = 1, num_steps
        call update_position(jupiter, dt)
        write(10, *) jupiter%position(1), jupiter%position(2), jupiter%position(3)
    end do

    close(10)
end program simulate_orbit