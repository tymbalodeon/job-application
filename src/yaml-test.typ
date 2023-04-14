#let get-section(section-name) = {
    for resume in yaml("resume.yaml") [
        #for section in resume {
            if section.first() == section-name {
                for property in section.last() {
                    section
                    break
                }
            }
        }
    ]
}

#get-section("education")
