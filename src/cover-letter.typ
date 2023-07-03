#import "_content.typ": cover-letter-content, name

#set page(paper: "us-letter")
#set text(11pt)
#set par(justify: true, first-line-indent: 2em)

#include "_header.typ"

#v(-0.5em)
#line(length: 100%)
#v(0.5em)

Dear Hiring Manager,
\
\

#cover-letter-content
\


#grid(
    columns: (1fr, 75%),
    [],
    [Sincerely,\ #emph(name)]
)
