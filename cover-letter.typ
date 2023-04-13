#import "header.typ": header

#set page(paper: "us-letter")
#set text(10pt)
#set par(justify: true)

#header
#v(-0.5em)
#line(length: 100%)
#v(0.5em)

Dear Hiring Manager,

Thank you for considering my application for the position of Senior Full-stack
Engineer, Product Engineering. Hover engineer, Jeuel Wilkerson, recommended that
I apply for this position due to my experience and interest in the ways computer
science can be applied to creative projects such as the 3D modeling offered by
Hover. I have over two years of professional experience using Python, Django,
PostgreSQL, HTMX, Angular, and TypeScript to create full stack applications and
front end libraries. Independently, I have further developed my skills by
writing command-line tools in Python and Shell for programmatically creating
music and outputting scores using LilyPond and Abjad, creating sounds using
SuperCollider, and for importing audio files to a local library and managing
their metadata. I have also contributed to Abjad, fixing a bug in the way the
LilyPond parser handled notes such as C-flat. I believe these diverse skills
combined with my continued curiosity to explore new domains makes me well suited
to supporting Hover’s mission.

My current work as Courseware Developer for the University of Pennsylvania
includes maintaining the Course Request Form, a Django full stack application
used by all of UPenn’s faculty that facilitates the requesting of course sites
in the university’s Canvas LMS instance, which I refactored from the ground up.
The site, an essential part of the day-to-day functioning of the university,
syncs its own PostgreSQL database with the university’s Oracle database to
display up-to-date course information, provides a request form with various
options with an admin system for reviewing requests, and creates course sites
via the Canvas API. As the team’s only developer, my responsibilities cover all
aspects of the technical work, including bug-fixes, proposing and developing new
features for the front and back end code, and proactively researching new
approaches to enhance and update previously instituted code. Additionally, I
establish development workflows and project best practices, provide support for
faculty and staff, and collaborate with DevOps to maintain a deployment workflow
using Vagrant, Ansible, and Docker on Linux servers.

I also created a command-line application for running Python scripts that
interface with Canvas, allowing tasks to be run more quickly by abstracting code
away behind an easy-to-use interface. Using Typer to collect existing scripts, I
designed options for dynamically changing parameters, added a config system to
manage Canvas API credentials safely yet conveniently, and provided the ability
to install the program into a user’s shell using PDM. I also added new scripts,
the most extensive of which is the “archive” command that stores entire Canvas
sites and their associated data in compressed form and provides a complete
system of sub-commands, each with their own options, to manage fetching,
unpacking, and restoring sites.

As a front end developer at Vanguard, I worked with an integrated team of
developers, designers, and strategists in an Agile environment to maintain
multiple supported versions of a proprietary front end component library written
in Angular/TypeScript. I collaborated within the team as well as externally,
conferring with designers, pair programming with other developers, communicating
with the accessibility team, and providing real-time and asynchronous support
for application teams consuming our library.

Thanks again for your consideration. I would be happy to discuss my
qualifications further.

Sincerely, \
#emph[Ben Rosen]
