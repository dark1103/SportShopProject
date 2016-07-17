using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SportShopProject.Models;
using SportShopProject.WebUI.Models;

namespace SportShopProject.Controllers
{
    public class NavController : Controller
    {
        // GET: Nav
        public ActionResult Index()
        {
            return View();
        }
        public PartialViewResult Menu(string selectedCategory = "")
        {
            List<string> categories;
            using(SportShopDBEntity entity = new SportShopDBEntity())
            {
                categories = entity.Categories.Select(c => c.Title).ToList();
            }
            categories.Insert(0, "Все продукты");
            ViewBag.SelectedCategory = selectedCategory.Replace('_',' ');
            return PartialView(categories);
        }
        public PartialViewResult PagesLinks(int page,int pageCount,string category)
        {
            int min, max;

            if (pageCount < 5)
            {
                min = 1;
                max = pageCount;
            }
            else
            {
                min = page - 2;
                max = page + 2;
                if (min < 1)
                {
                    max += -min + 1;
                    min = 1;
                }
                max = Math.Min(pageCount, max);
            }
            return PartialView(new PagesLinksViewModel(min, max,page,pageCount,category.Replace(' ','_')));
        }
    }
}