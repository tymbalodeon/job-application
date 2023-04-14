#let cover-letter = yaml("../cover-letter.example.yaml")
#let resume = yaml("../resume.example.yaml")

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

#let experiences = resume.experience
#let awards = resume.awards
#let education = resume.education
#let skills = resume.skills
