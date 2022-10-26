package com.acorp.falcodoro.falcodoromanager.controller;

import com.acorp.falcodoro.falcodoromanager.models.RoomTypeModel;
import com.acorp.falcodoro.falcodoromanager.service.RoomTypeService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Api
@RestController
@RequestMapping(path = "api/v1/roomtype")
public class RoomTypeController {

    @Autowired
    private RoomTypeService roomTypeService;

    @GetMapping(path = "/findall")
    public List<RoomTypeModel> getAllRoomTypes(){
        return roomTypeService.retrieveAll();
    }

    @DeleteMapping(path = "/delete")
    public void deleteRoomType(RoomTypeModel roomTypeModel){
        roomTypeService.delete(roomTypeModel);
    }

    @PostMapping(path = "/save")
    public void insertRoomType(RoomTypeModel roomTypeModel){
        roomTypeService.addRoomType(roomTypeModel);
    }

    @PutMapping(path = "/update")
    public void updateRoomType(RoomTypeModel roomTypeModel){
        roomTypeService.updateRoomType(roomTypeModel);
    }

    @GetMapping(path = "/deletebyid/{id}")
    public void deleteRoomTypeById(@PathVariable("id") long id){
        roomTypeService.deleteById(id);
    }

}
