// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.acme.karcsi.controller;

import com.acme.karcsi.controller.ApplicationConversionServiceFactoryBean;
import com.acme.karcsi.domain.Food;
import com.acme.karcsi.repository.FoodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;

privileged aspect ApplicationConversionServiceFactoryBean_Roo_ConversionService {
    
    declare @type: ApplicationConversionServiceFactoryBean: @Configurable;
    
    @Autowired
    FoodRepository ApplicationConversionServiceFactoryBean.foodRepository;
    
    public Converter<Food, String> ApplicationConversionServiceFactoryBean.getFoodToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<com.acme.karcsi.domain.Food, java.lang.String>() {
            public String convert(Food food) {
                return new StringBuilder().append(food.getName()).append(' ').append(food.getDescription()).append(' ').append(food.getPrice()).toString();
            }
        };
    }
    
    public Converter<Long, Food> ApplicationConversionServiceFactoryBean.getIdToFoodConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, com.acme.karcsi.domain.Food>() {
            public com.acme.karcsi.domain.Food convert(java.lang.Long id) {
                return foodRepository.findOne(id);
            }
        };
    }
    
    public Converter<String, Food> ApplicationConversionServiceFactoryBean.getStringToFoodConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, com.acme.karcsi.domain.Food>() {
            public com.acme.karcsi.domain.Food convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Food.class);
            }
        };
    }
    
    public void ApplicationConversionServiceFactoryBean.installLabelConverters(FormatterRegistry registry) {
        registry.addConverter(getFoodToStringConverter());
        registry.addConverter(getIdToFoodConverter());
        registry.addConverter(getStringToFoodConverter());
    }
    
    public void ApplicationConversionServiceFactoryBean.afterPropertiesSet() {
        super.afterPropertiesSet();
        installLabelConverters(getObject());
    }
    
}