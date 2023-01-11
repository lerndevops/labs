package petclicic1;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class PetOnerunnable {
	


	
	public static class PetOne {
	 	

		
	
		
			public static void main(String [] args) throws InterruptedException {
		        System.setProperty("webdriver.chrome.driver", "C:\\Selenium\\Jars\\chromedriver.exe");
		    	WebDriver driver;
		        driver = new ChromeDriver();
	
				driver.get("http://34.70.50.84:8080/petclinic/");
				Thread.sleep(5000);
				driver.manage().window().maximize();
				
				//Verify title of the page
				System.out.println("title of the page :"+driver.getTitle());
				
				driver.findElement(By.xpath("//SPAN[text()=' Find owners']")).click();
				
				Thread.sleep(2000);
				
				driver.findElement(By.xpath("//a[text()='Add Owner']")).click();
				  
				  
				//First Name
				  
				 driver.findElement(By.xpath("//input[@id='firstName']")).sendKeys("Test Name1");
				//Last Name Thread.sleep(2000);
				 
				  driver.findElement(By.xpath("//input[@id='lastName']")).sendKeys("Test Last Name1"); 
				  
				//Address
				  driver.findElement(By.xpath("//input[@id='address']")).sendKeys("Sample Address-1");
				  
				  //City
				  driver.findElement(By.xpath("//input[@id='city']")).sendKeys("Hyderabad");			  
				  Thread.sleep(2000);
				  
				//Telephone 
				  driver.findElement(By.xpath("//input[@id='telephone']")).sendKeys("9988998899"); 
				  
				  driver.findElement(By.xpath("//button[text()='Add Owner']")).click();
				  
				  Thread.sleep(5000);
				 
		
				
				//driver.findElement(By.xpath("//SPAN[text()=' Find owners']")).click();//Find Owners
				
				//driver.findElement(By.xpath("//input[@id='lastName']")).sendKeys("Test Last Name1");//Search Last Name
				
				//driver.findElement(By.xpath("//button[text()='Find Owner']")).click(); // Click on Find Owner
				//Thread.sleep(5000);
				
				//driver.findElement(By.xpath("//*[@id=\"owners\"]/tbody/tr[2]/td[1]/a")).click();
				//Thread.sleep(3000);
				  
				 
				
				driver.findElement(By.xpath("//a[text()='Add New Pet']")).click();
				
				driver.findElement(By.xpath("//input[@id='name']")).clear();
				
				driver.findElement(By.xpath("//input[@id='name']")).sendKeys("Polo");//PetName
				
				//driver.findElement(By.xpath("//input[@id='birthDate']")).sendKeys("2020/10/15");
				//*[@id="ui-datepicker-div"]/table/tbody/tr[3]/td[4]/a
				
				Thread.sleep(3000);
				
				/*WebElement Select = driver.findElement(By.id("type"));
				
				//driver.findElement(By.xpath("//select[@id=\\"type\\"]/option[2]")).cl
				
				List<WebElement> ls = Select.findElements(By.tagName("option"));
				//ls.Click();
				for (WebElement we : ls) {
					System.out.println(we);
					if("cat".equals(we.getText())) {
						we.click();
					Thread.sleep(2000);
					driver.switchTo().defaultContent();
					
				}
				}*/
				
				
				WebElement dateBox = driver.findElement(By.xpath("//input[@id='birthDate']"));
				
				dateBox.sendKeys("2020/10/15");
				dateBox.sendKeys(Keys.TAB);
				
				
				driver.findElement(By.xpath("//select[@id='type']/option[3]")).click();
				Thread.sleep(3000);
				
				
				//driver.findElement(By.xpath("//input[@id='birthDate']")).sendKeys("2020/10/15");
				Thread.sleep(5000);
				
				driver.findElement(By.xpath("//button[text()='Add Pet']")).click();
				
				Thread.sleep(5000);
				driver.close();
				
	  }
	}


}
