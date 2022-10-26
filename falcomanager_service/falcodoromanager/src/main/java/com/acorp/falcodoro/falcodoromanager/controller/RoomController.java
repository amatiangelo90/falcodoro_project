package com.acorp.falcodoro.falcodoromanager.controller;

import com.acorp.falcodoro.falcodoromanager.models.RoomModel;
import com.acorp.falcodoro.falcodoromanager.service.RoomService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api
@RestController
@RequestMapping(path = "api/v1/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping(path = "/findall")
    public List<RoomModel> retrieveAll(){
        return roomService.retrieveAll();
    }

    @PostMapping(path = "/save")
    public void insertRoom(RoomModel roomModel){
        roomService.save(roomModel);
    }

    @PutMapping(path = "/update")
    public void updateRoom(RoomModel roomModel){
        roomService.update(roomModel);
    }

    @DeleteMapping(path = "/delete")
    public void deleteRoom(RoomModel roomModel) { roomService.delete(roomModel);}

    @GetMapping(path = "/deletebyid/{id}")
    public void deleteRoomTypeById(@PathVariable("id") long id){
        roomService.deleteById(id);
    }
}
