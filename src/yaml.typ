#let resume-yaml = yaml("../resume.yaml")

#let get-section(section-name) = {
    for sections in resume-yaml {
        for section in sections {
            if section.first() == section-name {
                    section.last()
                    break
                }
            }
        }
}

#let person = get-section("person")

#let get-person-property(property-name) = {
    for property in person {
        if property-name in property.keys() {
            property.values().first()
            break
        }
    }
}
