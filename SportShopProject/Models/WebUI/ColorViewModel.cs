using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SportShopProject.WebUI.Models
{
    public class ColorViewModel
    {
        private string color;
        private int size;
        public ColorViewModel(string color,int size = 20)
        {
            this.color = color;
            this.size = size;
        }
        public override string ToString()
        {
            TagBuilder tag = new TagBuilder("div");
            tag.MergeAttribute("style", $"background-color:{color};width:{size}px;height:{size}px;display:inline-block;margin:6px 4px 0px 0px;border-radius:5px;");
            return tag.ToString();
        }
    }
}