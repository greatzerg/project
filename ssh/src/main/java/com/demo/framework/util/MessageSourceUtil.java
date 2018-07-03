package com.demo.framework.util;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

public class MessageSourceUtil extends ReloadableResourceBundleMessageSource{
	public static void getLangType(HttpServletRequest request, String langType){
		if(langType.equals("zh")){
            Locale locale = new Locale("zh", "CN"); 
            request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME,locale); 
        }
        else if(langType.equals("en")){
            Locale locale = new Locale("en", "US"); 
            request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME,locale);
        }
        else{ 
            request.getSession().setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME,LocaleContextHolder.getLocale());
        }
	}
}
