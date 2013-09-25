# Hotdocs::Cloud

Hotdocs-cloud is a ruby client for HotDocs Cloud Services REST API

HotDocs Cloud Services is a hosted document generation platform designed for enterprises that want advanced document generation technology without the upfront cost and upkeep of on-premises solutions.

We welcome bug reports and pull requests, we will publish this gem once we are
confident that it should work out of the box for most usage scenarios.

## Installation

Add this line to your application's Gemfile:

    gem 'hotdocs-cloud', github: 'pifleo/hotdocs-cloud'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hotdocs-cloud

## Usage

    # app/controllers/hotdocs_controller.rb
    client = Hotdocs::Cloud::Client::RestClient.new("SUBSCRIPTION_ID", "SIGNING_KEY")
    @get_session_id = client.CreateSession("Employment Agreement", "/EmploymentAgreement.hdpkg")

## Requirements

A HotDocs Cloud Service account (subscription ID, signing Key).

At least HotDocs Developer 11.0.1 (Include the Cloud Upload Plugin and export in .hdpkg format)

## Documentation

 - HotDocs Cloud Services Management Portal ( https://cloud.hotdocs.ws/portal/ or https://europe.hotdocs.ws/portal/ )
 - Documentation ( http://help.hotdocs.com/cloudservices/ )
 - API endpoint: https://cloud.hotdocs.ws/ (US), https://europe.hotdocs.ws/ (EU)
 - Official ressources and SDK: https://github.com/HotDocsCorp/hotdocs-open-sdk

## Development / Where is the code ?

We build the code locally in the folder of our application at the moment.
We will publish it in this repository and as a gem when all Classes are implemented.
If you are interested, open an issue or contact us and we will publish it quickly.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

First version developed by WaasBros SAS (Paris, France) for its product http://www.captaincontrat.com/ (fr)
