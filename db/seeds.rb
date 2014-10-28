## Seed the basic courses, plus some enrollment and such.

roles = ENV['ROLES'] || "['admin']"
YAML.load(roles).each do |role|
  Role.find_or_create_by(name: role)
end

CATEGORIES = [
  ["Basic Linux and Shell", "linux"],
  ["Basic Ruby", "ruby"],
  ["Basic Test Engineering", "test"],
  ["Basic Rails", "rails"],
  ["Basic Interaction Design", "interaction"],
  ["Basic Data Engineering", "data"],
  ["Engineering Principles", "engineering"],
  ["Learning the Business", "business"],
  ["Professionalism", "professionalism"],
  ["Intermediate Ruby", "ruby_2"],
  ["Intermediate Test Engineering", "test_2"],
  ["Intermediate Rails", "rails_2"],
  ["Intermediate Interaction Design", "interaction_2"],
  ["Intermediate Data Engineering", "data_2"],
  ["Engineering Principles II", "engineering_2"],
  ["Professionalism II", "professionalism_2"],
  ["Cnuapp", "cnuapp"],
  ["8 Boxes", "8boxes"],
  ["Performance and Scaling", "scaling"]
]

i = 0
CATEGORIES.each do |cat|
  Category.create! name: cat[0], handle: cat[1], sort_order: i
  i += 1
end

COURSES = [
  ["Engineering Baseline I", "baseline_1", "Learn to build and test a complete Ruby on Rails application. This isn't a basic intro: you will finish with some serious ruby chops."],
  ["Engineering Baseline II", "baseline_2", "Description"],
  ["Engineering at Enova", "enova", "Learn more about engineering as it happens at Enova."],
  ["Performance and Scaling", "scaling", "Take a realistic Rails app and learn to scale it in real world circumstances. You'll cover all the basic best practices in performance and scalability for the Rails world."],
]
COURSES.each do |course|
  Course.create! name: course[0], handle: course[1], description: course[2], status: :published
end

