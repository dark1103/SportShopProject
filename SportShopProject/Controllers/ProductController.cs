using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SportShopProject.Models;
using SportShopProject.WebUI.Models;

namespace SportShopProject.Controllers
{
    public class ProductController: Controller
    {
        public const int productsPerPage = 8;
        public ActionResult Index()
        {
            return ProductList();
        }
        public ActionResult ProductList(string category = "Все продукты", int page = 1)
        {
            //Session["LastCatalogPage"] = Url.Action("ProductList", "Product", new { category = category, page = page });
            Session["LastCatalogPage"] = Request.RawUrl;
            List<Product> products;
            int productsCount;
            using (SportShopDBEntity entity = new SportShopDBEntity())
            {
                if (entity.Categories.Where(c => c.Title == category).Count() == 0)
                {
                    products = entity.Products.OrderBy(p => p.Id).Skip((page - 1) * productsPerPage).Take(productsPerPage).ToList();
                    productsCount = entity.Products.Count();
                }
                else
                {
                    products = entity.Products.Include("Category").Where(p => p.Category.Title == category).OrderBy(p => p.Id).Skip((page - 1) * productsPerPage).Take(productsPerPage).ToList();
                    productsCount = entity.Products.Include("Category").Where(p => p.Category.Title == category).Count();
                }
            }
            PageInfo pageInfo = new PageInfo(page, (int)Math.Ceiling(productsCount / (double)productsPerPage), category);

            return View("ProductList", new CategoryViewModel() { Products = products, pageInfo = pageInfo });
        }
        public ActionResult ProductView(string article)
        {
            Product product;
            string productCategory;
            using (SportShopDBEntity entity = new SportShopDBEntity())
            {
                product = entity.Products.FirstOrDefault(p => p.Article == article);
                productCategory = product.Category.Title;
            }
            CategoryViewModel viewModel = new CategoryViewModel() { Products = new List<Product>() { product } };
            return View(viewModel);
        }
    }
}