# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "/javascripts/bootstrap_bundle_min.js", preload: true
pin "three", to: "/javascripts/three_module_min.js", preload: true
pin 'web3', to: "https://unpkg.com/web3@4.10.0/dist/web3.min.js"