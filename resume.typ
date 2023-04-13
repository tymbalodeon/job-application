#let name = "Ben Rosen"
#let email = "benjamin.j.rosen@gmail.com"
#let phone = 6102913314
#let github = "github.com/tymbalodeon"
#let city = "Philadelphia, PA"

#show heading.where(
  level: 1
): set text(1.8em)

#let contact(items) = {
    for item in items.slice(0, -1) [
        #item |
    ]

    [
        #items.last()
    ]

    v(1em)
}

#show heading.where(
  level: 2
): heading => [
    #heading
    #v(-0.8em)
    #line(length: 100%)
]

#let experience(employer, location, position, start, end, highlights) = [
    #grid(
        columns: (auto, 1fr),
        align(left)[
            #strong[#employer] \
            #emph[#position]
        ],
        align(right)[
            #strong[#start -- #end] \
            #location
        ]
    )

    #for highlight in highlights [
        - #highlight
    ]

    #v(1em)
]

#let award(title, year) = [
    #grid(
        columns: (auto, 1fr),
        align(left)[
            #emph[#title]
        ],
        align(right)[
            #strong[#year]
        ]
)
]

#let education(institution, location, degree, year) = [
    #grid(
        columns: (auto, 1fr),
        align(left)[
            #strong[#institution] \
            #emph[#degree]
        ],
        align(right)[
            #strong[#year] \
            #location
        ]
    )
]

#let skill(name, skills) = box[
    #strong[#name:]
    #for skill in skills.slice(0, -1) [
        #skill,
    ]
    #skills.last()
]

= #name
#contact((email, phone, github, city))

== Work Experience
#experience(
    "Univeristy of Pennsylvania",
    "Philadelphia, PA",
    "Courseware Developer",
    "May 2021",
    "Present",
    (
        "Refactored entire university-wide Django site, upgrading SQLite to Postgres, adding HTMX on the front end",
        "Wrote first test suites for the site, added coverage, pre-commit checks, Justfile commands",
        "Collaborated with DevOps to establish deployment system (Vagrant/Ansible/Docker)",
        "Rewrote queries to Penn’s Oracle database following major database restructuring",
        "Created installable CLI application connecting to the Canvas API to run tasks for staff across the university",
        "Created scripts for archiving entire Canvas sites, reporting on tool usage, among others",
        "Audited tasks for expensive processes and implemented caching when appropriate"
    )
)

#experience(
    "Vanguard",
    "Malvern, PA",
    "Developer I",
    "April 2020",
    "April 2021",
    (
        "Wrote TypeScript, SCSS, unit tests for new features, bug-fixes in Angular component library",
        "Collaborated with accessibility team to ensure the library conforms to WCAG standards",
        "Provided support for internal teams consuming our library in their applications",
        "Collaborated with developers, designers, and strategists using Agile methods"
    )
)

#experience(
    "Freelance",
    "Various",
    "Music Instructo & Audio Engineer",
    "2007",
    "2019",
    (
      "Taught individual lessons and group classes in piano, guitar, bass, music theory",
      "Co-produced bass guitar sample library for Orange Tree Samples (forthcoming)"
    )
)

== Awards
#award("UPenn Models of Excellence Award (Honorable Mention)", 2022)

== Education
#education(
    "Thinkful",
    "Remote",
    "Engineering Immersion (Full-Time)",
    "2019"
)

#education(
    "Peabody Institute of the Johns Hopkins University",
    "Baltimore, MD",
    "M.M.",
    "2013"
)

#education(
    "Sarah Lawrence College",
    "Bronxville, NY",
    "B.A.",
    "2010"
)

== Skills
#skill("Front end", ("TypeScript", "JavaScript", "Angular", "React", "Sass", "Qwik"))
#skill("Back end", ("Python", "Typescript", "JavaScript", "Django", "FastAPI", "Express", "PostgreSQL"))
#skill("Additional", ("Docker", "Ansible", "Shell", "Scheme", "Emacs Lisp", "SCLang (SuperCollider)", "LilyPond", "Rust"))
