#let name = "Ben Rosen"
#let email = "benjamin.j.rosen@gmail.com"
#let phone = 6102913314
#let github = "github.com/tymbalodeon"
#let city = "Philadelphia, PA"

#show heading.where(
  level: 1
): set text(2em)

#let contact(items) = {
    for item in items.slice(0, -1) [
        #item |
    ]

    [
        #items.last()
    ]

    v(2em)
}

#show heading.where(
  level: 2
): heading => [
    #heading
    #v(-0.5em)
    #line(length: 100%)
]

#let experience(employer, location, position, start, end) = [
#grid(
    columns: (auto, 1fr),
    align(left)[#strong[#employer] \ #emph[#position]],
    align(right)[#strong[#start -- #end] \ #location]
)
]

= #name
#contact((email, phone, github, city))

== Work Experience
#experience(
    "Univeristy of Pennsylvania",
    "Philadelphia, PA",
    "Courseware Developer",
    "May 2021",
    "Present"
)

#experience(
    "Vanguard",
    "Malvern, PA",
    "Developer I",
    "April 2020",
    "April 2021"
)

== Awards
== Education
== Skills
