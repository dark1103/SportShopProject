using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SportShopProject.Models;
using SportShopProject.WebUI.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace SportShopProject.Controllers
{
    public class CartController : Controller
    {
        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }
        public CartController()
        {
            
        }
        public CartController(ApplicationUserManager userManager)
        {
            UserManager = userManager;
        }
        // GET: Cart
        public ActionResult Index()
        {
            Order cart = GetCart();
            
            //return View("CartView", new CartViewModel() { OrderedProducts = cart.OrderedProducts.ToList() });
            return View("CartView", new CartViewModel(cart));
        }

        private Order GetCart(bool createIfNull = true)
        {
            Order cart = (Order)Session["Cart"];
            if(cart == null && createIfNull)
            {
                cart = new Order();
                Session["Cart"] = cart;
            }
            return cart;
        }
        private Client GetClient()
        {
            if (User.Identity.IsAuthenticated)
            {
                Client client;
                using (SportShopDBEntity entity = new SportShopDBEntity())
                {
                    client = entity.Clients.FirstOrDefault(c => c.UserName == User.Identity.Name);
                    if (client == null)
                    {
                        client = new Client() { UserName = User.Identity.Name, Mail = UserManager.GetEmail(User.Identity.GetUserId()) };
                        entity.Clients.Add(client);
                        entity.SaveChanges();
                    }
                }
                return client;
            }
            else
            {
                return null;
            }
        }

        [HttpPost]
        public ActionResult AddToCart(string article)
        {
            Product product;
            Order cart = GetCart();
            using (SportShopDBEntity entity = new SportShopDBEntity())
            {
                product = entity.Products.FirstOrDefault(p => p.Article == article);
            }
            if (product != null)
            {
                OrderedProduct oldOrderedProduct = cart.OrderedProducts.FirstOrDefault(p => p.Product.Article == article);
                if (oldOrderedProduct == null)
                {
                    cart.OrderedProducts.Add(new OrderedProduct() { Product = product });
                    return RedirectToAction("Index", new { article });
                }
                else
                {
                    oldOrderedProduct.Count++;
                    return RedirectToAction("Index", new { article });
                }
            }
            else
            {
                return View("FailMessage",new Exception("Не удалось добавить товар в корзину"));
            }
        }

        public RedirectToRouteResult RemoveFromCart(string article)
        {
            Order cart = GetCart();
            OrderedProduct orderedProduct = cart.OrderedProducts.FirstOrDefault(p=>p.Product.Article == article);
            if (orderedProduct != null)
            {
                cart.OrderedProducts.Remove(orderedProduct);
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult ApplyCart(CartViewModel cart)
        {
            if (cart.OrderedProducts.Count == 0)
            {
                return View("ApplyCartFail", new Exception("Пустая корзина"));
            }
            else
            {
                Client client = GetClient();
                Order order = (Order)Session["Cart"];
                bool exception = false;
                order.OrderedProducts.ToList().ForEach(p => { p.Count = cart.OrderedProducts.FirstOrDefault(o => o.ProductId == p.ProductId).Count;if (p.Count <= 0) { exception = true;  } });
                if (exception)
                {
                    return View("ApplyCartFail", new Exception("Нельзя сделать заказ на товар в количестве, менешем чем 1"));
                }
                else
                {
                    if (client != null)
                    {
                        (Session["Cart"] as Order).Client = client;
                        if (client.Id != 0) (Session["Cart"] as Order).ClientId = client.Id;
                        return RedirectToAction("OrderConfirm");
                    }
                    else
                    {
                        return RedirectToAction("ClientCreate");
                    }
                }
            }
        }

        [HttpGet]
        public ActionResult ClientCreate()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ClientCreate(Client client)
        {
            if (ModelState.IsValid)
            {
                GetCart().Client = client;
                return RedirectToAction("OrderConfirm");
            }
            else
            {
                return View();
            }
        }

        [HttpGet]
        public ActionResult OrderConfirm()
        {
            ViewBag.Sum = GetCart().OrderedProducts.Sum(p => p.Count * p.Product.Price);
            return View("OrderConfirm");
        }

        [HttpPost]
        public ActionResult OrderFinish()
        {
            Order order = GetCart();
            order.OrderedProducts = order.OrderedProducts.ToList().ConvertAll(p => new OrderedProduct() {Count = p.Count, ProductId = p.Product.Id });

            if (order.OrderedProducts.Count == 0)
            {
                return View("ApplyCartFail", new Exception("Пустая корзина"));
            }
            else
            {
                try
                {
                    using (SportShopDBEntity entity = new SportShopDBEntity())
                    {
                        Client client = entity.Clients.FirstOrDefault(c => c.UserName == order.Client.UserName);
                        if (string.IsNullOrEmpty(order.Client.UserName) || entity.Clients.FirstOrDefault(c => c.UserName == order.Client.UserName) == null)
                        {
                            entity.Clients.Add(order.Client);
                        }
                        else
                        {
                            order.Client = client;
                        }
                        //if (!entity.Clients.Contains(order.Client))
                        //{
                        //    entity.Clients.Add(order.Client);
                        //}
                        //entity.OrderedProducts.AddRange(order.OrderedProducts);
                        entity.Orders.Add(order);
                        entity.SaveChanges();
                    }
                    Session["Cart"] = new Order();
                    return View("ApplyCartSuccess");
                }
                catch (Exception e)
                {
                    Session.Remove("Cart");
                    return View("ApplyCartFail", e);
                }
            }
        }
    }
}