using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SportShopProject.WebUI.Models
{
    public class PagesLinksViewModel
    {
        public int Min { get; set; }
        public int Max { get; set; }
        public int Last { get; set; }
        public int Current { get; set; }
        public string Category { get; set; }
        public PagesLinksViewModel(int min,int max,int current,int last,string category)
        {
            this.Min = min;
            this.Max = max;
            this.Current = current;
            this.Category = category;
            this.Last = last;
        }
    }
}