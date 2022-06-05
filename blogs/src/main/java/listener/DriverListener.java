package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DriverListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce)  { // 톰캣 실행시 

    	try {
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 완료");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    	
    
    }
	
}
