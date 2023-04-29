#import "_content.typ": name, experiences, awards, education, skills

#let make-experience(experience) = [
    #let (
        employer,
        location,
        position,
        start,
        end,
        highlights
    ) = experience

    #grid(
        columns: (auto, 1fr),
        align(left)[
            #strong[#employer] \
            #emph[#position]
        ],
        align(right)[
            #strong[#start -- #end] \
            #emph[#location]
        ]
    )

    #pad(left: 1em)[
        #for highlight in highlights [
            - #highlight
        ]
    ]
]

#let make-award(award) = [
    #let (name, year) = award

    #grid(
        columns: (auto, 1fr),
        align(left)[
            #emph[#name]
        ],
        align(right)[
            #strong[#year]
        ]
    )
]

#let make-degree(degree) = [
    #set par(leading: 0.3em)
    #let (institution, location, degree, concentration, year) = degree

    #if concentration != none {
        degree = [#degree, #concentration]
    }

    #grid(
        columns: (auto, 1fr),
        align(left)[
            #strong[#institution] \
            #emph[#degree]
        ],
        align(right)[
            #strong[#year] \
            #emph[#location]
        ]
    )
]

#let make-skill(skill) = box[
    #let (name, skills) = skill

    #strong[#name:]
    #for skill in skills.slice(0, -1) [
        #skill,
    ]
    #skills.last()
]

#set document(
    title: name + " Resume",
    author: name
)
#set page(paper: "us-letter")
#set text(10pt)

#show heading.where(level: 2): heading => [
    #smallcaps(heading)
    #v(-0.7em)
    #line(length: 100%)
]

#include "_header.typ"

== Work Experience
#for experience in experiences {
    make-experience(experience)
}

== Awards
#for award in awards {
    make-award(award)
}

== Education
#for degree in education {
    make-degree(degree)
}

== Skills
#for skill in skills [
    #make-skill(skill) \
]
