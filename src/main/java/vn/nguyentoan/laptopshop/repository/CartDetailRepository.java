package vn.nguyentoan.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.nguyentoan.laptopshop.domain.Cart;
import vn.nguyentoan.laptopshop.domain.CartDetail;
import vn.nguyentoan.laptopshop.domain.Product;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    CartDetail findByCartAndProduct(Cart cart, Product product);

    void deleteByCartId(Long cartId);
}
