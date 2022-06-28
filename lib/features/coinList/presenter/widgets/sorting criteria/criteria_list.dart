List<Map<String, dynamic>> criteriaList = [
  {"by": 'Rank', "desc": true},
  {"by": 'Price', "desc": false},
  {"by": '% 24h', "desc": false},
  {"by": '% 7d', "desc": false},
  {"by": 'Name', "desc": false}
];

const Map<String, dynamic> rankDesc = {"by": 'Rank', "desc": true};
const Map<String, dynamic> rankAsc = {"by": 'Rank', "desc": false};

const Map<String, dynamic> priceDesc = {"by": 'Price', "desc": true};
const Map<String, dynamic> priceAsc = {"by": 'Price', "desc": false};

const Map<String, dynamic> percentage24HDesc = {"by": '% 24h', "desc": true};
const Map<String, dynamic> percentage24HAsc = {"by": '% 24h', "desc": false};
