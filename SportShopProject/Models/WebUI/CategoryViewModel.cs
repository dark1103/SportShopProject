using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SportShopProject.Models;

namespace SportShopProject.WebUI.Models
{
    public class CategoryViewModel
    {
        public List<Product> Products { get; set; }
        public PageInfo pageInfo { get; set; }
    }

    public class PageInfo
    {
        public int page { get; set; }
        public int pagesCount { get; set; }
        public string category { get; set; }
        public PageInfo()
        {
            page = 0;
            pagesCount = 1;
            category = "";
        }
        public PageInfo(int page,int pagesCount,string category)
        {
            this.page = page;
            this.pagesCount = pagesCount;
            this.category = category;
        }
    }
}