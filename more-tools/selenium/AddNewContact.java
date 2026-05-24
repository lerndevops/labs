package com.selenium.testing;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class AddNewContact {
	
	public static void main(String[] args) {
		 
		System.setProperty("webdriver.chrome.driver","C:\\Users\\Nareshwar\\Downloads\\chromedriver.exe");
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

}