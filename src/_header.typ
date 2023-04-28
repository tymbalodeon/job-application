#import "_content.typ": name, email, phone, github, city

#let make-phone-number(phone-number) = {
    let phone-number = str(phone-number)
    let areaCode = phone-number.slice(0, 3)
    let prefix = phone-number.slice(3, 6)
    let number = phone-number.slice(6)

    [(#areaCode) #prefix - #number]
}

#let contact(items) = {
    for item in items.slice(0, -1) [
        #item |
    ]
    [#items.last()]
}

#let email = link(email)
#let phone = make-phone-number(phone)
#let github = link(github)

#show link: underline
#set text(10pt)

= #text(28pt, smallcaps(name))
#contact((email, phone, github, city))
#v(0.8em)
