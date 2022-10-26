package com.acorp.falcodoro.falcodoromanager.service;

import com.acorp.falcodoro.falcodoromanager.models.RoomTypeModel;
import com.acorp.falcodoro.falcodoromanager.repository.RoomTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class RoomTypeService {

    @Autowired
    private RoomTypeRepository roomTypeRepository;

    public List<RoomTypeModel> retrieveAll() {
        return roomTypeRepository.findAll();
    }

    public void delete(RoomTypeModel roomTypeModel) {
        roomTypeRepository.delete(roomTypeModel);
    }

    public void addRoomType(RoomTypeModel roomTypeModel) throws IllegalStateException{
        if(roomTypeRepository.findByTypeName(roomTypeModel.getTypeName()).isPresent())
            throw new IllegalStateException("Error. RoomType name already taken. Choose different name");
        roomTypeRepository.save(roomTypeModel);
    }

    @Transactional
    public void updateRoomType(RoomTypeModel roomTypeModel) {


        RoomTypeModel roomTypeModelRetrieved = roomTypeRepository.findById(roomTypeModel.getRoomTypeId()).orElseThrow(()
                -> new IllegalStateException("RoomType with id "+ roomTypeModel.getRoomTypeId()+" not found"));

        if(roomTypeModel.getTypeName() != null
                && roomTypeModel.getTypeName().length() > 0
                && !Objects.equals(roomTypeModel.getTypeName(), roomTypeModelRetrieved.getTypeName())){
            Optional<RoomTypeModel> optionalUserModel = roomTypeRepository.findByTypeName(roomTypeModel.getTypeName());
            if(optionalUserModel.isPresent()){
                throw new IllegalStateException("Error. Type " + roomTypeModel.getTypeName() + " is already configured.");
            }
            roomTypeModelRetrieved.setTypeName(roomTypeModel.getTypeName());
        }

        if(roomTypeModel.getGuests() <= 0){
            throw new IllegalStateException("Error. Set at least 1 guest to configure the room type");
        }else{
            roomTypeModelRetrieved.setGuests(roomTypeModel.getGuests());
        }

        if(roomTypeModel.getBedType() == null && roomTypeModel.getBedType().toString().length() == 0){
            throw new IllegalStateException("Error. Choose bed type to configure room type");
        }else{
            roomTypeModelRetrieved.setBedType(roomTypeModel.getBedType());
        }
    }

    public void deleteById(long id) {
        roomTypeRepository.deleteById(id);
    }
}
