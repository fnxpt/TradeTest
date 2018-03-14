class Price: Decodable {

    let amount: Double
    let currency: String
    let decimals: Int

    init(amount: Double,
         currency: String,
         decimals: Int = 1) {

        self.amount = amount
        self.currency = currency
        self.decimals = decimals
    }
}