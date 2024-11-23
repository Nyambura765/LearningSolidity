
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

// Book Store - we have an owner
// Books - cat_name, price, author, title, isbn, available
// - string, uint, int, bool
// uint8 (137) - unit256 (878687678678687876) 2*8 2*256
// int8 - int255 

// struct - grouping items
// mapping - used to store items with thier unique id
// array - two type - dynamic, fixed size unit256[] and unit256[4]
// event - notify about new addition or act as audit trail
// variables - global, state, local

// functions - setters and getters
// addBooks() - event BookAdded setter - setting data
// getBook() - getter - getting data
// buyBook() - event 
// getTotalBooks() - 

// inheritance - 

// more than 2 contracts
// index contract - entry point for all your other contracts
// interface contracts - abstracts functions that are reusable  - IERC20
// modifer contracts - require statements thats reusable 
// opezzenplin contracts -

// ABI - Application Binary Interface - xml, json, graphql - bridge between la backend python, php, javascript - react or next or reactNative

// example - assignment 
// create a loyaltyProgram - contract for the bookstore - two addPoint to user address, getUserPoints
// use the opezepplin contract for ownable 
// create a discount contract - two functions - setDiscount(either fixed or percentage), getDiscountedPrice
// use the points for the discount - 

// Events Advanced 
// - event filtering and montering - realtime upadtes and analytiics
// - event log analysis and decoding for data 
// - event driven architectures for dApps - stages = BookAdded, PurchaseInitiated, PurchaseConfirmed, SubscriptionAdded, SubscriptionRemoved
// - event subscription - notifications and updates  


contract BookStore is Ownable {

    struct Book {
        string title;
        string author;
        uint price;
        uint256 stock;
        bool isAvailable;
    }

    mapping(uint256 => Book) public books;
    mapping(address => bool) public subscribers;
    
    address[] public subscriberList;
    uint256[] public bookIds;

    event BookAdded(uint256 indexed bookId, string title, string author, uint256 price, uint256 stock);
    event PurchaseIntiated(uint256 indexed bookId, address indexed buyer, address indexed seller,  uint256 quantity);  // add a seller address for the event
    event PurchaseConfirmed(uint256 indexed bookId, address indexed buyer, address indexed seller, uint256 quantity); // add a seller address
    event SubscriptionAdded(address indexed subscriber);          // complete on this two 
    event SubscriptionRemoved(address indexed subscriber);
    
     constructor(address initialOwner) Ownable(initialOwner) {

     }

     function addBook(uint256 _bookId, string memory _title, string memory _author, uint256 _price, uint256 _stock) public onlyOwner {
        require(books[_bookId].price == 0, "Book already exists with this ID.");
        books[_bookId] = Book({
            title: _title,
            author: _author,
            price: _price * 1 ether, // Proper conversion to make sure price is in wei
            stock: _stock,
            isAvailable: _stock > 0
        });
        bookIds.push(_bookId); // push() , remove()
        emit BookAdded(_bookId, _title, _author, _price, _stock);
    }
    
    function getBooks(uint256 _bookId) public view returns (string memory, string memory, uint256, uint256, bool) {
        Book memory book = books[_bookId];
        return (book.title, book.author, book.price, book.stock, book.isAvailable);
    }

    // quantity = should a whole integer = 0.000000000000000006 but we need it like 6.0000000000000000
    // clue your assignment = 2**18 add this make quantity to 6.0000000000000000 also check ether conversations
    function buyBook(uint256 _bookId, uint256 _quantity) public payable {
        Book storage book = books[_bookId];
        require(book.isAvailable, "This book is not available.");
        require(book.stock >= _quantity, "Not enough stock available.");

        uint256 totalPrice = book.price * _quantity;
        require(msg.value == totalPrice, "Incorrect payment amount.");
        require(msg.value <= totalPrice, "Overpaid for book purchase.");

        emit PurchaseIntiated(_bookId, msg.sender, owner(), _quantity);

        // Transfer payment to the owner
        payable(owner()).transfer(msg.value);
    }

    function confirmPurchase(uint256 _bookId, uint256 _quantity) public onlyOwner {
        Book storage book = books[_bookId];
        require(book.stock >= _quantity, "Not enough stock to confirm purchase.");
        
        book.stock -= _quantity;
        if (book.stock == 0) {
            book.isAvailable = false;
        }

        emit PurchaseConfirmed(_bookId, msg.sender, owner(), _quantity);
    }

}