package vn.nguyentoan.laptopshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import jakarta.persistence.criteria.Expression;
import vn.nguyentoan.laptopshop.domain.Product;
import vn.nguyentoan.laptopshop.domain.Product_;

public class ProductSpecs {
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    }

    public static Specification<Product> minPrice(double price) {
        return (root, query, criteriaBuilder) -> {
            Expression<Double> priceExpression = criteriaBuilder.toDouble(root.get(Product_.PRICE));
            return criteriaBuilder.ge(priceExpression, price);
        };
    }

    public static Specification<Product> maxPrice(double price) {
        return (root, query, criteriaBuilder) -> {
            Expression<Double> priceExpression = criteriaBuilder.toDouble(root.get(Product_.PRICE));
            return criteriaBuilder.le(priceExpression, price);
        };
    }

    public static Specification<Product> matchFactory(String factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Product_.FACTORY), factory);
    }

    public static Specification<Product> matchListFactory(List<String> factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
    }

    public static Specification<Product> matchListTarget(List<String> target) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.TARGET)).value(target);
    }

    public static Specification<Product> matchPrice(double min, double max) {
        return (root, query, criteriaBuilder) -> {
            Expression<Double> priceExpression = criteriaBuilder.toDouble(root.get(Product_.PRICE));
            return criteriaBuilder.and(
                    criteriaBuilder.gt(priceExpression, min),
                    criteriaBuilder.le(priceExpression, max));
        };
    }

    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> {
            Expression<Double> priceExpression = criteriaBuilder.toDouble(root.get(Product_.PRICE));
            return criteriaBuilder.between(priceExpression, min, max);
        };
    }
}
