# LaTeX author support for the University of Pennsylvania Press journal *Observational Studies* (*OBS*)

## Table of Contents

* [About](#about)
* [Package content](#package-content)
* [Setup](#setup)
* [Recomended usage of `obs` package](#recomended-usage-of-obs-package)
* [Submission](#submission)
* [Bug reports](#bug-reports)

## About

Author support service provides LaTeX style files and `*.tex` file templates designed for University of Pennsylvania Press journal
[Observational Studies (OBS)](https://www.pennpress.org/journals/journal/observational-studies/) articles.

## Package content

The following files are given in the repository (or directly in `*.zip` archive):

* `obs.cls` - LaTeX style file designed for University of Pennsylvania Press journal articles.
  Please do not change it. This file is already loaded in the respective template files;
* `obs-template.tex` - topmatter template (should be used for article preparation);
* `obs-sample.tex` - journal sample article;
* `obs-sample.pdf` - journal sample article (`PDF` file);

## Setup
* Clone the repository or download the `*.zip` archive. Rename the package to `<your-project-name>`.
* Install `obs.cls` in your TeX system.
* Use the file `obs-template.tex` to start your article as a template.
* Use the file `obs-sample.tex` as a reference for how to prepare a topmatter of your article.

## Recommended usage of `obs` package

Use `obs-template.tex` as a template.

### LaTeX document preamble content

The preamble of your LaTeX document should look like this:

```latex
\documentclass{obs}

\begin{document}

    \begin{frontmatter}

        \title{Title}

        \begin{aug}
            \author{\inits{F.}\fnms{First} \snm{Author}\thanksref{t1}\ead{first@somewhere.com}},
            \address{Address of the First Author\\
                     Country}
            \author{\inits{S.}\fnms{Second} \snm{Author}\ead{second@somewhere.com}}
            \address{Address of the Second Author\\
                     Country}
            \author{\inits{T.~N.}\fnms{Third Name} \snm{Author}\ead{third@somewhere.com}}
            \address{Address of the Third Author\\
                     Country}
            \thankstext{t1}{Footnote to the first author with the `thankstext' command.}
        \end{aug}

        \begin{abstract}
            ...
        \end{abstract}

        \begin{keyword}
            \kwd{Sample}
            \kwd{\LaTeX}
        \end{keyword}

    \end{frontmatter}

    Your publication content

\end{document}
```

## Submission

Submit one single file as a `ZIP` archive.
Pack your root folder `<your-project-name>` with files and subfolders.

## Bug reports

Please submit bug report or feature requests at
[github](https://github.com/vtex-soft/texsupport.penn-obs/issues) page.