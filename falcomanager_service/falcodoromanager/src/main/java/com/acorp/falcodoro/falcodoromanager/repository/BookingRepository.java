package com.acorp.falcodoro.falcodoromanager.repository;

import com.acorp.falcodoro.falcodoromanager.models.BookingModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<BookingModel, Long> {

    @Query("SELECT r from BookingModel r WHERE r.code=?1")
    List<BookingModel> findByCode(String code);

    @Modifying
    @Query("DELETE from BookingModel r WHERE r.code = ?1")
    void deleteByCode(String code);

    @Query("SELECT r FROM BookingModel r WHERE r.roomId=?1 AND r.bookingDate=?2")
    List<BookingModel> selectBookingByRoomIdAndDate(int roomId, String date);

    @Query("SELECT r FROM BookingModel r WHERE r.roomId=?1")
    List<BookingModel> findByRoomId(int roomId);
}
