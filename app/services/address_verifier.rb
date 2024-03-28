class AddressVerifier
  def self.valid?(address)
    # For simplicity, we simply need 1 address to exist to move forward.
    Geocoder.search(address).present?
  end
end
