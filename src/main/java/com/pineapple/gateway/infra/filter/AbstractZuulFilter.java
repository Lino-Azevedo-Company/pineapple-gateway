package com.pineapple.gateway.infra.filter;

import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;

import javax.servlet.http.HttpServletRequest;

public abstract class AbstractZuulFilter extends ZuulFilter {
    protected static final String CORRELATION_ID    = "tmx-correlation-id";
    protected static final String AUTH_TOKEN        = "Authorization";
    protected static final String USER_ID           = "tmx-user-id";
    protected static final String ORG_ID            = "tmx-org-id";
    protected static final String PRE_FILTER_TYPE   = "pre";
    protected static final String POST_FILTER_TYPE  = "post";
    protected static final String ROUTE_FILTER_TYPE = "route";

    protected String getCorrelationId(){
        RequestContext context = RequestContext.getCurrentContext();
        HttpServletRequest request = context.getRequest();
        return request.getHeader(CORRELATION_ID) != null ?
                request.getHeader(CORRELATION_ID) :
                context.getZuulRequestHeaders().get(CORRELATION_ID);
    }

    protected void setCorrelationId(String correlationId){
        RequestContext context = RequestContext.getCurrentContext();
        context.addZuulRequestHeader(CORRELATION_ID, correlationId);
    }

    protected   final String getOrgId(){
        RequestContext context = RequestContext.getCurrentContext();
        if (context.getRequest().getHeader(ORG_ID) !=null) {
            return context.getRequest().getHeader(ORG_ID);
        } else {
            return context.getZuulRequestHeaders().get(ORG_ID);
        }
    }

    protected void setOrgId(String orgId){
        RequestContext context = RequestContext.getCurrentContext();
        context.addZuulRequestHeader(ORG_ID,  orgId);
    }

    protected final String getUserId(){
        RequestContext context = RequestContext.getCurrentContext();
        if (context.getRequest().getHeader(USER_ID) !=null) {
            return context.getRequest().getHeader(USER_ID);
        } else {
            return context.getZuulRequestHeaders().get(USER_ID);
        }
    }

    protected void setUserId(String userId){
        RequestContext context = RequestContext.getCurrentContext();
        context.addZuulRequestHeader(USER_ID,  userId);
    }

    protected final String getAuthToken(){
        RequestContext context = RequestContext.getCurrentContext();
        return context.getRequest().getHeader(AUTH_TOKEN);
    }

    protected void setAuthToken(String authToken){
        RequestContext context = RequestContext.getCurrentContext();
        context.addZuulRequestHeader(AUTH_TOKEN,  authToken);
    }

    protected String getServiceId(){
        RequestContext context = RequestContext.getCurrentContext();

        if (context.get("serviceId") == null) {
            return "";
        }
        return context.get("serviceId").toString();
    }

    protected boolean isCorrelationIdPresent() {
        return getCorrelationId() != null;
    }

    protected String generateCorrelationId() {
        return java.util.UUID.randomUUID().toString();
    }

}
