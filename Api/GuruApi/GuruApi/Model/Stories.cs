using System;
using System.Collections.Generic;

namespace GuruApi.Model
{
    public partial class Stories
    {
        public List<Item> Items { get; set; }
    }

    public partial class Item
    {
        public string Title { get; set; }
        public string Origin { get; set; }
        public Uri Link { get; set; }
        public bool IsPriority { get; set; }
        public Uri Image { get; set; }
        public string Published { get; set; }
    }
}
