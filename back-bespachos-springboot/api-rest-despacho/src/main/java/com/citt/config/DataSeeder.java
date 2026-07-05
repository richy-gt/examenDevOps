package com.citt.config;

import com.citt.persistence.entity.Despacho;
import com.citt.persistence.repository.DespachoRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
@Profile("!test")
public class DataSeeder implements CommandLineRunner {
    private final DespachoRepository despachoRepository;

    public DataSeeder(DespachoRepository despachoRepository) {
        this.despachoRepository = despachoRepository;
    }

    @Override
    public void run(String... args) {
        if (despachoRepository.count() == 0) {
            Despacho despacho = new Despacho();
            despacho.setFechaDespacho(LocalDate.now());
            despacho.setPatenteCamion("ABC123");
            despacho.setIntento(1);
            despacho.setIdCompra(1L);
            despacho.setDireccionCompra("Av. Siempre Viva 123");
            despacho.setValorCompra(150000L);
            despacho.setDespachado(true);
            despachoRepository.save(despacho);
        }
    }
}
