package com.acorp.falcodoro.falcodoromanager.controller;

import com.acorp.falcodoro.falcodoromanager.models.BookingModel;
import com.acorp.falcodoro.falcodoromanager.service.BookingService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api
@RestController
@RequestMapping(path = "api/v1/booking")
public class BookingController {

    private BookingService bookingService;

    @Autowired
    public BookingController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping(path = "/findall")
    public List<BookingModel> retrieveAll(){
        return bookingService.findAll();
    }

    @PostMapping(path = "/save")
    public void save(BookingModel bookingModel) { bookingService.addNewBooking(bookingModel); }

    @DeleteMapping(path = "/delete")
    public void delete(BookingModel bookingModel){
        bookingService.delete(bookingModel);
    }

    @GetMapping(path = "/deletebyid/{id}")
    public void deleteBookTypeById(@PathVariable("id") long id){
        bookingService.deleteById(id);
    }

    @GetMapping(path = "/deletebycode/{code}")
    public void deleteBookTypeById(@PathVariable("code") String code){
        bookingService.deleteByCode(code);
    }

    @GetMapping(path = "/findByCode/{code}")
    public List<BookingModel> findByCode(@PathVariable("code") String code){
        return bookingService.findByCode(code);
    }

    @PostMapping(path = "/adddaytobooking/{bookingid}/{roomid}/{reservationdate}/{nights}")
    public void addDay(@PathVariable("bookingid") long bookingid, @PathVariable("roomid") int roomid, @PathVariable("reservationdate") String reservationdate, @PathVariable("nights") int nights){
        bookingService.addDay(bookingid, roomid, reservationdate, nights);
    }
    @PostMapping(path = "/movereservation")
    public void moveReservation(BookingModel bookingModel){
        bookingService.moveReservation(bookingModel);
    }

    @PutMapping(path = "/update")
    public void updateBooking(BookingModel bookingModel){
        bookingService.update(bookingModel);
    }
}
