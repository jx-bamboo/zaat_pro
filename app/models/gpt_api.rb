class GptApi < ApplicationRecord
  validates :url, :port, presence: true
  validates :url, format: {
    with: %r{\A(?:http|https)://[^/\s]+(?:[/?#][^ ]*)?\z},
    message: "The URL must start with 'http://' or 'https://', followed by a domain or IP, and contain no spaces."
  }
  validates :port, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 65535,
    message: "The port number must be an integer between 0 and 65535."
  }

end
