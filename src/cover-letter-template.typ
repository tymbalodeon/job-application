#import "content.typ": name

#let cover-letter(body) = [
    #set page(paper: "us-letter")
    #set text(10.7pt)
    #set par(justify: true)

    #include "header.typ"

    #v(-0.5em)
    #line(length: 100%)
    #v(0.5em)

    Dear Hiring Manager,

    #body

    Sincerely, \
    #emph[#name]
]
