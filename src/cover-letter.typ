#import "_content.typ": cover-letter-content, name

#show par: set block(spacing: 0.65em)
#set page(paper: "us-letter")
#set text(12pt)
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
\

#h(-2em) Sincerely,\
#emph(name)
