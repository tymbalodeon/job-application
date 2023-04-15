#import "_content.typ": cover-letter-content, name

#set page(paper: "us-letter")
#set text(10.7pt)
#set par(justify: true)

#include "_header.typ"

#v(-0.5em)
#line(length: 100%)
#v(0.5em)

Dear Hiring Manager,

#cover-letter-content

Sincerely, \
#emph[#name]
