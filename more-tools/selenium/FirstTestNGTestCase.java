package com.com.hellotest;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

public class SeleniumWebdriverTest {
  
  @Test
  public void MyFirstTestNGTestCase()  {
	    System.setProperty("webdriver.chrome.driver", "C:\\Users\\Nareshwar\\Downloads\\chromedriver.exe");
	    WebDriver driver = new ChromeDriver();
	    driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
	    driver.get("http://192.168.198.141:32768/addressbook/");
		driver.findElement(By.xpath("//div[@class = 'v-button v-widget']")).click();
		driver.findElement(By.id("gwt-uid-5")).sendKeys("Rostow1");
		driver.findElement(By.id("gwt-uid-7")).sendKeys("G");
		driver.findElement(By.id("gwt-uid-9")).sendKeys("805983095");
		driver.findElement(By.id("gwt-uid-11")).sendKeys("Rostow@gmail.com");
		driver.findElement(By.xpath("//div[@class = 'v-button v-widget primary v-button-primary']")).click();
		driver.close();
  }
  
  @BeforeMethod
  public void beforeMethod() {
	  System.out.println("Executed Before the Test");
  }

  @AfterMethod
  public void afterMethod() {
	  System.out.println("Executed After the Test");
  }

}
