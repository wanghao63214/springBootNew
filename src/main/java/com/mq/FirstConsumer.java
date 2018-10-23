package com.mq;
/*import org.springframework.amqp.rabbit.annotation.RabbitListener;*/
import org.springframework.stereotype.Component;

/**
 * 消息消费者1
 * @author zhuzhe
 * @date 2018/5/25 17:32
 * @email 1529949535@qq.com
 */
@Component
public class FirstConsumer {

/*    @RabbitListener(queues = {"first-queue"}, containerFactory = "rabbitListenerContainerFactory")
    public void handleMessage_first(String message) throws Exception {
        System.out.println("first-queue");
        // 处理消息
        System.out.println("FirstConsumer {} handleMessage :"+message);
    }

    @RabbitListener(queues = {"second-queue"}, containerFactory = "rabbitListenerContainerFactory")
    public void handleMessage_second(String message) throws Exception {
        System.out.println("second-queue");
        // 处理消息
        System.out.println("FirstConsumer {} handleMessage :"+message);
    }*/
}