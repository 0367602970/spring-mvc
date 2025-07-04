package vn.nguyentoan.laptopshop.service;

import java.util.List;
import java.util.Optional;

import vn.nguyentoan.laptopshop.domain.User;
import vn.nguyentoan.laptopshop.domain.dto.ProductCriteriaDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import vn.nguyentoan.laptopshop.domain.Cart;
import vn.nguyentoan.laptopshop.domain.CartDetail;
import vn.nguyentoan.laptopshop.domain.Order;
import vn.nguyentoan.laptopshop.domain.OrderDetail;
import vn.nguyentoan.laptopshop.domain.Product;
import vn.nguyentoan.laptopshop.repository.CartDetailRepository;
import vn.nguyentoan.laptopshop.repository.CartRepository;
import vn.nguyentoan.laptopshop.repository.OrderDetailRepository;
import vn.nguyentoan.laptopshop.repository.OrderRepository;
import vn.nguyentoan.laptopshop.repository.ProductReposity;
import vn.nguyentoan.laptopshop.service.specification.ProductSpecs;

@Service
public class ProductService {
    private final ProductReposity productReposity;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductReposity productReposity,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productReposity = productReposity;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Page<Product> fetchProducts(Pageable pageable) {
        return this.productReposity.findAll(pageable);
    }

    public Page<Product> fetchProductsWithSpec(ProductCriteriaDTO productCriteriaDTO, Pageable pageable) {
        if (productCriteriaDTO.getTarget() == null && productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPrice() == null) {
            return this.productReposity.findAll(pageable);
        }

        Specification<Product> combinedSpec = Specification.where(null);
        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            Specification<Product> currentSpec = ProductSpecs.matchListTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpec = ProductSpecs.matchListFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }
        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpec = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }

        return this.productReposity.findAll(combinedSpec, pageable);
    }

    // case6
    public Specification<Product> buildPriceSpecification(List<String> price) {
        Specification<Product> combinedSpec = Specification.where(null);
        for (String p : price) {
            double min = 0;
            double max = 0;
            switch (p) {
                case "duoi-10-trieu":
                    min = 1000000;
                    max = 10000000;
                    break;
                case "10-15-trieu":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-20-trieu":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "tren-20-trieu":
                    min = 20000000;
                    max = 500000000;
                    break;
            }

            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        return combinedSpec;
    }

    public List<Product> findAllProductsByName(String name) {
        return this.productReposity.findByName(name);
    }

    public Optional<Product> getProductByID(long id) {
        return this.productReposity.findById(id);
    }

    public void deleteProduct(long id) {
        this.productReposity.deleteById(id);
    }

    public Product handleSaveProduct(Product product) {
        Product rs = this.productReposity.save(product);
        return rs;
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);

            if (cart == null) {
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);

                cart = this.cartRepository.save(otherCart);
            }

            Optional<Product> productOptional = this.productReposity.findById(productId);
            if (productOptional.isPresent()) {
                Product realProduct = productOptional.get();

                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);

                if (oldDetail == null) {
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(realProduct);
                    cartDetail.setPrice(realProduct.getPrice());
                    cartDetail.setQuantity(quantity);
                    this.cartDetailRepository.save(cartDetail);

                    // update cart sum
                    int s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(oldDetail);
                }
            }
        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleDeleteCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> optionalCartDetail = this.cartDetailRepository.findById(cartDetailId);
        if (optionalCartDetail.isPresent()) {
            CartDetail cartDetail = optionalCartDetail.get();
            Cart currentCart = cartDetail.getCart();
            this.cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getSum() > 1) {
                int newSum = currentCart.getSum() - 1;
                currentCart.setSum(newSum);
                session.setAttribute("sum", newSum);
                this.cartRepository.save(currentCart);
            } else {
                this.cartRepository.delete(currentCart);
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail detail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(detail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(detail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    @Transactional
    public void handlePlaceOrder(User user, HttpSession session, String receiverName, String receiverAddress,
            String receiverPhone) {
        // Lấy Cart bằng User
        Cart cart = this.cartRepository.findByUser(user);
        System.out.println("Cart retrieved: " + (cart != null ? "ID=" + cart.getId() : "null"));
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            System.out.println("CartDetails size: " + (cartDetails != null ? cartDetails.size() : 0));
            if (cartDetails != null) {
                // Tạo Order
                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setStatus("PENDING");

                double sum = 0;
                for (CartDetail cartDetail : cartDetails) {
                    sum += Double.parseDouble(cartDetail.getPrice());
                }
                order.setTotalPrice(sum);
                order = this.orderRepository.save(order);
                System.out.println("Order saved with ID: " + order.getId());

                // Tạo OrderDetail
                for (CartDetail cartDetail : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cartDetail.getProduct());
                    orderDetail.setPrice(cartDetail.getPrice());
                    orderDetail.setQuantity(cartDetail.getQuantity());
                    this.orderDetailRepository.save(orderDetail);
                }

            }
            // Xóa CartDetail và Cart
            cart.getCartDetails().clear(); // Gỡ liên kết từ Hibernate
            cart.setSum(0); // Cập nhật sum về 0
            this.cartRepository.save(cart);

            // Cập nhật session sum
            session.setAttribute("sum", 0);
        }
    }
}
