package com.acorp.falcodoro.falcodoromanager;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class FalcoDOroApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder){
		return builder.sources(FalcoDOroApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(FalcoDOroApplication.class, args);
	}

}
