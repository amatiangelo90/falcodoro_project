package com.acorp.falcodoro.falcodoromanager.service;

import com.acorp.falcodoro.falcodoromanager.models.BookingModel;
import com.acorp.falcodoro.falcodoromanager.repository.BookingRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class BookingService {

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

    Logger logger = LoggerFactory.getLogger(BookingService.class);

    @Autowired
    private BookingRepository bookingRepository;


    @Transactional
    public void addNewBooking(BookingModel bookingModel) {

        try {
            List<String> wantedDatesToReserve = new ArrayList<>();
            for(int i = 0; i < bookingModel.getNightNumbers(); i++){
                try {
                    if(i != 0){
                        wantedDatesToReserve.add(sdf.format(addDays(sdf.parse(bookingModel.getBookingDate()), i)));
                    }

                } catch (ParseException e) {
                    throw new IllegalStateException("Errore di sistema. Non dovremme mai capitare questo ma se è capitato contattare quel coglione di Amati");
                }
            }
            List<BookingModel> onWantedRoomReservationsList = bookingRepository.findByRoomId(bookingModel.getRoomId());


            for(int i = 0; i < onWantedRoomReservationsList.size(); i++){
                if(wantedDatesToReserve.contains(onWantedRoomReservationsList.get(i).getBookingDate())){
                    throw new IllegalStateException("Errore! Esiste già una prenotazione per le date selezionate.");
                }
            }

            bookingRepository.save(new BookingModel(
                    bookingModel.getCustomerName(),
                    bookingModel.getCode(),
                    bookingModel.getRoomId(),
                    bookingModel.getNightNumbers(),
                    sdf.format(sdf.parse(bookingModel.getBookingDate())),
                    bookingModel.getSourceBooking(),
                    bookingModel.getDetails(),
                    bookingModel.getPaid(),
                    bookingModel.getDeposit(),
                    bookingModel.getGuests(),
                    bookingModel.getTotal()
                    ));

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public void delete(BookingModel bookingModel){
        bookingRepository.deleteById(bookingModel.getBookingId());
    }

    public void deleteById(long id){
        bookingRepository.deleteById(id);
    }

    @Transactional
    public void deleteByCode(String code){
        bookingRepository.deleteByCode(code);
    }

    public List<BookingModel> findByCode(String code) {
        return bookingRepository.findByCode(code);
    }


    public static Date addDays(Date date, int days)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, days);
        return cal.getTime();
    }

    public List<BookingModel> findAll() {
        return bookingRepository.findAll();
    }

    @Transactional
    public void addDay(long bookid, int roomid, String reservationdate, int nights) {
        try {
            Date date = addDays(sdf.parse(reservationdate), nights + 1);

            List<BookingModel> bookingModels = bookingRepository.selectBookingByRoomIdAndDate(roomid, sdf.format(date));

            if(bookingModels.isEmpty()){
                BookingModel retrievedBooking = bookingRepository.getById(bookid);
                retrievedBooking.setNightNumbers(nights + 1);
            }else{
                throw new IllegalStateException("Errore. Non puoi aggiungere notti alla prenotazione");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

    }

    @Transactional
    public void update(BookingModel bookingModel) {
        List<BookingModel> updatingBookModelListForCodeBooking = bookingRepository.findByCode(bookingModel.getCode());

        if(updatingBookModelListForCodeBooking.isEmpty()){
            throw new IllegalStateException("Errore. Non ho trovato prenotazioni da aggiornare");

        }else{
            List<String> wantedDatesToReserve = new ArrayList<>();
            for(int i = 0; i < bookingModel.getNightNumbers(); i++){
                try {
                    if(i != 0){
                        wantedDatesToReserve.add(sdf.format(addDays(sdf.parse(bookingModel.getBookingDate()), i)));
                    }

                } catch (ParseException e) {
                    throw new IllegalStateException("Errore di sistema. Non dovremme mai capitare questo ma se è capitato contattare quel coglione di Amati");
                }
            }
            List<BookingModel> onWantedRoomReservationsList = bookingRepository.findByRoomId(bookingModel.getRoomId());


            for(int i = 0; i < onWantedRoomReservationsList.size(); i++){
                if(wantedDatesToReserve.contains(onWantedRoomReservationsList.get(i).getBookingDate())){
                    throw new IllegalStateException("Errore! Esiste già una prenotazione per le date selezionate.");
                }
            }

            if(updatingBookModelListForCodeBooking.get(0).getNightNumbers() != bookingModel.getNightNumbers())
                updatingBookModelListForCodeBooking.get(0).setNightNumbers(bookingModel.getNightNumbers());

            if(updatingBookModelListForCodeBooking.get(0).getPaid() != bookingModel.getPaid())
                updatingBookModelListForCodeBooking.get(0).setPaid(bookingModel.getPaid());

            if(updatingBookModelListForCodeBooking.get(0).getPaid() != bookingModel.getPaid())
                updatingBookModelListForCodeBooking.get(0).setPaid(bookingModel.getPaid());

            if(updatingBookModelListForCodeBooking.get(0).getDeposit() != bookingModel.getDeposit())
                updatingBookModelListForCodeBooking.get(0).setDeposit(bookingModel.getDeposit());

            if(updatingBookModelListForCodeBooking.get(0).getDetails() != bookingModel.getDetails())
                updatingBookModelListForCodeBooking.get(0).setDetails(bookingModel.getDetails());

            if(updatingBookModelListForCodeBooking.get(0).getGuests() != bookingModel.getGuests())
                updatingBookModelListForCodeBooking.get(0).setGuests(bookingModel.getGuests());

            if(updatingBookModelListForCodeBooking.get(0).getCustomerName() != bookingModel.getCustomerName())
                updatingBookModelListForCodeBooking.get(0).setCustomerName(bookingModel.getCustomerName());

            if(updatingBookModelListForCodeBooking.get(0).getSourceBooking() != bookingModel.getSourceBooking())
                updatingBookModelListForCodeBooking.get(0).setSourceBooking(bookingModel.getSourceBooking());

            if(updatingBookModelListForCodeBooking.get(0).getTotal() != bookingModel.getTotal())
                updatingBookModelListForCodeBooking.get(0).setTotal(bookingModel.getTotal());

        }
    }

    private void getBusyDateListFromRoomId(List<BookingModel> onWantedRoomReservationsList, Set<String> busyDate) {
        for(int i = 0; i < onWantedRoomReservationsList.size(); i++){

            for(int night = 0; night < onWantedRoomReservationsList.get(i).getNightNumbers(); night ++){

                try {
                    Date currentDate = sdf.parse(onWantedRoomReservationsList.get(i).getBookingDate());
                    busyDate.add(sdf.format(addDays(currentDate, night)));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

        }
    }


    @Transactional
    public void moveReservation(BookingModel bookingModel) {
        List<BookingModel> updatingBookModel = bookingRepository.findByCode(bookingModel.getCode());
        List<BookingModel> onWantedRoomReservationsList = bookingRepository.findByRoomId(bookingModel.getRoomId());


        Set<String> busyDate = new HashSet<>();

        getBusyDateListFromRoomId(onWantedRoomReservationsList, busyDate);


        if(updatingBookModel.isEmpty()){
            throw new IllegalStateException("Errore. Non ho trovato prenotazioni da aggiornare");
        }else if(reservationForTheSameRoomOnCommonDateAlreadyExist(busyDate, bookingModel)){
            throw new IllegalStateException("Errore. Non puoi spostare la prenotazione perche i giorni selezionati per questa stanza risultano già occupati");
        }else {
            if(updatingBookModel.get(0).getRoomId() != bookingModel.getRoomId())
                updatingBookModel.get(0).setRoomId(bookingModel.getRoomId());

            if(updatingBookModel.get(0).getBookingDate() != bookingModel.getBookingDate())
                updatingBookModel.get(0).setBookingDate(bookingModel.getBookingDate());
        }

    }

    private boolean reservationForTheSameRoomOnCommonDateAlreadyExist(Set<String> busyDate, BookingModel bookingModel) {

        for(int i = 0; i < bookingModel.getNightNumbers(); i++){
            try {
                if(busyDate.contains(sdf.format(addDays(sdf.parse(bookingModel.getBookingDate()), i)))){
                    return true;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return false;

    }

}
