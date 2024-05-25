// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalSupplyChain {
    address public owner;

    struct Manufacturer {
        uint id;
        string name;
        address manufacturerAddress;
    }

    struct Buyer {
        uint id;
        string name;
        address buyerAddress;
    }

 

    struct Seller {
        uint id;
        string name;
        address sellerAddress;
    }

    struct Product {
        uint id;
        string name;
        uint manufactureDate;
        uint expiryDate;
        address manufacturerAddress;
        uint price;
        bool forSale;
        address buyer;
    }

    struct StatusUpdate {
        string location;
        uint temperature;
        uint humidity;
        uint timestamp;
    }

  struct Shipment {
    uint id;
    uint productId;
    string productName;  
    string manufacturerUsername;  
    address sender;
    uint shipmentDate;
    bool received;
    StatusUpdate[] statusUpdates;
    address buyer;
}


    uint public manufacturerCount;
    uint public productCount;
    uint public shipmentCount;
    uint public buyerCount;
    uint public sellerCount;

    mapping(uint => Manufacturer) public manufacturers;
    mapping(uint => Buyer) public buyers;
    mapping(uint => Seller) public sellers;
    mapping(uint => Product) public products;
    mapping(uint => Shipment) public shipments;
    mapping(address => string) public manufacturerUsernames;
    mapping(address => string) public buyerUsernames;

    mapping(address => bool) public registeredManufacturers;
    mapping(address => bool) public registeredBuyers;

    event ManufacturerRegistered(uint id, string name, address manufacturerAddress);
    event BuyerRegistered(uint id, string name, address buyerAddress);
    event SellerRegistered(uint id, string name, address sellerAddress);
    event ProductCreated(uint id, string name, uint manufactureDate, uint expiryDate, address manufacturerAddress);
    event ProductListedForSale(uint id, uint price);
    event ProductPurchased(uint id, address buyer);
    event ShipmentCreated(uint id, uint productId, address sender, address buyer, uint shipmentDate);
    event ShipmentReceived(uint id, uint receiveDate);
    event ShipmentStatusUpdated(uint shipmentId, string location, uint temperature, uint humidity, uint timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerManufacturer(address _manufacturerAddress, string memory _username) public onlyOwner {
        require(!registeredManufacturers[_manufacturerAddress], "Manufacturer already registered");
        registeredManufacturers[_manufacturerAddress] = true;
        manufacturerCount++;
        manufacturers[manufacturerCount] = Manufacturer(manufacturerCount, "", _manufacturerAddress); // Assuming the name is not required here
        manufacturerUsernames[_manufacturerAddress] = _username;
        emit ManufacturerRegistered(manufacturerCount, "", _manufacturerAddress);
    }

    function registerBuyer(address _buyerAddress, string memory _username) public onlyOwner {
        require(!registeredBuyers[_buyerAddress], "Buyer already registered");
        registeredBuyers[_buyerAddress] = true;
        buyerCount++;
        buyers[buyerCount] = Buyer(buyerCount, "", _buyerAddress); // Assuming the name is not required here
        buyerUsernames[_buyerAddress] = _username;
        emit BuyerRegistered(buyerCount, "", _buyerAddress);
    }


    function registerSeller(string memory _name, address _sellerAddress) public onlyOwner {
        sellerCount++;
        sellers[sellerCount] = Seller(sellerCount, _name, _sellerAddress);
        emit SellerRegistered(sellerCount, _name, _sellerAddress);
    }

    function createProduct(string memory _name, uint _manufactureDate, uint _expiryDate, uint _price) public {
        require(isManufacturer(msg.sender) || isSeller(msg.sender), "Only registered manufacturers or sellers can create products");
        productCount++;
        products[productCount] = Product(productCount, _name, _manufactureDate, _expiryDate, msg.sender, _price, false, address(0));
        emit ProductCreated(productCount, _name, _manufactureDate, _expiryDate, msg.sender);
    }

    function listProductForSale(uint _productId, uint _price) public {
        Product storage product = products[_productId];
        require(product.manufacturerAddress == msg.sender || isSeller(msg.sender), "Only the product manufacturer or seller can list the product for sale");
        product.price = _price;
        product.forSale = true;
        emit ProductListedForSale(_productId, _price);
    }

    function purchaseProduct(uint _productId) public payable {
        Product storage product = products[_productId];
        require(product.forSale, "Product is not for sale");
        require(msg.value == product.price, "Incorrect value sent");
        product.forSale = false;
        product.buyer = msg.sender;
        payable(product.manufacturerAddress).transfer(msg.value);
        emit ProductPurchased(_productId, msg.sender);
    }

    function createShipment(uint _productId, address _buyer, string memory _initialLocation, uint _initialTemperature, uint _initialHumidity) public {
        require(products[_productId].manufacturerAddress == msg.sender || isSeller(msg.sender), "Only the product manufacturer or seller can create a shipment");
        shipmentCount++;
        Shipment storage newShipment = shipments[shipmentCount];
        newShipment.id = shipmentCount;
        newShipment.productId = _productId;
        newShipment.sender = msg.sender;
        newShipment.buyer = _buyer;
        newShipment.shipmentDate = block.timestamp;
        newShipment.received = false;
        newShipment.statusUpdates.push(StatusUpdate(_initialLocation, _initialTemperature, _initialHumidity, block.timestamp));
        emit ShipmentCreated(shipmentCount, _productId, msg.sender, _buyer, block.timestamp);
        emit ShipmentStatusUpdated(shipmentCount, _initialLocation, _initialTemperature, _initialHumidity, block.timestamp);
    }

    function getManufacturerUsername(address _manufacturerAddress) public view returns (string memory) {
         return manufacturerUsernames[_manufacturerAddress];
}

    function getBuyerUsername(address _buyerAddress) public view returns (string memory) {
        return buyerUsernames[_buyerAddress];
    } 

    function updateShipmentStatus(uint _shipmentId, string memory _location, uint _temperature, uint _humidity) public {
        Shipment storage shipment = shipments[_shipmentId];
        require(shipment.sender == msg.sender || shipment.buyer == msg.sender, "Only sender or buyer can update shipment status");
        shipment.statusUpdates.push(StatusUpdate(_location, _temperature, _humidity, block.timestamp));
        emit ShipmentStatusUpdated(_shipmentId, _location, _temperature, _humidity, block.timestamp);
}

    function receiveShipment(uint _shipmentId) public {
        require(shipments[_shipmentId].buyer == msg.sender, "Only the designated buyer can receive the shipment");
         shipments[_shipmentId].received = true;
        emit ShipmentReceived(_shipmentId, block.timestamp);
}


    function logEnvironmentalData(uint _shipmentId, uint _temperature, uint _humidity) public {
        Shipment storage shipment = shipments[_shipmentId];
        require(shipment.sender == msg.sender || shipment.buyer == msg.sender, "Only sender or buyer can log environmental data");
        shipment.statusUpdates.push(StatusUpdate("In transit", _temperature, _humidity, block.timestamp));
        emit ShipmentStatusUpdated(_shipmentId, "In transit", _temperature, _humidity, block.timestamp);
}


   function getShipmentsByBuyer(address _buyerAddress) public view returns (Shipment[] memory) {
    uint count = 0;
    for (uint i = 1; i <= shipmentCount; i++) {
        if (shipments[i].buyer == _buyerAddress) {
            count++;
        }
    }
    Shipment[] memory buyerShipments = new Shipment[](count);
    uint index = 0;
    for (uint i = 1; i <= shipmentCount; i++) {
        if (shipments[i].buyer == _buyerAddress) {
            Shipment storage shipment = shipments[i];
            Product storage product = products[shipment.productId];
            buyerShipments[index] = Shipment({
                id: shipment.id,
                productId: shipment.productId,
                productName: product.name,
                manufacturerUsername: manufacturerUsernames[product.manufacturerAddress],
                sender: shipment.sender,
                shipmentDate: shipment.shipmentDate,
                received: shipment.received,
                statusUpdates: shipment.statusUpdates,
                buyer: shipment.buyer
            });
            index++;
        }
    }
    return buyerShipments;
}


    function isManufacturer(address _address) public view returns (bool) {
        for (uint i = 1; i <= manufacturerCount; i++) {
            if (manufacturers[i].manufacturerAddress == _address) {
                return true;
            }
        }
        return false;
    }

    function isBuyer(address _address) public view returns (bool) {
        for (uint i = 1; i <= buyerCount; i++) {
            if (buyers[i].buyerAddress == _address) {
                return true;
            }
        }
        return false;
    }

    function isSeller(address _address) public view returns (bool) {
        for (uint i = 1; i <= sellerCount; i++) {
            if (sellers[i].sellerAddress == _address) {
                return true;
            }
        }
        return false;
    }

    function getShipmentStatusUpdates(uint _shipmentId) public view returns (StatusUpdate[] memory) {
        return shipments[_shipmentId].statusUpdates;
    }

    // Function to get all sellers
    function getAllSellers() public view returns (Seller[] memory) {
        Seller[] memory allSellers = new Seller[](sellerCount);
        for (uint i = 1; i <= sellerCount; i++) {
            allSellers[i - 1] = sellers[i];
        }
        return allSellers;
    }

    // Function to get all buyers
    function getAllBuyers() public view returns (Buyer[] memory) {
        Buyer[] memory allBuyers = new Buyer[](buyerCount);
        for (uint i = 1; i <= buyerCount; i++) {
            allBuyers[i - 1] = buyers[i];
        }
        return allBuyers;
    }

    // Function to get all products
    function getAllProducts() public view returns (Product[] memory) {
        Product[] memory allProducts = new Product[](productCount);
        for (uint i = 1; i <= productCount; i++) {
            allProducts[i - 1] = products[i];
        }
        return allProducts;
    }

    // Function to get all shipments
    function getAllShipments() public view returns (Shipment[] memory) {
        Shipment[] memory allShipments = new Shipment[](shipmentCount);
        for (uint i = 1; i <= shipmentCount; i++) {
            allShipments[i - 1] = shipments[i];
        }
        return allShipments;
    }
}