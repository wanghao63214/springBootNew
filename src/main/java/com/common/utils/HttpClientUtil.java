package com.common.utils;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


/**
 *
 */
public class HttpClientUtil {

    private static final Map<String, CloseableHttpClient> cache = new ConcurrentHashMap<>();

    public static CloseableHttpClient getHttpClient(String providerKey, int maxTotal) {
        CloseableHttpClient httpClient = cache.get(providerKey);
        if (httpClient == null) {
            httpClient = cache.get(providerKey);
            if (httpClient == null) {
                PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager();
                connectionManager.setMaxTotal(maxTotal);
                connectionManager.setDefaultMaxPerRoute(1000);
                HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
                httpClientBuilder.setConnectionManager(connectionManager);
                httpClient = httpClientBuilder.build();
                cache.put(providerKey, httpClient);
            }
        }
        return httpClient;
    }
    /**
     * @param httpClient
     * @param request
     * @return
     */
    public static CloseableHttpResponse sendRequest(CloseableHttpClient httpClient, HttpRequestBase request) throws IOException {
        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(request);
        } catch (ClientProtocolException e) {
            throw e;
        } catch (IOException e) {
            throw e;
        } finally {
            request.releaseConnection();
        }
        return response;
    }
}
