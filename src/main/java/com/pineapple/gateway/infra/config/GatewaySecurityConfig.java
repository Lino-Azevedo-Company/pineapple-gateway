package com.pineapple.gateway.infra.config;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
public class GatewaySecurityConfig extends WebSecurityConfigurerAdapter {

    private final AuthenticationManager authenticationManager;

    public GatewaySecurityConfig(@Qualifier("jwtAuthenticationManager") AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                    .antMatchers("/oauth/**").permitAll()
                    .anyRequest().fullyAuthenticated()
                .and()
                    .csrf()
                        .disable()
                .oauth2ResourceServer()
                    .jwt()
                        .authenticationManager(authenticationManager);
    }
}
