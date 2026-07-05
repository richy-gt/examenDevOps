package com.citt.config;

import com.citt.persistence.entity.Venta;
import com.citt.persistence.repository.VentaRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
@Profile("!test")
public class DataSeeder implements CommandLineRunner {
    private final VentaRepository ventaRepository;

    public DataSeeder(VentaRepository ventaRepository) {
        this.ventaRepository = ventaRepository;
    }

    @Override
    public void run(String... args) {
        if (ventaRepository.count() == 0) {
            Venta venta = Venta.builder()
                    .direccionCompra("Av. Siempre Viva 123")
                    .valorCompra(150000)
                    .fechaCompra(LocalDate.now().minusDays(2))
                    .despachoGenerado(false)
                    .build();
            ventaRepository.save(venta);
        }
    }
}
