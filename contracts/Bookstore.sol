// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bookstore {
    
    struct Book {
        uint256 bookId; 
        string title;
        string author;
        uint256 price; 
        uint256 stock;
        bool isAvailable; 
    }

    // Mapping to store books with unique ID
    mapping(uint256 => Book) public books;
    uint256 public bookCount = 0;
    
    // Counter to keep track of the total number of books sold
    uint256 public totalBooksSold = 0;
    address public owner;

     modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

     constructor() {
        owner = msg.sender;
    }

    // Function to add a new book with a specific bookId
    function addBook(uint256 _bookId, string memory _title, string memory _author, uint256 _price, uint256 _stock) public onlyOwner {
        require(_bookId > 0, "Book ID should be greater than zero");
        require(_price > 0, "Price should be greater than zero");
        require(_stock > 0, "Stock should be greater than zero");
        require(books[_bookId].bookId == 0, "Book ID already exists");

        books[_bookId] = Book(_bookId, _title, _author, _price*1 ether, _stock, true);
        bookCount++;
    }

    // Function to update the stock of a book
    function updateStock(uint256 _bookId, uint256 _newStock) public onlyOwner {
        require(_bookId > 0 && _bookId <= bookCount, "Invalid book ID");
        require(_newStock > 0, "Stock should be greater than zero");
        require(books[_bookId].isAvailable, "Book is not available");

        books[_bookId].stock = _newStock;
    }

    // Function to purchase a book
    function purchaseBook(uint256 _bookId ,uint256 _quantity) public payable {
        require(_bookId > 0 && _bookId <= bookCount, "Invalid book ID");
        Book storage book = books[_bookId];
        require(book.isAvailable, "Book is not available");
        require(book.stock > _quantity, "Book out of stock");

        uint256 totalprice =book.price*_quantity;
        require(msg.value == totalprice, "Incorrect payment amount");
        require(msg.value<=totalprice, "Overpaid book purchase");

        book.stock--;
        totalBooksSold++; 

        // Transfer payment to the owner
        payable(owner).transfer(msg.value);
    }

    // Function to get the details of a book
    function getBookDetails(uint256 _bookId) public view returns (uint256, string memory, string memory, uint256, uint256, bool) {
        require(_bookId > 0 && _bookId <= bookCount, "Invalid book ID");
        Book memory book = books[_bookId];
        return (book.bookId, book.title, book.author, book.price, book.stock, book.isAvailable);
    }

    // Function to get all books
    function getAllBooks() public view returns (Book[] memory) {
        Book[] memory allBooks = new Book[](bookCount);
        uint256 index = 0;
        for (uint256 i = 1; i <= bookCount; i++) {
            if (books[i].bookId != 0) {
                allBooks[index] = books[i];
                index++;
            }
        }
        return allBooks;
    }

    // Function to remove a specific book
    function removeBook(uint256 _bookId) public onlyOwner {
        require(_bookId > 0 && _bookId <= bookCount, "Invalid book ID");
        require(books[_bookId].isAvailable, "Book is already removed");

        books[_bookId].isAvailable = false; 
    }

    // Function to remove all books
    function removeAllBooks() public onlyOwner {
        for (uint256 i = 1; i <= bookCount; i++) {
            if (books[i].isAvailable) {
                books[i].isAvailable = false; 
            }
        }
    }

    // Function to check the owner's balance
    function getOwnerBalance() public view returns (uint256) {
        return address(owner).balance;
    }
}
