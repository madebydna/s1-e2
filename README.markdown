## Notes

The unit tests will show how the system runs. Three badge types have been implemented and tested as examples of what 
is possible for an achievement system:

**A "sequential finite" type.** 

- Set number of badges available
- Different levels (bronze, silver and gold) can be earned in sequence
- Higher levels represent higher achievement
- Users past achievements are taken into consideration to determine the requirements for the next level badge
- Problematic if user's past achievements are unknown. We have to avoid the user receiving the lowest badge,
  because only the requirements for the lowest badge are checked for users w/out badges. 
- Most awarding systems seem to follow this pattern and exceptions to the rule are hard to work in when the 
  system has been mainly set up to accommodate this type of award.
  
The following two types of awards are two of many examples of possible exceptions, that seem to make 
special-casing necessary.
  
**A "sequential infinite" type**

- User gets rewarded for every nth of a particular action
- User can accumulate an infinite number of badges of this type
  
**Dynamic Badges**

- User can lose this type of match as soon as her status changes (not in the top 10% of most watched list)



-- RMU SESSION #1 | PROBLEM 2
-- Submissions due 12:00 UTC 2010.09.15

If in doubt about how to submit, see SUBMISSION_GUIDELINES file.

This week, we'll be experimenting with building a git themed achievements
system.  The emphasis of the exercise is on data modeling and requirements
discovery, so you'll need to ask questions to help get the job done.

Imagine you have just been hired by Github, and you have an idea for a brand
new feature to make working with git more fun.  You've decided it's time that
Github embraces game mechanics by rewarding users with frivolous badges for
every imaginable action under the sun.  You made your first commit, you get a
badge!  You made ten commits?  A bigger, shiny badge for you!  You've got 50
forks of your project?  Well, then you win the Bad Mother Forker badge.

While implementing achievements may seem simple, there are a number of things to
consider about performance.  The more badges you have, the more conditions you
need to check each time an event occurs that could cause a new achievement to be
attained.  That means some optimization is needed.

Here are some ideas to get you started:

* Certain achievements are dependent on others, and their conditions do not need
  to be checked until the badge they depend on is attained.  For example, if you
  have badges for 1 commit, 20 commits, and 50 commits, you don't need to run
  the check for the 50 commit badge until both 20 commits and 1 commit have been
  attained.

* Most achievements, once gained, are valid forever.  For example, a user who
  has made 50 commits will never have made less than 50 commits, so the
  condition does not need to be checked any more once the badge has been
  attained.

* However, certain badges *are* dynamic, and can be lost if certain events
  occurs.  For example, if a user has a project that is in the top 10% for 
  number of watchers, this can change over time.  But these should be treated
  as special cases rather than evaluating all conditions by default.

Your goal is to come up with a system to model the range of possibilities you
might run into if you were creating these sorts of achievements for Github.  You
can stub out the source data, but you should build a running prototype through
which you can define a list of achievements and determine whether a user has
earned them or not based on their raw stats.

This exercise is pretty open ended, but please follow the guidelines listed below.

== GUIDELINES

* You are encouraged to discuss this exercise both on IRC and the mailing list,
  and it's okay to share details about the general strategies you'll be using,
  as long as you're not giving away every last implementation detail. (I.e,
  discussion should mainly be done in words, and not code)

* The stub data you'll create is open ended, but should be enough to demonstrate
  various kinds of conditions I've mentioned in the project description, and
  possibly some others you've come up with.

* Your submissions should include runnable examples which demonstrate how your
  system works.  As a prototype, it's okay if some features are missing, but
  make sure that whatever you submit is cleaned up and relatively self-contained.

* There are likely some undiscovered requirements here, and I will be happy to
  clarify things as they come up.  Treat me as the 'customer' for the purposes
  of this exercise.

== QUESTIONS?

Hit up the mailing list or IRC.
