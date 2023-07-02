#let settings = yaml("settings.yaml")

#let cover-letter = yaml(settings.cover-letter-content)
#let resume = yaml(settings.resume-content)

#let convert-to-array(item) = {
    if type(item) == "array" {
        item
    } else {
        (item,)
    }
}

#let resume-tags = convert-to-array(settings.tags)

#let cover-letter-content = {
    for paragraph in cover-letter [
        #paragraph

    ]
}

#let person = resume.person

#let name = person.name
#let email = person.email
#let phone = person.phone
#let github = person.github
#let city = person.city

#let is-empty(tags) = {
    let result = true

    for tag in tags {
        if tag not in (none, "") {
            result = false
            break
        }
    }

    result
}

#let include-experience(experience) = {
    let experience-tags = convert-to-array(experience.tags)
    let result = true

    if not is-empty(experience-tags) {
        for tag in experience-tags {
            if tag not in resume-tags {
                result = false
                break
            }
        }
    }

    result
}

#let experiences = {
    let experiences = resume.experience

    if is-empty(resume-tags) {
        experiences
    } else {
        experiences.filter(include-experience)
    }
}
#let awards = resume.awards
#let education = resume.education
#let skills = resume.skills
