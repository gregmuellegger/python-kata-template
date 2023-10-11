# Start a new kata, by creating a new branch.
create name:
    git checkout -b kata/{{name}} main
    echo "# {{name}}\n\nDescription of the kata should go here." > KATA.md
    code KATA.md

# Create an attempt for a kata currently checked out.
attempt name:
    # Make sure the current branch starts with "kata/"
    [ $(git rev-parse --abbrev-ref HEAD | head -c 5) = "kata/" ]

    # Create branch with name "attempt/nameOfKata-yourName"
    git checkout -b attempt/$(git rev-parse --abbrev-ref HEAD | cut -c6-)-{{name}} HEAD

    echo "# {{name}}\n\nDescribe how you want to attempt the kata in this iteration." > ATTEMPT.md
    code ATTEMPT.md

# Forget the current attempt and switch back to main.
forget:
    # Check that we are not on main.
    ! [ $(git rev-parse --abbrev-ref HEAD) = "main" ] 

    git reset --hard
    git checkout main
