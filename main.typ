#let configuration = yaml("configuration.yaml")
#let settings = yaml("settings.yaml")

#show link: set text(blue)

#set page(
  paper: "a4",
  margin: (
    top: 1.5cm,
    bottom: 1cm,
  )
)

#show heading: h => [
  #set text(
    size: eval(settings.font.size.heading_large),
    font: settings.font.general
  )
  #h
]

#let sidebarSection = {[
  #set par(justify: true)

  #set text(
    size: eval(settings.font.size.contacts),
    font: settings.font.minor_highlight,
  )
      
  Email: #link("mailto:" + configuration.contacts.email) \
  Phone: #link("tel:" + configuration.contacts.phone) \
  LinkedIn: #link(configuration.contacts.linkedin.url)[#configuration.contacts.linkedin.displayText] \
  GitHub: #link(configuration.contacts.github.url)[#configuration.contacts.github.displayText] \
  
  #configuration.contacts.address
  #line(length: 100%)

  = Summary

  #set text(
      eval(settings.font.size.education_description),
      font: settings.font.minor_highlight,
  )
  #configuration.summary
  
  Strong background in infrastructure, migration to cloud, and secure system design.

  = Education

  #{
    for place in configuration.education [
        #par[
          #set text(
            size: eval(settings.font.size.heading),
            font: settings.font.general,
            tracking: -0.01em,
          )
            #{
              if "to" in place and "from" in place [
                #place.from
                – #place.to \
              ] else if "arbitrary_interval" in place [
                #place.arbitrary_interval
              ]
            }
            #link(place.place.link)[#place.place.name]
        ]
        #par[
          #set text(
            eval(settings.font.size.education_description),
            font: settings.font.minor_highlight,
          )
          #{
            let description_items = ()
            if "degree" in place and "major" in place [
              #description_items.push([#place.degree~#place.major | #place.track~track])
            ]
            if "note" in place [
              #description_items.push([#place.note])
            ]
            if "final_work" in place [
              #let thesis_description = place.final_work.at("description", default: none)
              #if thesis_description != none [
                #description_items.push([*Thesis:* #thesis_description])
              ]
              #if "link" in place.final_work [
                #let thesis_link = place.final_work.link
                #let thesis_url = thesis_link.at("url", default: none)
                #let thesis_name = thesis_link.at("name", default: none)
                #if thesis_url != none and thesis_name != none [
                  #description_items.push([#link(thesis_url)[#thesis_name]])
                ]
                #if thesis_url == none and thesis_name != none [
                  #description_items.push([#thesis_name])
                ]
            ]
            ]
            if "location" in place [
              #description_items.push([#place.location])
            ]
            description_items.join(linebreak())
          }
        ]
    ]
  }

  = Skills

  #{
    for skill in configuration.skills [
      #par[
        #set text(
          size: eval(settings.font.size.description),
          tracking: -0.01em,
        )
        #set text(
          // size: eval(settings.font.size.tags),
          font: settings.font.minor_highlight,
          tracking: -0.01em,
        )
        *#skill.name*
        #linebreak()
        #skill.items.join(" • ")
      ]
    ]
  }
]}

#let mainSection = {[
  #par[
    #set text(
      size: eval(settings.font.size.heading_huge),
      font: settings.font.general,
    )
    *#configuration.contacts.name*
  ]

  #par[
    #set text(
      size: eval(settings.font.size.heading),
      font: settings.font.minor_highlight,
      top-edge: 0pt
    )
    #configuration.contacts.title
  ]

  = Experience

  #{
    for job in configuration.jobs [
      #set par(justify: false)
        #set text(
          size: eval(settings.font.size.heading),
          font: settings.font.general
        )
        *#job.position*
        #link(job.company.link)[\@  #job.company.name] \
        #job.from – #job.to

      #set text(
        size: eval(settings.font.size.description),
        font: settings.font.general
      )
      #list(..job.description)
      
      #par(
        justify: false,
        leading: eval(settings.paragraph.leading),
      )[
        #set text(
          size: eval(settings.font.size.tags),
          font: settings.font.minor_highlight
        )
        #{
          let tag_line = job.tags.join(" • ")
          tag_line
        }
      ]
    ]
  }

  = Certifications

  #{
    for certificate in configuration.certifications [
      #set par(
        justify: true,
        leading: eval(settings.paragraph.leading)
      )

      #set text(
        size: eval(settings.font.size.description),
        font: settings.font.general
      )
      - #certificate.year #certificate.from – #certificate.to \
        #link(certificate.venue.link)[#certificate.venue.name] – #link(certificate.certificate_link)[Credential]
        
        #set text(
          size: eval(settings.font.size.description),
          font: settings.font.general
        )
        #certificate.description
    ]
  }

]}

#{
  grid(
    columns: (2fr, 5fr),
    column-gutter: 3em,
    sidebarSection,
    mainSection,
  )
}
