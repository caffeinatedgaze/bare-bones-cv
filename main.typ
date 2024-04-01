#let configuration = yaml("configuration.yaml")
#let settings = yaml("settings.yaml")

#show link: set text(blue)

#show heading: h => [
  #set text(
    size: eval(settings.font.size.heading_large),
    font: settings.font.general
  )
  #h
]

#let sidebarSection = {[
  #par(justify: true)[

    #par[
      #set text(
        size: eval(settings.font.size.contacts),
        font: settings.font.minor_highlight,
      )
      
      Email: #link("mailto:" + configuration.contacts.email) \
      Phone: #link("tel:" + configuration.contacts.phone) \
      LinkedIn: #link(configuration.contacts.linkedin.url)[#configuration.contacts.linkedin.displayText] \
      GitHub: #link(configuration.contacts.github.url)[#configuration.contacts.github.displayText] \
      
      #configuration.contacts.address
    ]
    #line(length: 100%)
  ]

  = Summary

  #par[
    #set text(
        eval(settings.font.size.education_description),
        font: settings.font.minor_highlight,
    )
    An experienced *software engineer* with a confident grasp of *infrastructure*, *system design*, and *DevOps*, now seeking opportunities to excel in the realms of solution architecture.

    Open to roles ranging from *software engineering* to *DevOps/SRE*.
  ]

  = Education

  #{
    for place in configuration.education [
        #par[
          #set text(
            size: eval(settings.font.size.heading),
            font: settings.font.general
          )
            #place.from – #place.to \
            #link(place.university.link)[#place.university.name]
        ]
        #par[
          #set text(
            eval(settings.font.size.education_description),
            font: settings.font.minor_highlight,
          )
          #place.degree #place.major \
          #place.track track
        ]
    ]
  }

  = Skills

  #{
    for skill in configuration.skills [
      #par[
        #set text(
          size: eval(settings.font.size.description),
        )
        #set text(
          // size: eval(settings.font.size.tags),
          font: settings.font.minor_highlight,
        )
        *#skill.name* 
        #linebreak()
        #skill.items.join(" • ")
      ]
    ]
  }
]}

#let mainSection = {[

  // #par[
  //   #set align(center)
  //   #figure(
  //     image("images/Kodak 20 Zanvoort Lumi.jpg", width: 6em),
  //     placement: top,
  //   )
  // ]

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
      #par(justify: false)[
        #set text(
          size: eval(settings.font.size.heading),
          font: settings.font.general
        )
          #job.from – #job.to \
          
          *#job.position*
          #link(job.company.link)[\@  #job.company.name]    
      ]
      #par(
        justify: false,
        leading: eval(settings.paragraph.leading)
      )[
        #set text(
          size: eval(settings.font.size.description),
          font: settings.font.general
        )
        #{
          for point in job.description [
            #h(0.5cm) • #point \
          ]
        }
      ]
      #par(
        justify: true,
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



  = Hackathons

  #{
    for hack in configuration.hackathons [
      #par(
        justify: true,
        leading: eval(settings.paragraph.leading)
      )[
        #par[
          #set text(
            size: eval(settings.font.size.heading),
            font: settings.font.general
          )
          - #hack.year #hack.from – #hack.to \
            #link(hack.hackathon.link)[#hack.hackathon.name] – #link(hack.certificate_link)[Credential]
        ]
        #par[
          #set text(
            size: eval(settings.font.size.description),
            font: settings.font.general
          )
          #hack.description
        ]
      ]
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