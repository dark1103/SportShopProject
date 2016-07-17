using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SportShopProject.Models;

namespace SportShopProject.WebUI.Models
{
    public class CartViewModel
    {
        public class OrderedProductViewModel
        {
            public int Count { get; set; }
            public int ProductId { get; set; }
            public Product Product { get; set; }
            public OrderedProductViewModel()
            {

            }
            public OrderedProductViewModel(OrderedProduct product)
            {
                Count = product.Count;
                ProductId = product.ProductId;
                Product = product.Product;
            }
            public OrderedProduct ToOrderedProduct()
            {
                return new OrderedProduct() { Count = this.Count, ProductId = this.Product.Id };
            }
        }
        public int OrderId { get; set; }
        public int ClientId { get; set; }
        public int Discount { get; set; }
        public List<OrderedProductViewModel> OrderedProducts { get; set; }
        public CartViewModel()
        {
            OrderedProducts = new List<OrderedProductViewModel>();
        }
        public CartViewModel(Order product)
        {
            OrderedProducts = product.OrderedProducts.ToList().ConvertAll(p => new OrderedProductViewModel(p));
        }
        public Order ToOrder()
        {
            List<OrderedProduct> products = OrderedProducts.ConvertAll(p => p.ToOrderedProduct());
            Order order = new Order();
            if(products.Count > 0) order.OrderedProducts = products;
            if(ClientId != 0) order.ClientId = this.ClientId;
            order.Discount = this.Discount;
            return order;
        }
    }
}