SKILLS = [
  ["linux", "navigation", "Understands absolute vs relative path and can navigate the filesystem"],
  ["linux", "everything_is_a_file", "Understands that everything is a file"],
  ["linux", "environment", "Understands path and environment variables"],
  ["linux", "file_permissions", "Understands Unix file permissions"],
  ["linux", "sudo", "Knows why sudo is dangerous and doesn't use it unless necessary"],
  ["linux", "monitoring_resources", "Can use htop / df / du to monitor system resources"],
  ["linux", "ports", "Knows what ports are and can use netstat to find them"],
  ["linux", "processes", "Can use ps to find daemon processes"],
  ["linux", "init_scripts", "Understands init scripts and can use init.d to start and stop services"],
  ["linux", "scp", "Can transfer files between hosts using scp"],
  ["linux", "git", "Fluently uses basic git"],
  ["linux", "monitoring", "Knows why we use zenoss / nagios"],
  ["linux", "proxies", "Knows why we use web proxies / nginx"],
  ["linux", "ntp", "Can resync time with ntp"],
  ["linux", "firewall", "Can check firewall settings with iptables"],
  ["linux", "nmap", "Can check open ports on a remote host with nmap"],

  ["ruby", "ruby_core", "Fluently uses Ruby core functions"],
  ["ruby", "comments", "Knows why comments lie, and how to write self-documenting code"],
  ["ruby", "comments2", "Knows the cases where comments are really necessary"],
  ["ruby", "fivesecond", "Knows what the five second rule for code review is"],
  ["ruby", "docs", "Knows how to find documentation for Ruby and Rails classes"],
  ["ruby", "meaningful_names", "Uses meaningful names for variables / methods / etc"],
  ["ruby", "short_methods", "Creates short methods and short lines of code"],
  ["ruby", "style_guide", "Develops according to the github style guide"],
  ["ruby", "arrowhead", "Puts errors near their test conditions (no arrowhead programming)"],

  ["ruby_2", "explodes", "Writes code that explodes early"],
  ["ruby_2", "defaults", "Creates intelligent default parameters"],
  ["ruby_2", "memoize", "Memoizes / caches expensive methods, knows why"],
  ["ruby_2", "metacode", "Fluently uses gems, modules and metacode to separate concerns"],
  ["ruby_2", "ducks", "Understands duck typing and code smells related to it"],
  ["ruby_2", "method_missing", "Understands method missing, but usually doesn't use it"],
  ["ruby_2", "eval", "Knows why eval is evil"],
  ["ruby_2", "instancevars", "Avoids instance vars, knows why"],
  ["ruby_2", "demeter", "Understands the Law of Demeter"],

  ["rails", "convention", "Understands how 'Convention Over Configuration' helps us"],
  ["rails", "basic_types", "Knows the location and purpose of models, views and controllers"],
  ["rails", "helpers", "Knows how to use view helpers to aid clarity"],
  ["rails", "rake", "Knows how to list and run rake tasks, and what things should be rake tasks"],
  ["rails", "test_conventions", "Knows the location and conventions for Rspec and Cucumber"],
  ["rails", "pry", "Can debug with pry"],
  ["rails", "active_support", "Knows about the ActiveSupport extensions to core ruby"],

  ["rails_2", "default_route", "Understands how the default rails route causes problems"],
  ["rails_2", "render", "Understands render vs redirect"],
  ["rails_2", "relationships", "Understands how to define and traverse Rails relationships"],
  ["rails_2", "thin_controllers", "Creates thin controllers, knows why"],
  ["rails_2", "formats", "Can write code to respond to different formats, knows why"],
  ["rails_2", "response_codes", "Uses HTTP response codes and HTTP verbs fluently"],
  ["rails_2", "gems", "Uses gems whenever possible, knows why, and knows what makes a good gem selection"],
  ["rails_2", "csrf", "Understands how and why to use CSRF protection and Strong Params"],
  ["rails_2", "sprockets", "Understands and uses the asset pipeline"],
  ["rails_2", "routes", "Creates meaningful routes"],
  ["rails_2", "endpoints", "Creates meaningful API endpoints"],
  ["rails_2", "junkdrawer", "Properly separates concerns (no junkdrawer files)"],
  ["rails_2", "engines", "Knows what Rails engines are, and how to use them"],
  ["rails_2", "presenters", "Understands presenters, decorators and interactors"],

  ["test", "trustno1", "Knows why we \"Don't trust the developer\""],
  ["test", "tdd_bdd", "Understands TDD and BDD"],
  ["test", "redgreen", "Understands Red -> Green -> Refactor"],
  ["test", "wanttosee", "Understands how \"writing the code you want to see\" makes for better code"],
  ["test", "flapping", "Knows why flapping tests are destructive"],
  ["test", "capybara", "Knows how Capybara and drivers work"],
  ["test", "manual", "Knows why manual testing doesn't scale"],
  ["test", "test_plans", "Writes test plans at the beginning of a task, and uses them to clarify requirements"],
  ["test", "test_types", "Uses and understands unit, functional and integration tests"],
  ["test", "paths", "Uses happy path, sad path, and error path to create test cases"],
  ["test", "meaningful", "Writes meaningful tests, and knows what tautological tests are"],
  ["test", "failtests", "Tries to make tests fail to verify that they work"],

  ["test_2", "fragile", "Writes robust tests, and knows what makes tests fragile"],
  ["test_2", "security", "Understands basic security concerns and how to test for them"],
  ["test_2", "metrix", "Uses Metrix and CI, and can read the results"],
  ["test_2", "tdd", "Consistently uses TDD outside of Cnuapp"],
  ["test_2", "exploratory", "Uses exploratory testing and timeboxing to constrain manual testing"],
  ["test_2", "cuke", "Fluently uses cucumber and rspec"],
  ["test_2", "stubs", "Uses mocks, stubs and doubles, and understands the dangers thereof"],
  ["test_2", "fixtures", "Uses fixtures, seeds and factories"],
  ["test_2", "output", "Creates meaningful test failure output"],
  ["test_2", "coverage", "Writes tests that operate in isolation, exercise the system under test and avoid double coverage."],

  ["data", "quality", "Understands data quality, and how it has bitten us in the past"],
  ["data", "sql", "Fluently uses basic SQL"],
  ["data", "explain", "Knows why and how to explain a query and check index use"],
  ["data", "apis", "Creates humane APIs, and understands that everything has an API"],
  ["data", "psql", "Can look up and use basic psql commands"],
  ["data", "column_size", "Appropriately sizes database columns"],
  ["data", "migrations", "Can write a Rails migration"],
  ["data", "calculate", "Calculates mostly everything in the database, knows why"],
  ["data", "indices", "Knows how indices work and the tradeoffs they offer"],

  ["data_2", "checklist", "Can use the patch review checklist to ensure patch quality"],
  ["data_2", "scaling", "Understands database scaling: normalization, backfills, replication"],
  ["data_2", "dml", "Understands the difference between DML and DDL, and how it breaks replication"],
  ["data_2", "roles", "Understands roles, permissions and schemata"],
  ["data_2", "clusters", "Understands postgres clusters, and how we use them"],
  ["data_2", "complexity", "Puts complexity in the right place"],
  ["data_2", "doing_work", "Writes code that does work in the right place"],
  ["data_2", "normalization", "Understands normalization and creates nearly fully normalized data"],
  ["data_2", "views", "Can create and manipulate views, and find the query that generated them"],
  ["data_2", "pii", "Protects PII and sensitive data at rest, knows why"],
  ["data_2", "indices_2", "Understands partial and functional indices in Postgres"],

  ["interaction", "smacss", "Understands the principles and ideas behind SMACSS"],
  ["interaction", "classes", "Uses semantic classes and IDs, and knows what deserves an ID"],
  ["interaction", "semantic", "Fluently uses semantic markup, knows why"],
  ["interaction", "markup", "Fluently uses basic HTML, CSS and JS"],

  ["interaction_2", "console", "Uses the Developer Console for debugging"],
  ["interaction_2", "specificity", "Understands CSS specificity and doesn't use !important"],
  ["interaction_2", "modules", "Organizes Javascript into modules, knows why"],
  ["interaction_2", "loading_time", "Knows what causes slow loading / time to render"],
  ["interaction_2", "basics_2", "Fluently uses HAML / SCSS / Coffeescript"],
  ["interaction_2", "accessibility", "Understands the purpose and techniques behind accessibility"],
  ["interaction_2", "responsive", "Understands responsive design and how to implement it"],
  ["interaction_2", "affordances", "Understands what usability and affordances are"],
  ["interaction_2", "caching", "Understands asset caching and the impact of HTTP requests."],
  ["interaction_2", "bootstrap", "Understands the intent an usage of Twitter Bootstrap"],
  ["interaction_2", "enhancement", "Understands graceful degradation and progressive enhancement"],

  ["engineering", "least_surprise", "Understands the Principle of Least Surprise"],
  ["engineering", "magic", "Doesn't use magic numbers or constants, knows why"],
  ["engineering", "commitments", "Understands commitments versus estimates"],
  ["engineering", "versioning", "Understands Semver, external APIs and breaking compatibility"],
  ["engineering", "open_source", "Knows why we contribute to Open Source"],
  ["engineering", "environments", "Knows why prod should be like development, and why it's not"],
  ["engineering", "yagni", "Employs YAGNI (and knows when to violate it)"],
  ["engineering", "dry", "Employs DRY (and knows when to violate it)"],
  ["engineering", "guards", "Considers and guards against error conditions"],
  ["engineering", "dsls", "Understands DSLs, how to create them, and their limitations"],
  ["engineering", "documentation", "Creates and maintains useful documentation for projects"],
  ["engineering", "dynamic", "Understands dangerously dynamic code"],

  ["engineering_2", "sdlc", "Understands and follows the SDLC for each codebase"],
  ["engineering_2", "boyscouts", "Follows the Boy Scout Policy for codebases"],
  ["engineering_2", "vim", "Fluently uses vim"],
  ["engineering_2", "code_review", "Does good code reviews frequently, knows what makes a good code review"],
  ["engineering_2", "pull_request", "Uses proper Pull Request format"],
  ["engineering_2", "dependencies", "Understands managing dependencies on external libraries"],
  ["engineering_2", "ci", "Understands CI and the value it provides, and why we don't use it in Cnuapp"],
  ["engineering_2", "risky", "Does the risky stuff first, knows why"],
  ["engineering_2", "estimates", "Knows how to create accurate estimates"],
  ["engineering_2", "planning", "Knows how to do basic project planning, even in Agile teams"],
  ["engineering_2", "often", "Knows how and why we structure work to deliver often, but with quality."],
  ["engineering_2", "expectations", "Knows how to manage stakeholder expectations to build trust"],
  ["engineering_2", "epg", "Understands the EPG and how we get assigned work"],

  ["business", "credit", "Understands how we create and use credit and fraud models"],
  ["business", "products", "Understands loan products and extensions, and why they change"],
  ["business", "acquisition", "Understands our customer acquisition channels, and their downsides"],
  ["business", "pnls", "Knows the name, url, platform and importance of each P&L"],
  ["business", "callcenter", "Knows how the callcenter helps us and what they help with"],
  ["business", "legal", "Understands how we interact with legal"],
  ["business", "licensing", "Understands how we get licensed in the US and UK"],
  ["business", "regulators", "Knows about our oversight organizations: CFPB, OFT, FCA"],
  ["business", "audits", "Understands what role audits play in our business, and how they affect the pipeline"],
  ["business", "business", "Understands what tradeoffs are required when you write software to run a business"],

  ["professionalism", "orgchart", "Knows where the org chart is"],
  ["professionalism", "landscape", "Knows the larger corporate landscape"],
  ["professionalism", "ambiguity", "Knows how to avoid ambiguity by asking clarifying questions"],
  ["professionalism", "email_etiquette", "Understands and uses proper email etiquette"],
  ["professionalism", "meeting_etiquette", "Understands and uses proper meeting etiquette"],
  ["professionalism", "asking", "Knows when to ask for help, and how long to struggle first"],
  ["professionalism", "preparing", "Knows how ask for help effectively and respect others' time by preparing beforehand"],
  ["professionalism", "criticism", "Hows how to accept criticism gracefully and give criticism with kindness"],
  ["professionalism", "presentation", "Understands how the image we project affects others"],
  ["professionalism", "burnout", "Understands how stress and burnout affect productivity and quality"],
  ["professionalism", "pown", "Understands what it means to \"own\" a task"],

  ["professionalism_2", "alarms", "Raises alarms early, knows why"],
  ["professionalism_2", "documents", "Documents takeaways and group decisions, knows why"],
  ["professionalism_2", "communicates", "Communicates clearly with non-technical coworkers"],
  ["professionalism_2", "opinions", "Voices opinions, especially dissenting ones when the group is wrong"],
  ["professionalism_2", "support", "Supports other team members and protects the team's reputation"],
  ["professionalism_2", "try", "Doesn't say \"I'll try\" to unreasonable requests, knows why"],
  ["professionalism_2", "presentations", "Gives professional presentations and demos"],

  ["cnuapp", "filesystem", "Knows how Cnuapp is laid out on the filesystem"],
  ["cnuapp", "suites", "Can run ALL the test suites"],
  ["cnuapp", "cnu_env ", "Understands cnu_env"],
  ["cnuapp", "qa", "Understands the db and qa repos"],
  ["cnuapp", "cnuconfig", "Knows how CnuConfig shapes app behavior"],
  ["cnuapp", "overlays", "Knows Cnuapp's structure and overlays"],
  ["cnuapp", "countries", "Understands clusters vs countries vs brands"],
  ["cnuapp", "heads", "Knows the different Rails heads"],
  ["cnuapp", "cnu_rake", "Knows common Cnuapp rake tasks"],
  ["cnuapp", "entities", "Knows about customers, loans and payment transactions"],
  ["cnuapp", "services", "Can start / stop services without a shortcut"],
  ["cnuapp", "logfiles", "Can debug with logfiles"],
  ["cnuapp", "ack", "Can search the codebase with ack"],
  ["cnuapp", "contenter", "Knows how to manipulate content with contenter"],
  ["cnuapp", "devreqs", "Uses the dev requirements template"],
  ["cnuapp", "landable", "Knows how modern frontends are served up by landable"],
  ["cnuapp", "api", "Knows about services that use Cnuapp as a service"],
  ["cnuapp", "prod_config", "Knows about the prod_config repo and its pitfalls"],
  ["cnuapp", "stable", "Knows where stable boxes are, and how to use them"],
  ["cnuapp", "patch", "Can write a Cnuapp patch and knows deploy procedures for patches"],

  ["8boxes", "principles", "Understands 8-box principles, \"federated services\" and SOA"],
  ["8boxes", "clients", "Knows how the box clients talk to each other"],
  ["8boxes", "concerns", "Understands the separation of concerns between the 8-boxes"],
  ["8boxes", "deployment", "Understands the 8-box build and deployment process"],
  ["8boxes", "registration", "Understands the customer registration flow and relation between portfolio, identity, etc"],
  ["8boxes", "exspec", "Understands staging tests, exspec and individual box tests"],
  ["8boxes", "nconjure", "Fluently uses nconjure and factory_girl to create test records"],
  ["8boxes", "state_machines", "Understands state machines in portfolio"],
  ["8boxes", "pow", "Can start and stop services using pow"],
  ["8boxes", "rake_8b", "Can execute common rake and db tasks across boxes"],
  ["8boxes", "mocks", "Understands how clients are mocked in different boxes for dev and testing"],
  ["8boxes", "underwriters", "Understands how underwriters work and generate loan offers"],
  ["8boxes", "tenancy", "Understands the multi-tenant vs individual strategy used in 8-boxes"],
  ["8boxes", "shared", "Knows what shared assets are and how to work with them"],
  ["8boxes", "rulesets", "Understands how rulesets work and how they override each other"],
  ["8boxes", "lifecycle", "Understands the application -> agreement -> loan lifecycle"],

  ["scaling", "remote", "Knows how to run the application in a production-like environment"],
  ["scaling", "diagnose", "Knows common tools used to diagnose performance issues"],
  ["scaling", "premature", "Understands how to tell when optimization is premature and choose appropriate optimizations"],
  ["scaling", "profile", "Uses basic load profiling tools for Rails projects"],
  ["scaling", "import", "Uses basic optimization techniques to speed up seed generation"],
  ["scaling", "loop_invariant", "Optimizes inefficient loops by moving invariants outside the loop"],
  ["scaling", "wrong_work", "Recognizes where and how to move computation into the database."],
  ["scaling", "pluck", "Uses ActiveRecord methods to limit data retrieved from the database"],
  ["scaling", "method_cache", "Understands the ruby method cache"],
  ["scaling", "denormalize", "Understands the tradeoffs in denormalizing computations"],
  ["scaling", "slow_tests", "Refactors unit tests for speed"],
  ["scaling", "scope", "Knows why default scopes can be nonperformant and can refactor them out"],
  ["scaling", "all", "Refactors controller methods to retrieve manageable data amounts"],
  ["scaling", "memoization", "Uses simple memoize techniques to cache expensive computations"],
  ["scaling", "n_plus_one", "Uses Rails' built in facilities to solve n+1 SQL loading problems"],
  ["scaling", "cache_expiry", "Configures Rails models and relationships to be suitable for caching"],
  ["scaling", "chunk_caching", "Refactors views to perform page chunk caching"],
  ["scaling", "russian_doll", "Uses Russian Doll caching to achieve several layers of caching performance"],
  ["scaling", "pagination", "Uses pagination to increase performance"],
  ["scaling", "thread", "Identifies and fix basic thread-safety issues and use threads"],
  ["scaling", "redis", "Knows why we use redis, and can use it to cache expensive calls"],
  ["scaling", "sidekiq", "Defers execution of expensive code using Sidekiq"],
  ["scaling", "mongrel", "Knows the differences between common webservers and can choose an appropriate one"],
  ["scaling", "cdn", "Configures and deploy to a CDN"],
  ["scaling", "http_cache", "Uses common HTTP caching functionality"],
]

