#let name = "Ben Rosen"
#let email = "benjamin.j.rosen@gmail.com"
#let phone = "6102913314"
#let github = "github.com/tymbalodeon"
#let city = "Philadelphia, PA"

#let format_phone(phone_number) = {
    let areaCode = phone_number.slice(0, 3)
    let prefix = phone_number.slice(3, 6)
    let number = phone_number.slice(6)

    [(#areaCode) #prefix - #number]
}

#let space = v(0.8em)

#let contact(items) = {
    for item in items.slice(0, -1) [
        #item |
    ]

    [#items.last()]
}

#let header = {
    let email = link(email)
    let phone = format_phone(phone)
    let github = link(github)

    show link: underline

    [
        = #text(2em, name)
        #contact((email, phone, github, city))
    ]
    space
}
