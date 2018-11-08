package com.utils;

import com.dao.beans.StudyPlan;
import com.service.StudyService;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;
import java.util.stream.Stream;

public class DemoUtils {

    public static void main(String args[]) {
        /*List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9);
        System.out.println("输出所有数据:");
        eval(list, n -> true);
        System.out.println("输出所有偶数:");
        eval(list, n -> n % 2 == 0);
        System.out.println("输出大于 3 的所有数字:");
        eval(list, n -> n > 3);*/
        String[] array = {"a", "b", "c", "d", "e"};

        //Arrays.stream
        Stream<String> stream1 = Arrays.stream(array);
        stream1.forEach(x -> System.out.println(x));

        //Stream.of
        Stream<String> stream2 = Stream.of(array);
        stream2.forEach(x -> System.out.println(x));

        Stream<Integer> s1 = Stream.of(12, 4, 123, 9, 15);
        Stream<Integer> s2 = s1.filter((integer) -> integer > 10);
        s2.forEach(x -> System.out.println(x));

    }

    public static void eval(List<Integer> list, Predicate<Integer> predicate) {
        for (Integer n : list) {
            if (predicate.test(n)) {
                System.out.print(n + " ");
            }
        }
        System.out.println("");
    }


}
