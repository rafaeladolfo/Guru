using System;
using System.Collections.Generic;

namespace GuruApi.Model
{
    public partial class CryptoStocks
    {
        public List<StockItems> Items { get; set; }
    }

    public partial class StockItems
    {
        public Uri Icon { get; set; }
        public string CodeName { get; set; }
        public string Name { get; set; }
        public Uri Link { get; set; }
        public double Price { get; set; }
        public double Result { get; set; }        
    }
}
