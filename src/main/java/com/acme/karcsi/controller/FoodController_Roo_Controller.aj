// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.acme.karcsi.controller;

import com.acme.karcsi.FoodType;
import com.acme.karcsi.controller.FoodController;
import com.acme.karcsi.domain.Food;
import com.acme.karcsi.repository.FoodRepository;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect FoodController_Roo_Controller {
    
    @Autowired
    FoodRepository FoodController.foodRepository;
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String FoodController.create(@Valid Food food, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, food);
            return "foods/create";
        }
        uiModel.asMap().clear();
        foodRepository.save(food);
        return "redirect:/foods/" + encodeUrlPathSegment(food.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String FoodController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Food());
        return "foods/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String FoodController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("food", foodRepository.findOne(id));
        uiModel.addAttribute("itemId", id);
        return "foods/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String FoodController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("foods", foodRepository.findAll(new org.springframework.data.domain.PageRequest(firstResult / sizeNo, sizeNo)).getContent());
            float nrOfPages = (float) foodRepository.count() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("foods", foodRepository.findAll());
        }
        return "foods/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String FoodController.update(@Valid Food food, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, food);
            return "foods/update";
        }
        uiModel.asMap().clear();
        foodRepository.save(food);
        return "redirect:/foods/" + encodeUrlPathSegment(food.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String FoodController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, foodRepository.findOne(id));
        return "foods/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String FoodController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Food food = foodRepository.findOne(id);
        foodRepository.delete(food);
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/foods";
    }
    
    void FoodController.populateEditForm(Model uiModel, Food food) {
        uiModel.addAttribute("food", food);
        uiModel.addAttribute("foodtypes", Arrays.asList(FoodType.values()));
    }
    
    String FoodController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
