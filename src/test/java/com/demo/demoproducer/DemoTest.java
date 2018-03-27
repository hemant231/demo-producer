package com.demo.demoproducer;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import junit.framework.Assert;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DemoTest {
	@Test
	public void demoTest() {
		Assert.assertTrue(true);
	}
}
