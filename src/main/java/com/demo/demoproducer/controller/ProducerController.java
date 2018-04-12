package com.demo.demoproducer.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.demoproducer.bean.Employee;

@RestController
@RequestMapping("/producer/produceEmployee")
public class ProducerController {
	

	@GetMapping
	public  List<Employee> produceEmployeeList(){
		return Arrays.asList(new Employee[]{new Employee(1, "Hello There !", "rajesh@gmail.com", 10000000),new Employee(2, "Nitin", "nitin@gmail.com", 123888383)});
	}
}
