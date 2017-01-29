# Strings-Client

> Safety of the herd by Ryan Toronto (EmberMap.com)

This README outlines the details of collaborating on this Ember application.
A short introduction of this app could easily go here.

People are asking about routable components because they want to know
how to make their apps future-proof. This kind of thinking leads someone
to say, **“you should never use controllers because they’re going away”**.
But the safest place to be in Ember is in the safety of the herd.

Edward Faulkner made this point while speaking at a recent Boston Ember
meetup, and it captures one reasons I love using this framework so much:
the idea that you can code with Ember’s established conventions today,
and be safe as Ember changes in the future.

Ember developers will recognize this safety in Ember CLI, and how it’s
saved them from pouring time into a build tool that became obsolete; in
Ember Data and JSON:API, which provides a durable baseline approach for
how their backends should represent relationships, pagination,
filtering, and sorting; and in so many other decisions that they’re able
to delegate to the community.

But when Ember changes and evolves, it’s tempting to view this safety as
stagnation. We want to take advantage of new practices right away — and
as a result, we often find ourselves wanting to leave the herd.

I’ve left the herd several times. I’ve feared that if I’m not using
future patterns in my code, my applications will end up full of
technical debt. In fact, the reality is just the opposite. When I try to
predict future Ember or cargo-cult a new but unproven pattern, I dig
myself into a hole. By veering off the path, I can find myself so far
from the herd that it’s almost impossible to rejoin it. The irony is
that my current attempts to prevent future technical debt often end up
being the main causes of actual technical debt within my codebases.

The leaders of the Ember community understand this. They know that a
team paralyzed with doubt about whether they’re coding using modern
techniques won’t be able to focus on writing the best apps they can
today. And this is why changes to the framework are always accompanied
by an upgrade path for olggder apps. “The goal is not to try to guess
ahead, hack, and pretend you’re in future Ember,” Edward said. “Just
stick with the most conventional way of writing Ember apps today.” There
will be an upgrade path.

A great example of this is the upcoming change to module imports.
Although this change will affect how we write Ember in the future, none
of us need to start using this new syntax today — the [RFC][1] includes
a [migration tool][2] that will automatically convert all imports to the
new format. Everyone should continue working just as they are, and when
the new module format is ready you’ll be able to transition your app
with ease.

So, if you’re worried about future-proofing your Ember apps, trying to
anticipate future features is risky, distracting and unnecessary. Your
best bet is just sticking with the herd. But what about trying new
libraries and techniques from outside the Ember community?

The fact that Ember developers can so easily experiment with new tools
is amazing, and addons are a great way to try out new ideas long before
they end up in the framework. However, just like trying to future-proof
your app can lead to problems, leaving the herd to experiment with
cutting-edge techniques can potentially make your app harder to upgrade
in the future.

If you decide to break off from Ember’s conventions, it’s good to ask,
“Will I be able to rejoin the herd?” If not, how will that affect your
application? There’s no single right answer here. It depends on what
you’re building and who you’re working with.

Also, it can sometimes be hard to know where your application stands
relative to the herd. I often experiment with new addons or feature
flags, and in their early stages of development it’s not obvious how far
they move me away from Ember’s upgrade paths.

Even so, it would be wrong for me to say that you should never leave the
herd. Some amount of tinkering and experimentation is healthy, and we
want our community to move forward when important new ideas arrive on
the scene. As Yehuda Katz said at EmberConf 2016, “Eventually, all the
good ideas will end up in Ember.”

So if you find yourself in a situation where you’re trying to work
around Ember’s current functionality, take a step back and consider if
it’s worth veering off the path. And as for your typical everyday
development, set aside the future, focus on your app, and take comfort
in the safety of the herd.

[1]: https://github.com/emberjs/rfcs
[2]: https://github.com/emberjs/rfcs/blob/master/text/0176-javascript-module-api.md

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](https://git-scm.com/)
* [Node.js](https://nodejs.org/) (with NPM)
* [Bower](https://bower.io/)
* [Ember CLI](https://ember-cli.com/)
* [PhantomJS](http://phantomjs.org/)

## Installation

* `git clone <repository-url>` this repository
* `cd strings-client`
* `npm install`
* `bower install`

## Running / Development

* `ember serve`
* Visit your app at [http://localhost:4200](http://localhost:4200).

### Code Generators

Make use of the many generators for code, try `ember help generate` for more details

### Running Tests

* `ember test`
* `ember test --server`

### Building

* `ember build` (development)
* `ember build --environment production` (production)

### Deploying

Specify what it takes to deploy your app.

## Further Reading / Useful Links

* [ember.js](http://emberjs.com/)
* [ember-cli](https://ember-cli.com/)
* Development Browser Extensions
  * [ember inspector for chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  * [ember inspector for firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)
