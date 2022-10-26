package com.acorp.falcodoro.falcodoromanager.models;

import javax.persistence.*;
import java.io.Serializable;

@Entity(name = "RoomTypeModel")
@Table(
        name = "ROOM_TYPE"

)
public class RoomTypeModel implements Serializable {

    @Id
    @SequenceGenerator(
            name = "room_type_id",
            sequenceName = "room_type_id",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "room_type_id"
    )
    @Column(name = "room_type_id",
            updatable = false,
            insertable = false)
    private long roomTypeId;

    @Column(name = "typename",
            unique = true,
            nullable = false)
    private String typeName;

    private int guests;

    @Enumerated(EnumType.STRING)
    private BedType bedType;

    public RoomTypeModel() {
    }

    public RoomTypeModel(String typeName, int guests, BedType bedType) {
        this.typeName = typeName;
        this.guests = guests;
        this.bedType = bedType;
    }

    public BedType getBedType() {
        return bedType;
    }

    public void setBedType(BedType bedType) {
        this.bedType = bedType;
    }

    public long getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(long roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getGuests() {
        return guests;
    }

    public void setGuests(int guests) {
        this.guests = guests;
    }
}