SKILLS.each do |skill|
  begin
    cat = Category.find_by_handle! skill[0]
    Skill.create! category: cat, handle: skill[1], name: skill[2]
  rescue
    puts "failed to create skill: #{skill[2]}"
  end
end

COURSE_CATS = {
  baseline_1: ['linux', 'ruby', 'rails', 'test', 'data', 'interaction', 'engineering'],
  baseline_2: ['ruby_2', 'rails_2', 'test_2', 'data_2', 'interaction_2', 'engineering_2'],
  enova: ['business', 'cnuapp', '8boxes', 'professionalism', 'professionalism_2'],
  scaling: ['scaling'],
}
COURSE_CATS.each do |course, categories|
  categories = categories.map { |cat| Category.find_by_handle(cat).id }
  skills = Skill.where(category_id: categories)
  course = Course.find_by_handle(course)

  course.skills = skills
  course.save
end

if ENV['ADMIN_NAME']
  user = User.create(name: ENV['ADMIN_NAME'].dup,
                     email: ENV['ADMIN_EMAIL'].dup,
                     password: ENV['ADMIN_PASSWORD'].dup,
                     password_confirmation: ENV['ADMIN_PASSWORD'].dup)

  user.add_role :admin
  Course.all.each do |course|
    Enrollment.create!(course: course, user: user)
  end
end
