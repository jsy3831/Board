//package kr.sm2m.noticeBoard;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Bean;
//import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.builders.WebSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//
//import kr.sm2m.noticeBoard.main.service.impl.MainServiceImpl;
//
//@EnableWebSecurity
//public class SecurityConfig  extends WebSecurityConfigurerAdapter {
//	
//	@Autowired
//	MainServiceImpl mainServiceImpl;
//	
//	@Bean
//	public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder();
//    }
	
//	@Override
//    public void configure(WebSecurity web) throws Exception
//    {
//        // static 디렉터리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
//        web.ignoring().antMatchers("/css/**", "/js/**", "/img/**", "/scss/**", "/vendor/**");
//    }
//	
//	@Override
//	protected void configure(HttpSecurity http) throws Exception
//	{
//		http.authorizeRequests()
////			.antMatchers("/admin/**").hasRole("ADMIN")
//			.antMatchers("/**").permitAll();
//			
////			.and()
////				.loginPage("/user/login")
////				.permitAll();
//			
//
//		super.configure(http);
//        http.csrf().disable(); // csrf 설정끄기
//	}
//	
//	@Autowired
//	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//	  auth.userDetailsService(mainServiceImpl).passwordEncoder(passwordEncoder());
//	}
	
//}
