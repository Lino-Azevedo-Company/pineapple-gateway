package com.pineapple.gateway.infra.filter;

import com.pineapple.gateway.infra.context.UserContext;
import com.pineapple.gateway.infra.context.UserContextHolder;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Component
@NoArgsConstructor
public class UserContextFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        UserContextHolder
                .getContext()
                .setCorrelationId(request.getHeader(UserContext.CORRELATION_ID));
        UserContextHolder
                .getContext()
                .setUserId(request.getHeader(UserContext.USER_ID));
        UserContextHolder
                .getContext()
                .setAuthToken(request.getHeader(UserContext.AUTH_TOKEN));
        UserContextHolder
                .getContext()
                .setOrgId(request.getHeader(UserContext.ORG_ID));

        filterChain.doFilter(servletRequest, servletResponse);
    }
}
