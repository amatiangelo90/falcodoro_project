package com.acorp.falcodoro.falcodoromanager.service;

import com.acorp.falcodoro.falcodoromanager.models.RoomModel;
import com.acorp.falcodoro.falcodoromanager.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Sort;
import javax.transaction.Transactional;
import java.util.List;

@Service
public class RoomService {

    private final RoomRepository roomRepository;

    @Autowired
    public RoomService(RoomRepository roomRepository) {
        this.roomRepository = roomRepository;
    }

    public List<RoomModel> retrieveAll() {
        return roomRepository.findAll(Sort.by("roomNumber").ascending());
    }

    public void save(RoomModel roomModel) {
        roomRepository.save(roomModel);
    }

    @Transactional
    public void update(RoomModel roomModel) {

        RoomModel roomRetrieved = roomRepository.findById(roomModel.getRoomId()).orElseThrow(()
                -> new IllegalStateException("Room with id "+ roomModel.getRoomId()+" not found"));

        if(roomRepository.findByRoomNumber(roomModel.getRoomNumber()).isPresent()){
            throw new IllegalStateException("Number room " + roomModel.getRoomNumber() + " is already taken. Choose different number");
        }else{
            roomRetrieved.setRoomNumber(new Integer(roomModel.getRoomNumber()));
        }

        if(roomModel.getRoomTypeModel() != null && roomModel.getRoomTypeModel().toString().length() != 0){
            roomRetrieved.setRoomTypeModel(roomModel.getRoomTypeModel());
        }

    }

    public void delete(RoomModel roomModel) {
        roomRepository.delete(roomModel);
    }

    public void deleteById(long id) {
        roomRepository.deleteById(id);
    }
}
