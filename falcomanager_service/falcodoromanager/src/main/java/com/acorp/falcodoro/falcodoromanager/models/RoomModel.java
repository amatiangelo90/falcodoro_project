package com.acorp.falcodoro.falcodoromanager.models;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;


@Entity(name = "RoomModel")
@Table(name = "ROOM")
public class RoomModel implements Serializable {
    @Id
    @SequenceGenerator(
            name = "room_id",
            sequenceName = "room_id",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "room_id"
    )
    @Column(
            name = "room_id",
            updatable = false
    )
    private long roomId;
    @Column(
            name = "roomnumber"
    )
    private int roomNumber;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="typename")
    private RoomTypeModel roomTypeModel;

    public RoomModel() {}


    public long getRoomId() {
        return roomId;
    }

    public void setRoomId(long roomId) {
        this.roomId = roomId;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public RoomTypeModel getRoomTypeModel() {
        return roomTypeModel;
    }

    public void setRoomTypeModel(RoomTypeModel roomTypeModel) {
        this.roomTypeModel = roomTypeModel;
    }
}
