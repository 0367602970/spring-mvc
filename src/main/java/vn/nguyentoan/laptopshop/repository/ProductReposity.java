package vn.nguyentoan.laptopshop.repository;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import vn.nguyentoan.laptopshop.domain.Product;

@Repository
public interface ProductReposity extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    @SuppressWarnings("unchecked")
    Product save(Product product);

    List<Product> findAll();

    List<Product> findByName(String name);

    Optional<Product> findById(long id);

    void deleteById(long id);

    Page<Product> findAll(Pageable page);

    Page<Product> findAll(Specification<Product> spec, Pageable page);
}
