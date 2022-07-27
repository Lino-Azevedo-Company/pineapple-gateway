package com.pineapple.gateway.infra.filter;

import com.netflix.zuul.context.RequestContext;
import com.netflix.zuul.exception.ZuulException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;


@Component
@Slf4j
public class TrackingFilter extends AbstractZuulFilter {

    private static final int FILTER_ORDER = 1;
    private static final boolean SHOULD_FILTER = true;

    @Override
    public String filterType() {
        return PRE_FILTER_TYPE;
    }

    @Override
    public int filterOrder() {
        return FILTER_ORDER;
    }

    @Override
    public boolean shouldFilter() {
        return SHOULD_FILTER;
    }

    @Override
    public Object run() throws ZuulException {
        if (isCorrelationIdPresent()) {
            log.debug(String.format("tmx-correlation-id found in tracing filter %s", getCorrelationId()));
        } else {
            setCorrelationId(generateCorrelationId());
            log.debug(String.format("tmx-correlation-id generated in tracing filter %s", getCorrelationId()));
        }

        RequestContext context = RequestContext.getCurrentContext();
        log.debug(String.format("Processing incoming request for %s",context.getRequest().getRequestURI()));
        return null;
    }
}
