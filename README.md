# Legacy Code Refactoring Codebase

Use this codebase to practise refactoring and adding tests to legacy code. This codebase is just annoying enough to be interesting, but not so painful to stop you from trying.

This codebase happened when Patrick Welsh asked Chet Hendrickson to channel his inner junior programmer to write plausibly poorly-designed code. Chet is said to have chuckled madly in the corner while he wrote it. Imagine what code would look like if a COBOL programmer wrote code in Java some time around the year 2004 and then that code was ported into 20 other programming languages.

This codebase has provided a starting point for Legacy Code Retreat events as well as various conference talks, public workshops, and training courses.

## New in 2025! (What?!)

Someone has added a branch that provides starting unit tests that all pass. **If you want the full legacy code experience, then only ever look at the `main` branch and ignore the others.** If you'd rather start with passing tests in order to focus on safe, accurate refactoring with fewer distractions, then look for other branches. As of 2025, there is only one.

## Pull Requests Welcome

This codebase is intentionally designed to be difficult to work with, but just difficult enough. It is normal for the code to look old and to demand old versions of compilers and runtime environments. Even so, if a language has genuinely become obsolete, meaning that it's very hard to install old versions of it, then please feel invited to contribute changes that keep the poor design but upgrade the runtime environment. For example, we upgraded the Java version in 2022 to require Java 11, dropping support for Java 8, JUnit 4, and Eclipse. :)
