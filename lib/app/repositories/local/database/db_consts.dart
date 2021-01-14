/// Constants of Database.

// Database Attributes
const DATABASE_NAME = "boockando.db";

// Table Names
const TABLE_USER_NAME = "user";
const TABLE_BOOK_NAME = "book";
const TABLE_BASKET_NAME = "basket";
const TABLE_BASKET_BOOKS_NAME = "basket_books";
const TABLE_PURCHASE_NAME = "purchase";

// Table attributes
//User
const TABLE_USER_ATT_ID = "id"; //PK
const TABLE_USER_ATT_NAME = "name";
const TABLE_USER_ATT_EMAIL = "email";

//Book
const TABLE_BOOK_ATT_ID = "id"; //PK
const TABLE_BOOK_ATT_TITLE = "title";
const TABLE_BOOK_ATT_ABOUT = "about";
const TABLE_BOOK_ATT_ISBN = "isbn";
const TABLE_BOOK_ATT_PRICE = "price";
const TABLE_BOOK_ATT_CATEGORY = "category";
const TABLE_BOOK_ATT_IMAGE = "bookImage";

//Basket
const TABLE_BASKET_ATT_ID = "id"; //PK
const TABLE_BASKET_ATT_VALUE = "totalValue";

//Basket Book
const TABLE_BASKET_BOOKS_ATT_ID_BASKET = TABLE_BASKET_ATT_ID; //FK
const TABLE_BASKET_BOOKS_ATT_ID_USER = TABLE_USER_ATT_ID; //FK
const TABLE_BASKET_BOOKS_ATT_ID_BOOK = TABLE_BOOK_ATT_ID; //FK
const TABLE_BASKET_BOOKS_ATT_BOOK_QTD = "bookQTD";
const TABLE_BASKET_BOOKS_ATT_BOOK_PRICE =  "bookPrice";

//Purchase
const TABLE_PURCHASE_ATT_BASKET_ID = TABLE_BASKET_ATT_ID; //FK
const TABLE_PURCHASE_ATT_USER_ID = TABLE_USER_ATT_ID; //FK
const TABLE_PURCHASE_ATT_IS_DELETED = "isDeleted";
const TABLE_PURCHASE_ATT_DAY = "day";
const TABLE_PURCHASE_ATT_MONTH = "month";
