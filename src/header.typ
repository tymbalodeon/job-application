#import "header-template.typ": header
#import "yaml.typ": get-person-property

#let name = get-person-property("name")
#let email = get-person-property("email")
#let phone = get-person-property("phone")
#let github = get-person-property("github")
#let city = get-person-property("city")

#show: header(name, email, phone, github, city)
