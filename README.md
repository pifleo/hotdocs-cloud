hotdocs-cloud
=============

Hotdocs-cloud is a ruby client for HotDocs Cloud Services REST API

HotDocs Cloud Services is a hosted document generation platform designed for enterprises that want advanced document generation technology without the upfront cost and upkeep of on-premises solutions.

We welcome bug reports and pull requests, we will publish this gem once we are
confident that it should work out of the box for most usage scenarios.


##Installation


##Requirements

A HotDocs Cloud Service account (subscription ID, signing Key).
At least HotDocs Developer 11.0.1 (Include the Cloud Upload Plugin and export in .hdpkg format)

##Examples

    # app/controllers/hotdocs_controller.rb
    client = Hotdocs::Cloud::Client::RestClient.new("SUBSCRIPTION_ID", "SIGNING_KEY")
    @get_session_id = client.CreateSession("Employment Agreement", "/EmploymentAgreement.hdpkg")

###Documentations

 - HotDocs Cloud Services Management Portal ( https://europe.hotdocs.ws/portal/ )
 - Documentation ( http://help.hotdocs.com/cloudservices/ )
 - API endpoint: https://cloud.hotdocs.ws/ (US), https://europe.hotdocs.ws/ (EU)

##Development

##Where is the code ?

We build the code locally in the folder of our application at the moment.
We will publish it in this repository and as a gem when all Classes are implemented.
If you are interested, open an issue or contact us and we will publish it quickly.
