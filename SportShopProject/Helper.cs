using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SportShopProject.Models;
using SportShopProject.WebUI.Models;
using System.Text;

namespace SportShopProject
{
    public static class Helper
    {
        public static string ProductType(this HtmlHelper html,Product product)
        {
            string type = "";
            if (product is SportShopProject.Models.Sneakers)
            {
                type = "Кросовки";
            }
            else if (product is SportShopProject.Models.Bike)
            {
                type = "Велосипед";
            }
            if (!string.IsNullOrEmpty(type)) type += " ";
            return type;
        }

        public static MvcHtmlString GetProperties(this HtmlHelper html, Product product)
        {
            TagBuilder ulTag = new TagBuilder("ul");
            System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
            //ulTag.InnerHtml += GetProperyString("Производитель", product.Vendor) + GetProperyString("Артикул", product.Article);

            ulTag.InnerHtml += GetProperyString("Производитель", product.Vendor);
            ulTag.InnerHtml += GetProperyString("Артикул", product.Article);
            if (product is Bike)
            {
                Bike bike = product as Bike;
                ulTag.InnerHtml += GetProperyString("Материал", bike.Material);
                ulTag.InnerHtml += GetProperyString("Количество скоростей", bike.SpeedsCount);
                ulTag.InnerHtml += GetProperyString("Максимальный вес пользователя", bike.MaxWeight);
            }
            if(product is Shoes)
            {
                Shoes shoes = product as Shoes;
                ulTag.InnerHtml += GetProperyString("Цвета", string.Join(" ",shoes.Colors.Split(';').ToList().ConvertAll(c=>new ColorViewModel(c))));
                ulTag.InnerHtml += GetProperyString("Размеры", shoes.Sizes.Replace(';', ' '));
            }

            return new MvcHtmlString(ulTag.ToString());
        }
        private static string GetProperyString<T>(string properyName, T propertyValue, string propertyNameClass = "leftColumn", string propertyValueClass = "rightColumn")
        {
            if (propertyValue == null)
            {
                return "";
            }
            else
            {
                TagBuilder leftColumn = new TagBuilder("span") { InnerHtml = properyName };
                leftColumn.AddCssClass(propertyNameClass);

                TagBuilder rightColumn = new TagBuilder("span") { InnerHtml = propertyValue.ToString() };
                rightColumn.AddCssClass(propertyValueClass);
                TagBuilder liTag = new TagBuilder("li") { InnerHtml = leftColumn.ToString() + rightColumn.ToString() };
                return liTag.ToString();
            }
        }
        public static MvcHtmlString GetProperyString<T>(this HtmlHelper html, string properyName, T propertyValue, string propertyNameClass = "leftColumn", string propertyValueClass = "rightColumn")
        {
            return new MvcHtmlString(GetProperyString(properyName, propertyValue, propertyNameClass, propertyValueClass));
        }
        //public static List<string> GetCategories()
        //{
        //    List<string> categoryList;
        //    using(SportShopDBEntity entity = new SportShopDBEntity())
        //    {
        //        categoryList = entity.Categories.Select(c=>c.Title).ToList();
        //    }
        //    categoryList.Insert(0, "Все продукты");
        //    return categoryList;
        //}
    }
}