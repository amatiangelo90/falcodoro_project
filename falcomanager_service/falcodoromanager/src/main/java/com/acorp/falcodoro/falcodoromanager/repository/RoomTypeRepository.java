package com.acorp.falcodoro.falcodoromanager.repository;

import com.acorp.falcodoro.falcodoromanager.models.RoomTypeModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoomTypeRepository extends JpaRepository<RoomTypeModel, Long> {

    @Query("SELECT r from RoomTypeModel r WHERE r.typeName=?1")
    Optional<RoomTypeModel> findByTypeName(String type);

}
