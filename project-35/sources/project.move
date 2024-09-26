module MyModule::ProductAuthenticity {
    use std::signer;
    struct Product has store, key {
        product_id: u64,
        owner: address,
        details: vector<u8>,
    }

    // Function to register a product with details
    public fun register_product(owner: &signer, product_id: u64, details: vector<u8>) {
        let product = Product {
            product_id,
            owner: signer::address_of(owner),
            details,
        };
        move_to(owner, product);
    }

    // Function to verify product authenticity
    public fun verify_product(product_id: u64, owner: &signer): vector<u8> acquires Product {
        let product_owner = signer::address_of(owner);
        let product = borrow_global<Product>(product_owner);
        assert!(product.product_id == product_id, 1);
        product.details
    }
}
