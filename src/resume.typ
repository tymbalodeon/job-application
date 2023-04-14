#import "header.typ": name, header, space

#set document(
    title: name + " Resume",
    author: name
)
#set page(paper: "us-letter")
#set text(10pt)

#show heading.where(
  level: 2
): heading => [
    #heading
    #v(-0.7em)
    #line(length: 100%)
]

#let format_experience(experience) = [
    #let (employer, location, position, start, end, highlights) = thing

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

    #space
]

#let award(item) = [
    #let (title, year) = item

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

#let education(item) = [
    #let (institution, location, degree, year) = item

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

#let skill(item) = box[
    #let (name, skills) = item

    #strong[#name:]
    #for skill in skills.slice(0, -1) [
        #skill,
    ]
    #skills.last()
]

#let resume(experiences, awards, education, skills) = [
    #header

    == Work Experience
    for experience in experiences {
        format_experience(experience)
    }

    == Awards
    for award in awards {
        #award(award)
    }

    #space

    == Education
    for degree in education {
        #education(degree)
    }

    #space

    == Skills
]

#let experiences = (
    (
        employer: "University of Pennsylvania",
        location: "Philadelphia, PA",
        position: "Courseware Developer",
        start: "May 2021",
        end: "Present",
        highlights: (
            "Refactored entire university-wide Django site, upgrading SQLite to Postgres, adding HTMX on the front end",
            "Wrote first test suites for the site, added coverage, pre-commit checks, Justfile commands",
            "Collaborated with DevOps to establish deployment system (Vagrant/Ansible/Docker)",
            "Rewrote queries to Penn’s Oracle database following major database restructuring",
            "Created installable CLI application connecting to the Canvas API to run tasks for staff across the university",
            "Created scripts for archiving entire Canvas sites, reporting on tool usage, among others",
            "Audited tasks for expensive processes and implemented caching when appropriate"
        )
    ),
    (
        employer: "Vanguard",
        location: "Malvern, PA",
        position: "Developer I",
        start: "April 2020",
        end: "April 2021",
        highlights: (
            "Wrote TypeScript, SCSS, unit tests for new features, bug-fixes in Angular component library",
            "Collaborated with accessibility team to ensure the library conforms to WCAG standards",
            "Provided support for internal teams consuming our library in their applications",
            "Collaborated with developers, designers, and strategists using Agile methods"
        )
    ),
    (
        employer: "Freelance",
        location: "Various",
        position: "Music Instructo & Audio Engineer",
        start: "2007",
        end: "2019",
        highlights: (
            "Taught individual lessons and group classes in piano, guitar, bass, music theory",
            "Co-produced bass guitar sample library for Orange Tree Samples (forthcoming)"
        )
    )
)

#let awards = (
    (
        title: "UPenn Models of Excellence Award (Honorable Mention)", year: "2022"
    ),
)

#let education = (
    (
        institution: "Thinkful",
        location: "Remote",
        degree: "Engineering Immersion (Full-Time)",
        year: "2019"
    ),
    (
        institution: "Peabody Institute of the Johns Hopkins University",
        locaiton: "Baltimore, MD",
        degree: "M.M.",
        year: "2013"
    ),
    (
        institution: "Sarah Lawrence College",
        location: "Bronxville, NY",
        degree: "B.A.",
        year: "2010"
    )
)

#let skills = (
    (
        name: "Front end",
        skills: (
            "TypeScript",
            "JavaScript",
            "Angular",
            "React",
            "Sass",
            "Qwik"
        )
    ),
    (
        name: "Back end",
        skills: (
            "Python",
            "Typescript",
            "JavaScript",
            "Django",
            "FastAPI",
            "Express",
            "PostgreSQL"
        )
    ),
    (
        name: "Additional",
        skills: (
            "Docker",
            "Ansible",
            "Shell",
            "Scheme",
            "Emacs Lisp",
            "SCLang (SuperCollider)",
            "LilyPond",
            "Rust"
        )
    )
)

#resume(experiences, awards, education, skills)
