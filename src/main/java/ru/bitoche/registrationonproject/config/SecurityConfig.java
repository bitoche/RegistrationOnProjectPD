package ru.bitoche.registrationonproject.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.config.annotation.web.configurers.AbstractAuthenticationFilterConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.context.DelegatingSecurityContextRepository;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.RequestAttributeSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;
import ru.bitoche.registrationonproject.services.AppUserDetailsService;

import java.util.Objects;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfiguration {
    @Bean
    public UserDetailsService userDetailsService(){
        return new AppUserDetailsService();
    }
    @Bean
    public SecurityContextRepository securityContextRepository() {return new DelegatingSecurityContextRepository(
            new RequestAttributeSecurityContextRepository(),
            new HttpSessionSecurityContextRepository());
    }
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, SecurityContextRepository securityContextRepository) throws Exception {
        http.cors().disable().csrf().disable()
                .authorizeHttpRequests(
                        Objects.requireNonNull(authorizeHttpRequests ->
                                authorizeHttpRequests.
                                        requestMatchers("/css/**", "/js/**", "/svg/**").permitAll().
                                        requestMatchers("/", "/check-username", "/users/login", "/users/register", "/users/login-error", "/login").permitAll().
                                        requestMatchers("/dev/**", "/dev").hasAuthority(USER_ROLE.DEV.name()).
                                        requestMatchers("/users/profile/**", "/teams/profile/**", "/users/logout").authenticated().
                                        requestMatchers("/adm/m/**").hasAuthority(USER_ROLE.MAIN_ADMIN.name()).
                                        requestMatchers("/adm/**", "/adm").hasAnyAuthority(USER_ROLE.ADMIN.name(), USER_ROLE.MAIN_ADMIN.name()).
                                        anyRequest().authenticated())

                )
                .formLogin(AbstractAuthenticationFilterConfigurer::permitAll)
                .logout((logout) ->
                        logout.logoutUrl("/users/logout").
                                logoutSuccessUrl("/").
                                invalidateHttpSession(true)
                )
                .securityContext(
                        securityContext -> securityContext.
                                securityContextRepository(securityContextRepository)
                );
        return http.build();
    }
    @Bean
    public AuthenticationProvider authenticationProvider(){
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService());
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
}
