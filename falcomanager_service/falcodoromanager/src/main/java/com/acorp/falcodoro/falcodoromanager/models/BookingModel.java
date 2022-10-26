package com.acorp.falcodoro.falcodoromanager.models;

import org.apache.tomcat.jni.Local;

import javax.persistence.*;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.Date;
import java.util.Set;

@Entity(name = "BookingModel")
@Table(name = "BOOKING",
        uniqueConstraints=
        @UniqueConstraint(columnNames={"room_id", "booking_date"}))
public class BookingModel {

    @Id
    @SequenceGenerator(
            name = "booking_id",
            sequenceName = "booking_id",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "booking_id"
    )
    @Column(
            name = "booking_id",
            updatable = false
    )
    private long bookingId;
    private String customerName;
    private String code;
    @Column(
            name = "room_id"
    )
    private int roomId;
    private int nightNumbers;


    @Column(name = "booking_date")
    private String bookingDate;

    private BookingSource sourceBooking;

    private String details;

    private PaidEnum paid;

    @Column(name = "deposit")
    private String deposit;

    @Column(name = "guests", nullable = false)
    private int guests;

    @Column(name = "total")
    private String total;


    public BookingModel() {
    }

    public long getBookingId() {
        return bookingId;
    }

    public void setBookingId(long bookingId) {
        this.bookingId = bookingId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getNightNumbers() {
        return nightNumbers;
    }

    public void setNightNumbers(int nightNumbers) {
        this.nightNumbers = nightNumbers;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public BookingSource getSourceBooking() {
        return sourceBooking;
    }

    public void setSourceBooking(BookingSource sourceBooking) {
        this.sourceBooking = sourceBooking;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public PaidEnum getPaid() {
        return paid;
    }

    public void setPaid(PaidEnum paid) {
        this.paid = paid;
    }

    public String getDeposit() {
        return deposit;
    }

    public void setDeposit(String deposit) {
        this.deposit = deposit;
    }

    public int getGuests() {
        return guests;
    }

    public void setGuests(int guests) {
        this.guests = guests;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public BookingModel(String customerName, String code, int roomId, int nightNumbers, String bookingDate, BookingSource sourceBooking, String details, PaidEnum paid, String deposit, int guests, String total) {
        this.customerName = customerName;
        this.code = code;
        this.roomId = roomId;
        this.nightNumbers = nightNumbers;
        this.bookingDate = bookingDate;
        this.sourceBooking = sourceBooking;
        this.details = details;
        this.paid = paid;
        this.deposit = deposit;
        this.guests = guests;
        this.total = total;
    }
}
